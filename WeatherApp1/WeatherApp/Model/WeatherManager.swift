//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Iwy2th on 27/07/2023.
//

import Foundation

struct WeatherManager {
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=da7b016355b3f72d6ea6b160ba32f859&units=metric"
  
  func fetchWeather(cityName: String) {
    let urlString = "\(weatherURL)&q=\(cityName)"
    performRequest(urlString: urlString)
    print(urlString)
  }
  func performRequest(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in
      if error != nil { return }
      if let data {
        self.parseJson(weatherData: data)
      }
    }
    task.resume()
  }
  // ParseJson
  func parseJson(weatherData data: Data) {
    let decoder = JSONDecoder()
    do {
       let decodedData = try decoder.decode(WeatherData.self, from: data)
      print(decodedData.main.temp)
      print(decodedData.main.feels_like)
      print(decodedData.weather[0].main)
    } catch {
      print(error)
    }
  }
  
}
