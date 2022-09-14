//
//  MountainDataService.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//


import Foundation
import CoreLocation

//TODO: 100개의 산에 대한 정보

class MountainDataService: ObservableObject  {
    
    static func loadData() -> [Location]? {
        var locations = [Location]()
        var mountains = [Mountain]()
        
        guard let url = Bundle.main.url(forResource: "mountainData", withExtension: "json")
            else {
                print("Json file not found")
                return nil
            }
        
        let data = try? Data(contentsOf: url)
        mountains = try! JSONDecoder().decode([Mountain].self, from: data!)
        
        mountains.forEach { mountain in
            let location = Location(
                title: mountain.title,
                subtitle: mountain.subtitle,
                height: mountain.height,
                address: mountain.address,
                reason: mountain.reason,
                overview: mountain.overview,
                description: mountain.description,
                transportation: mountain.transportation,
                coordinates: CLLocationCoordinate2D.init(latitude: CLLocationDegrees(mountain.latitude), longitude: mountain.longitude)
                
            )
            print(location)
            locations.append(location)
        }
        return locations
    }
}
