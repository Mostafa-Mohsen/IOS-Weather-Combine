//
//  Constants.swift
//  Weather
//
//  Created by User on 11/05/2023.
//

import Foundation

struct Constants {
    struct URLs {
        static func weather(city: String) -> String {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=46e7f792c002f08f2deaa32bd06b362c"
        }
    }
}
