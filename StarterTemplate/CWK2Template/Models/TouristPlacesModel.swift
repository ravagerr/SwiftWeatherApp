//
//  TouristPlacesModel.swift
//  CWK2Template
//
//  Created by Kristiyan Kanchev on 09/01/2024.
//

import Foundation
import CoreLocation

struct TouristPlaceModel: Codable, Identifiable {
    let id = UUID()
    let name: String
    let cityName: String
    let latitude: Double
    let longitude: Double
    let description: String
    let imageNames: [String]
    let link: String
    
static func loadTouristPlaces() -> [TouristPlaceModel] {
    guard let url = Bundle.main.url(forResource: "places", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        return []
    }
    do {
        let touristPlaces = try JSONDecoder().decode([TouristPlaceModel].self, from: data)
        return touristPlaces
    } catch {
        print(error)
        return []
    }
}
    
static func filterPlaces(for coordinates: CLLocationCoordinate2D, within radius: CLLocationDistance = 10000) -> [TouristPlaceModel] {
        let allPlaces = loadTouristPlaces()
        let currentLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)

        return allPlaces.filter { place in
            let placeLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
            return placeLocation.distance(from: currentLocation) < radius
        }
    }
}

