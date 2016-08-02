//
//  CurrentWeather.swift
//  WeatherApplication-Main
//
//  Created by Paul Maxeiner on 8/2/16.
//  Copyright © 2016 Paul Maxeiner. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let humidity: Double
    let precipitationProbability: Double
    let summary: String
    let icon: UIImage
}

extension CurrentWeather: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        
        guard let temperature = JSON["temperature"] as? Double,
            humidity = JSON["humidity"] as? Double,
            precipitationProbability = JSON["precipProbability"] as? Double,
            summary = JSON["summary"] as? String
//            iconString = JSON["icon"] as? String 
            else {
                return nil
        }
        
//        let icon = WeatherIcon(rawValue: iconString).image
        
        self.temperature = temperature
        self.humidity = humidity
        self.precipitationProbability = precipitationProbability
        self.summary = summary
//        self.icon = icon
    }









