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
    @State var locations: [Location] = []
    @State var  mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5216871, longitude: -0.1391574), latitudinalMeters: 600, longitudinalMeters: 600)
    
    func loadFilteredTouristPlaces() {
           if let currentCoordinates = weatherMapViewModel.coordinates {
               touristPlaces = TouristPlaceModel.filterPlaces(for: currentCoordinates)
           } else {
               touristPlaces = TouristPlaceModel.loadTouristPlaces()
           }
       }
    
    var body: some View {
        NavigationView {
            VStack() {
                if weatherMapViewModel.coordinates != nil {
                    VStack(){
                        Map(coordinateRegion: $mapRegion, showsUserLocation: true)
                            .edgesIgnoringSafeArea(.top)
                    }
                }
                List{
                    HStack{
                        VStack {
                            ForEach(touristPlaces, id: \.name) { place in
                               HStack {
                                   Image(place.imageNames.first ?? "london-tower-1")
                                       .resizable()
                                       .frame(width: 100, height: 100)
                                       .cornerRadius(10)
                                   Text(place.name)
                               } .onTapGesture {
                                   print(place.link)
                                   guard let url = URL(string: place.link) else {
                                     return
                                   }
                                   UIApplication.shared.openURL(url)
                               }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            // process the loading of tourist places
            loadFilteredTouristPlaces()
        }
    }
}


struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView().environmentObject(WeatherMapViewModel())
    }
}
