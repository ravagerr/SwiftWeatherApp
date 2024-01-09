//
//  WeatherNowView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherNowView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State private var isLoading = false
    @State private var temporaryCity = ""
    var body: some View {
        
        VStack{
            HStack{
                Text("Change Location")

                TextField("Enter New Location", text: $temporaryCity)
                    .onSubmit {

                        weatherMapViewModel.city = temporaryCity
                        Task {
                            do {
                                // write code to process user change of location ✅
                                try await weatherMapViewModel.getCoordinatesForCity(city: temporaryCity)
                                if let lat = weatherMapViewModel.coordinates?.latitude, let lon = weatherMapViewModel.coordinates?.longitude {
                                    let weatherData = try await weatherMapViewModel.loadData(lat: lat, lon: lon)
                                    DispatchQueue.main.async {
                                        weatherMapViewModel.weatherDataModel = weatherData
                                    }
                                }
                                isLoading = false
                            } catch {
                                print("Error: \(error)")
                                isLoading = false
                            }
                        }
                    }
            }
            .bold()
            .font(.system(size: 20))
            .padding(10)
            .shadow(color: .blue, radius: 10)
            .cornerRadius(10)
            .fixedSize()
            .font(.custom("Arial", size: 26))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .cornerRadius(15)
            VStack{
                HStack{
                    Text("Current Location: \(weatherMapViewModel.city)")
                }
                .bold()
                .font(.system(size: 20))
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Arial", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                let timestamp = TimeInterval(weatherMapViewModel.weatherDataModel?.current.dt ?? 0)
                let formattedDate = DateFormatterUtils.formattedDateTime(from: timestamp)
                Text(formattedDate)
                    .padding()
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 1) 

                HStack{
                   
                    // Weather Temperature Value
                    if let forecast = weatherMapViewModel.weatherDataModel {
                        VStack {
                            HStack {
                                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.current.weather[0].icon).png"))
                                    .frame(width: 50, height: 50)
                                Text(forecast.current.weather[0].weatherDescription.rawValue.capitalized)
                                    .font(.system(size: 25, weight: .medium))
                            }
                            HStack {
                                Image("temperature")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Text("Temp: \((Double)(forecast.current.temp), specifier: "%.0f") ºC") //Round to no decimal points (initially 2f)
                                    .font(.system(size: 25, weight: .medium))
                            }
                            HStack {
                                Image("humidity")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Text("Humidity: \((Double)(forecast.current.humidity), specifier: "%.0f") %")
                                    .font(.system(size: 25, weight: .medium))
                            }
                            HStack {
                                Image("pressure")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Text("Pressure: \((Double)(forecast.current.pressure), specifier: "%.0f") hPa")
                                    .font(.system(size: 25, weight: .medium))
                            }
                            HStack {
                                Image("windSpeed")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Text("Windspeed: \((Double)(forecast.current.windSpeed), specifier: "%.0f") mph")
                                    .font(.system(size: 25, weight: .medium))
                            }
                        }
                    } else {
                        Text("Temp: N/A")
                            .font(.system(size: 25, weight: .medium))
                    }
                    
                }
               
            }//VS2
        }// VS1
        .background(
            Image("sky")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.bottom, 160)
                .padding(.horizontal, -5)
                .opacity(0.7)
        )
    }
}
struct WeatherNowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowView()
    }
}
