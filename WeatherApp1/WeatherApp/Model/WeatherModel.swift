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
    case 200...232: return "6"
    case 300...321: return "10"
    case 500...531: return "7"
    case 600...622: return "3"
    case 701...740: return "13"
    case 742...780: return "13"
    case 741: return "4"
    case 781: return "9"
    case 800: return "1"
    case 801...804: return "2"
    default:
      return "globe.americas"
    }
  }
}
