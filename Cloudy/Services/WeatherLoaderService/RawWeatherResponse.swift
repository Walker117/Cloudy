//
//  RawWeatherResponse.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/27/21.
//

import Foundation

struct RawWeatherResponse: Codable {
    struct Timelines: Codable {
        let timelines: [Timestep]
    }
    
    struct Timestep: Codable {
        let timestep: String
        let startTime: String
        let endTime: String
        let intervals: [Interval]
    }
    
    struct Interval: Codable {
        let startTime: String
        let values: Value
    }
    
    struct Value: Codable {
        let temperature: Double
        let cloudCover: Double
        let precipitationType: Int
    }
    
    let data: Timelines
}
