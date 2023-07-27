//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Iwy2th on 27/07/2023.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
  func didFailWithError(error: Error)
}
struct WeatherManager {
  var delegate: WeatherManagerDelegate?
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=da7b016355b3f72d6ea6b160ba32f859&units=metric"
  func fetchWeather(cityName: String) {
    let urlString = "\(weatherURL)&q=\(cityName)"
    performRequest(urlString: urlString)
    print(urlString)
  }
  func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
    print(urlString)
    performRequest(urlString: urlString)
  }
  func performRequest(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in
      if error != nil {
        self.delegate?.didFailWithError(error: error!)
        return
      }
      if let data {
        if let weather = self.parseJson(weatherData: data) {
          self.delegate?.didUpdateWeather(self, weather: weather)
        }
      }
    }
    task.resume()
  }
  // ParseJson
  func parseJson(weatherData data: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    do {
       let decodedData = try decoder.decode(WeatherData.self, from: data)
      let temp = decodedData.main.temp
      let tempMin = decodedData.main.temp_min
      let tempMax = decodedData.main.temp_max
      let humidity = decodedData.main.humidity
      let feelLike = decodedData.main.feels_like
      let id = decodedData.weather[0].id
      let name = decodedData.name
      let weatherModel = WeatherModel(conditionID: id, cityName: name, temperature: temp, feelsLike: feelLike, tempMin: tempMin, tempMax: tempMax, humidity: humidity)
      return weatherModel
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }
  
}
