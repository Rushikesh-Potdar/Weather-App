//
//  Weather.swift
//  WeatherApp
//
//  Created by Mac on 06/03/22.
//

import Foundation

struct WeatherData : Decodable{
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Weather : Decodable{
    let id : Int
}

struct Main : Decodable {
    let temp : Double
}
