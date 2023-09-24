//
//  WeatherEntity.swift
//  Weather
//
//  Created by User on 11/05/2023.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double?
    
    static let placeHolder: Weather = Weather(temp: nil)
}
