//
//  ContentView.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/22/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // TODO: Use DI
        Weather(viewModel: RealWeatherViewModel(RealWeatherLoaderService(RealWeatherRawDataToModelsConverter())))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
