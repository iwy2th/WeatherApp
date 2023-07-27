//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Iwy2th on 27/07/2023.
//

import Foundation
struct WeatherModel {
  let conditionID: Int
  let cityName: String
  let temperature: Double
  var tempString: String {
    return String(format: "%.1f", temperature)
  }
  var conditionName: String {
    switch conditionID {
    case 200...232: return "thunderstorm"
    case 300...321: return "cloud.drizzle"
    case 500...531: return "cloud.rain"
    case 600...622: return "cloud.snow"
    case 701...781: return "atmosphere"
    case 800: return "sun.max"
    case 801...804: return "clouds2"
    default:
      return "globe.americas"
    }
  }
}
