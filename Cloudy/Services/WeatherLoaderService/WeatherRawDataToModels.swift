//
//  WeatherRawDataToModels.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/27/21.
//

import Foundation

protocol WeatherRawDataToModelsConverter {
    func rawDataToModels(_ rawData: RawWeatherResponse) -> (WeatherHeaderModel, [ShortForecastModel])
}

struct RealWeatherRawDataToModelsConverter: WeatherRawDataToModelsConverter {
    func rawDataToModels(_ rawData: RawWeatherResponse) -> (WeatherHeaderModel, [ShortForecastModel]) {
        let currentTemperature = rawData.data.timelines.first?.intervals.first?.values.temperature ?? 0
        let header = WeatherHeaderModel(cityName: "San Jose", status: "Mostly Cloudy", temperature: "\(Int(currentTemperature))")
        let models = generateModels(rawData)
        
        return (header, models)
    }
}

private extension RealWeatherRawDataToModelsConverter {
    func generateModels(_ rawData: RawWeatherResponse) -> [ShortForecastModel] {
        guard let intervals = rawData.data.timelines.first?.intervals else { return [] }
        
        let dateFormatter = ISO8601DateFormatter()
        let timeFormatter = DateFormatter()
        
        var models = [ShortForecastModel]()
        
        for i in 0..<intervals.count {
            let interval = intervals[i]
            let temperature = "\(Int(interval.values.temperature))" + "°"
            let isNow = i == 0
            
            var time = ""
            var amPm = ""
            
            var isNight = false
            
            if let date = dateFormatter.date(from: interval.startTime) {
                timeFormatter.dateFormat = "hh"
                time = timeFormatter.string(from: date)
                if let char = time.first, char == "0" {
                    time.remove(at: time.index(time.startIndex, offsetBy: 0))
                }
                
                timeFormatter.dateFormat = "a"
                amPm = timeFormatter.string(from: date)
                
                if let t = Int(time), (amPm == "PM" && (7...11).contains(t)) || (amPm == "AM" && (t < 7 || t == 12))  {
                    isNight = true
                }
            }
            
            let model = ShortForecastModel(time: time, amPm: amPm, temperature: temperature, isNow: isNow, cloudCoverage: interval.values.cloudCover, isNight: isNight)
            models.append(model)
        }
        
        return models
    }
}
