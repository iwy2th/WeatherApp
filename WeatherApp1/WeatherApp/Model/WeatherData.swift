//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Iwy2th on 27/07/2023.
//

import Foundation
struct WeatherData: Codable {
  let name: String
  let main: Main
  let weather: [Weather]
}

struct Main: Codable {
  let temp: Double
  let feels_like: Double
  let temp_min: Double
  let temp_max: Double
  let humidity: Double
}
struct Weather: Codable {
  let id: Int
  let main: String
}
