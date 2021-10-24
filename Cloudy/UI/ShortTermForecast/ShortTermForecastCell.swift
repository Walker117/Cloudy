//
//  ShortTermForecastCell.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/24/21.
//

import SwiftUI

struct ShortTermForecastCell: View {
    
    @State var time = "7"
    @State var amPm = "am"
    @State var temperature = "59°"
    @State var isNow = true
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(spacing: 0) {
            timeView
            
            Image(systemName: "cloud.fill")
                .padding(.top, 17)
            
            Text(temperature)
                .fontWeight(isNow ? .semibold : .regular)
                .padding(.top, 20)
        }
        .foregroundColor(.lightBlue)
    }
    
    var timeView: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(isNow ? "Now" : time)
                .fontWeight(isNow ? .semibold : .regular)
            
            if !isNow {
                Text(amPm.uppercased())
                    .font(.subheadline)
            }
        }
    }
}

struct ShortTermForecastCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.secondary
            
            ShortTermForecastCell()
                .frame(height: 100)
        }
        .ignoresSafeArea()
    }
}
