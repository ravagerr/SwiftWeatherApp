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
            ZStack(alignment: .top) {
                // Background color extending to the top of the screen
                Color(red: 184/255, green: 214/255, blue: 241/255).frame(height: 450)
                    .edgesIgnoringSafeArea(.top)
                ScrollView{
                    VStack(alignment: .leading, spacing: 16) {
                        if let hourlyData = weatherMapViewModel.weatherDataModel?.hourly {
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 10) {
                                    
                                    ForEach(hourlyData) { hour in
                                        HourWeatherView(current: hour)
                                    }
                                }
                            }
                            .frame(height: 250)
                        }
                    }
                    VStack {
                        List {
                            ForEach(weatherMapViewModel.weatherDataModel?.daily ?? []) { day in
                                DailyWeatherView(day: day)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .frame(height: 500)
                        .padding(.all, 0)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "sun.min.fill")
                            VStack{
                                Text("Weather Forecast for \(weatherMapViewModel.city)").font(.title3)
                                    .fontWeight(.bold)
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
}
