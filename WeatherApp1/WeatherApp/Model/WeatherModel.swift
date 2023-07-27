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
  let temperature: Int
  var conditionName: String {
    switch conditionID {
    case 200...232: return ""
    case 300...321: return ""
    case 500...531: return ""
    case 600...622: return ""
    case 701...781: return ""
    case 800: return ""
    case 801...804: return ""
    default:
      return "globe.americas"
    }
  }
}
