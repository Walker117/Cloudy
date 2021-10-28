//
//  WeatherViewModel.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/24/21.
//

import Foundation
import SwiftUI
import Combine

protocol WeatherViewModel: ObservableObject {
    func fetchWeather(_ header: Binding<WeatherHeaderModel?>, _ models: Binding<[ShortForecastModel]>, _ isLoading: Binding<Bool>)
}

class RealWeatherViewModel: WeatherViewModel {
    let weatherLoader: WeatherLoaderService
    
    private lazy var bag = Set<AnyCancellable>()
    
    init(_ weatherLoader: WeatherLoaderService) {
        self.weatherLoader = weatherLoader
    }
    
    func fetchWeather(_ header: Binding<WeatherHeaderModel?>, _ models: Binding<[ShortForecastModel]>, _ isLoading: Binding<Bool>) {
        weatherLoader.fetchWeather()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { value in
                header.wrappedValue = value.0
                models.wrappedValue = value.1
            }
            .store(in: &bag)
    }
}

class PreviewWeatherViewModel: WeatherViewModel {
    func fetchWeather(_ header: Binding<WeatherHeaderModel?>, _ models: Binding<[ShortForecastModel]>, _ isLoading: Binding<Bool>) {
        isLoading.wrappedValue = true
        header.wrappedValue = WeatherHeaderModel(cityName: "San Jose", status: "Mostly Cloudy", temperature: "63")
        models.wrappedValue = [ShortForecastModel(time: "7", amPm: "am", temperature: "59°", isNow: true, cloudCoverage: 0, isNight: false),
                  ShortForecastModel(time: "7", amPm: "am", temperature: "59°", isNow: false, cloudCoverage: 100, isNight: false)]
    }
}
