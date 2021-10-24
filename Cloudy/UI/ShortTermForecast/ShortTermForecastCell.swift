//
//  ShortTermForecastCell.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/24/21.
//

import SwiftUI

struct ShortTermForecastCell: View {
    
    let viewModel: ShortForecastModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(spacing: 0) {
            timeView
            
            Image(systemName: "cloud.fill")
                .padding(.top, 17)
            
            Text(viewModel.temperature)
                .fontWeight(viewModel.isNow ? .semibold : .regular)
                .padding(.top, 20)
        }
        .foregroundColor(.lightBlue)
    }
    
    var timeView: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(viewModel.isNow ? "Now" : viewModel.time)
                .fontWeight(viewModel.isNow ? .semibold : .regular)
            
            if !viewModel.isNow {
                Text(viewModel.amPm.uppercased())
                    .font(.subheadline)
            }
        }
    }
}

struct ShortTermForecastCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.secondary
            
            ShortTermForecastCell(viewModel: ShortForecastModel(time: "7", amPm: "am", temperature: "59°", isNow: true))
                .frame(height: 100)
        }
        .ignoresSafeArea()
    }
}
