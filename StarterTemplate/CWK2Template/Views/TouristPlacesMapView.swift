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
    @State private var selectedPlace: TouristPlaceModel?
    
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
                        self.selectedPlace = place
                    }
                }
                .listStyle(PlainListStyle())
            }
            .sheet(item: $selectedPlace) { place in
                VStack {
                    Text(place.description)
                        .padding()
                        .font(.title2)
                        .bold()
                    
                    TabView {
                        ForEach(place.imageNames, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    
                    Text("Scroll to see more images")
                        .font(.subheadline)
                        .padding(.vertical, 5)
                    
                    Button(action: {
                        openMapsForDirections(to: place)
                    }) {
                        Text("Get Directions")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    Link(destination: URL(string: place.link)!) {
                        Text("Learn More")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .onAppear {
                loadFilteredTouristPlaces()
            }
        }
    }
    
    func openMapsForDirections(to place: TouristPlaceModel) {
        let destination = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let placemark = MKPlacemark(coordinate: destination)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = place.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    
    struct TouristPlacesMapView_Previews: PreviewProvider {
        static var previews: some View {
            TouristPlacesMapView().environmentObject(WeatherMapViewModel())
        }
    }
}
