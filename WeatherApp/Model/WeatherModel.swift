//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Mac on 06/03/22.

import Foundation

struct WeatherModel {
    let conditionId : Int
    let temp : Double
    let cityName : String
    var temperatureString : String{
        return String(format : "%.1f", temp)
    }
    
    var conditionName : String {
        switch conditionId {
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        case 500...531:
            return "cloud.drizzle.fill"
        case 600...622:
            return "snow"
        case 701...781:
            return "tornado"
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        default:
            return "cloud"
        }
    }

}
