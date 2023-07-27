//
//  ViewController.swift
//  WeatherApp
//
//  Created by Iwy2th on 26/07/2023.
//

import UIKit

class ViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperaturelLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  var weatherManager = WeatherManager()
  // MARK: - ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherManager.delegate = self
  }
  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
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
     weatherManager.fetchWeather(cityName: city)
    }
  }
}
extension ViewController: WeatherManagerDelegate {
  func didFailWithError(error: Error) {
    print(error)
  }
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
    
  }
}

