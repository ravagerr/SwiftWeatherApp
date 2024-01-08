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
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State var locations: [Location] = []
    @State var  mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5216871, longitude: -0.1391574), latitudinalMeters: 600, longitudinalMeters: 600)
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                if weatherMapViewModel.coordinates != nil {
                    VStack(spacing: 10){
                        Map(coordinateRegion: $mapRegion, showsUserLocation: true)
                            .edgesIgnoringSafeArea(.all)
                            .frame(height: 300)
                        VStack{
                            Text("This is a locally defined map for starter template")
                            Text("A map of the user-entered location should be shown here")
                            Text("Map should also show pins of tourist places")
                        }.multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                List{
                    HStack{
                        VStack {
                            Text("Tourist place Image")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Tourist place details")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("See images in coursework spec")
                        }
                    }
                }
            }.frame(height:700)
                .padding()
        }
        .onAppear {
            // process the loading of tourist places
        }
    }
}


struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView()
    }
}
