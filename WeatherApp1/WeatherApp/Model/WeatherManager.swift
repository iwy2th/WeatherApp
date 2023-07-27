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
      if error != nil {
        return
      }
      if let safeData = data {
        let dataString = String(data: safeData, encoding: .utf8)
        print(dataString!)
      }
    }
    task.resume()
    
  }
  
}
