//
//  Weather.swift
//  iWeather
//
//  Created by Betul Erdis on 2022-07-16.
//

import Foundation

struct MainDesc {
    
    var temperature: Double
    var feelsLike: Double
    var minTemperature: Double
    var maxTemperature: Double
    var pressure: Int
    var humidity: Float
    init(_ decoder: [String : Any]){
        self.temperature = decoder["temp"] as? Double ?? 0.0
        self.feelsLike = decoder["feels_like"] as? Double ?? 0.0
        self.minTemperature = decoder["temp_min"] as? Double ?? 0.0
        self.maxTemperature = decoder["temp_max"] as? Double ?? 0.0
        self.pressure = decoder["pressure"] as? Int ?? 0
        self.humidity = decoder["humidity"] as? Float ?? 0.0
        
    }
    
}

