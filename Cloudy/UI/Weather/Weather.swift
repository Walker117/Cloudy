//
//  Weather.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/24/21.
//

import SwiftUI

struct Weather<ViewModel>: View where ViewModel: WeatherViewModel {
    
    let viewModel: ViewModel
    
    @State private var header: WeatherHeaderModel?
    @State private var models: [ShortForecastModel] = []
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            background
            content
        }
        .onAppear {
            viewModel.fetchWeather($header, $models, $isLoading)
        }
    }
    
    var content: some View {
        VStack {
            if isLoading {
                progressView
            } else {
                headerView
                shortForecast
                Spacer()
            }
        }
    }
    
    var progressView: some View {
        ProgressView("Loading...")
            .tint(.white)
            .foregroundColor(.white)
            .font(.title)
    }
    
    var headerView: some View {
        VStack(spacing: 0) {
            Text(header?.cityName ?? "")
                .font(.system(size: 32))
                .padding(.top, 105)
            
            Text(header?.status ?? "")
            
            Text(header?.temperature ?? "")
                .font(.system(size: 100))
                .fontWeight(.thin)
                .overlay(temperatureIcon, alignment: .topTrailing)
        }
        .foregroundColor(.lightBlue)
    }
    
    var shortForecast: some View {
        ShortTermForecast(models: $models)
    }
    
    var temperatureIcon: some View {
        Text("°")
            .font(.system(size: 72))
            .fontWeight(.thin)
            .offset(x: 20)
    }
    
    var background: some View {
        Image("golden_gate")
            .resizable()
            .ignoresSafeArea()
    }
}

struct Weather_Previews: PreviewProvider {
    static var previews: some View {
        Weather(viewModel: PreviewWeatherViewModel())
    }
}
