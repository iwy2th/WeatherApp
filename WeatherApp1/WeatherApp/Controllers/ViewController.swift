//
//  ViewController.swift
//  WeatherApp
//
//  Created by Iwy2th on 26/07/2023.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var feelsLikeLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var tempMinLabel: UILabel!
  @IBOutlet weak var tempMaxLabel: UILabel!
  var weatherManager = WeatherManager()
  let locationManager = CLLocationManager()
  let userDefault = UserDefaults.standard
  var cityName: String = "LonDon"
  // MARK: - ViewDidLoad
  override func viewDidLoad() {
    print(cityName)
    super.viewDidLoad()
    weatherManager.delegate = self
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    if let city = userDefault.string(forKey: "CityName") {
      cityName = city
    }
    weatherManager.fetchWeather(cityName: cityName)
    print("*********\(cityName)")
  }
  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
  }
  @IBAction func locationPressed(_ sender: UIButton) {
    locationManager.requestLocation()
  }
}
// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
    return true
  }
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    searchTextField.text = ""
    return true
  }
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      textField.placeholder = "Enter the city name"
      return false
    }
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let city = textField.text {
     cityName = city
     weatherManager.fetchWeather(cityName: cityName)
    }
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let text = textField.text ?? ""
      let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
      let sanitizedText = replacedText.replacingOccurrences(of: " ", with: "")
      textField.text = sanitizedText
      return false
  }

}
 // MARK: - WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate {
  func didFailWithError(error: Error) {
    DispatchQueue.main.async {
      self.searchTextField.text = ""
      self.searchTextField.placeholder = "Your city is currently not supported"
    }
    print(error)
  }
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
    DispatchQueue.main.async {
      self.temperatureLabel.text = weather.tempString
      self.conditionImageView.image = UIImage(named: weather.conditionName)
      print(weather.conditionName)
      self.cityLabel.text = weather.cityName
      self.cityName = weather.cityName
      self.userDefault.set(self.cityName.replacingOccurrences(of: " ", with: ""), forKey: "CityName")
      self.tempMinLabel.text = String(format: "%.1f °C", weather.tempMin)
      self.tempMaxLabel.text = String(format: "%.1f °C",weather.tempMax)
      self.humidityLabel.text = String(format: "%.1f km/h",weather.humidity)
      self.feelsLikeLabel.text = String(format: "%.1f °C",weather.feelsLike)
    }
  }
}
 // MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      locationManager.stopUpdatingLocation()
      let lat = location.coordinate.latitude
      let lon = location.coordinate.longitude
      weatherManager.fetchWeather(latitude: lat, longitude: lon)
    }
  }
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}

