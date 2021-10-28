//
//  WeatherLoaderService.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/25/21.
//

import Foundation
import Combine
import SwiftUI

protocol WeatherLoaderService {
    func fetchWeather() -> Future<(WeatherHeaderModel, [ShortForecastModel]), Error>
}

enum WeatherLoaderServiceError: Error {
    case urlCreationFailure
}

class RealWeatherLoaderService: WeatherLoaderService {
    let rawDataToModelsConverter: WeatherRawDataToModelsConverter
    
    private let urlSession: URLSession
    
    private lazy var bag = Set<AnyCancellable>()
    
    init(_ rawDataToModelsConverter: WeatherRawDataToModelsConverter) {
        self.rawDataToModelsConverter = rawDataToModelsConverter
    
        self.urlSession = URLSession(configuration: .default)
    }
    
    func fetchWeather() -> Future<(WeatherHeaderModel, [ShortForecastModel]), Error> {
        Future() { promise in
            do {
                let url = try self.shortForecastUrl()
                
                self.urlSession.dataTaskPublisher(for: url)
                            .map { $0.data }
                            .decode(type: RawWeatherResponse.self, decoder: JSONDecoder())
                            .sink { completion in
                                switch completion {
                                case let .failure(error):
                                    promise(.failure(error))
                                default: break
                                }
                            } receiveValue: { [weak self] rawData in
                                guard let self = self else { return }
                            
                                promise(.success(self.rawDataToModelsConverter.rawDataToModels(rawData)))
                            }
                            .store(in: &self.bag)
            } catch let error {
                promise(.failure(error))
            }
        }
    }
}

private extension RealWeatherLoaderService {
    func shortForecastUrl() throws -> URL {
        guard let key = Bundle.main.infoDictionary?["TOMORROW_IO_API_KEY"] as? String else { throw WeatherLoaderServiceError.urlCreationFailure }
        
        let dateFormatter = ISO8601DateFormatter()
        let now = Date()
        let startDate = dateFormatter.string(from: now)
        let endDate = dateFormatter.string(from: now + 60 * 60 * 25)
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.tomorrow.io"
        components.path = "/v4/timelines"
        components.queryItems = [
            URLQueryItem(name: "location", value: "37.340760,-121.894960"),
            URLQueryItem(name: "fields", value: "temperature,cloudCover,precipitationType"),
            URLQueryItem(name: "timesteps", value: "1h"),
            URLQueryItem(name: "units", value: "imperial"),
            URLQueryItem(name: "apikey", value: key),
            URLQueryItem(name: "startTime", value: startDate),
            URLQueryItem(name: "endTime", value: endDate)
        ]
        
        guard let url = components.url else { throw WeatherLoaderServiceError.urlCreationFailure }
        
        return url
    }
}
