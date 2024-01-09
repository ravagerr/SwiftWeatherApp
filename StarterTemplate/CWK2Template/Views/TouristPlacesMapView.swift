//
//  TouristPlacesMapView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct TouristPlacesMapView: View {
    @State var touristPlaces: [TouristPlaceModel] = []
    
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    
    func loadFilteredTouristPlaces() {
        if let currentCoordinates = weatherMapViewModel.coordinates {
            touristPlaces = TouristPlaceModel.filterPlaces(for: currentCoordinates)
        } else {
            touristPlaces = TouristPlaceModel.loadTouristPlaces()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if weatherMapViewModel.coordinates != nil {
                    Map(coordinateRegion: $weatherMapViewModel.region, showsUserLocation: true, annotationItems: touristPlaces) { place in
                        MapMarker(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude))
                    }
                }
                Text("Tourist Attractions in \(touristPlaces.first?.cityName ?? "N/A")")
                    .font(.title)
                List(touristPlaces, id: \.name) { place in
                    HStack {
                        Image(place.imageNames.first ?? "london-tower-1")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        Text(place.name)
                    }
                    .onTapGesture {
                        if let url = URL(string: place.link) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            loadFilteredTouristPlaces()
        }
    }
}

struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView().environmentObject(WeatherMapViewModel())
    }
}
