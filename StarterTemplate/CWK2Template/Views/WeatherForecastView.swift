//
//  WeatherForcastView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherForecastView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 16) {
                    if let hourlyData = weatherMapViewModel.weatherDataModel?.hourly {

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 10) {

                                ForEach(hourlyData) { hour in
                                    HourWeatherView(current: hour)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        .frame(height: 180)
                    }
                    Divider()
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    VStack { 
                        List {
                            ForEach(weatherMapViewModel.weatherDataModel?.daily ?? []) { day in
                                DailyWeatherView(day: day)
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .frame(height: 500)
                        // .opacity(0.2)
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Image(systemName: "sun.min.fill")
                                VStack{
                                    Text("Weather Forecast for \(weatherMapViewModel.city)").font(.title3)
                                        .fontWeight(.bold)
                                    Text("See EPL examples from weeek 4 onwards")
                                }
                            }
                        }
                    }
        }
    }
}

struct WeatherForcastView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastView()
    }
}
