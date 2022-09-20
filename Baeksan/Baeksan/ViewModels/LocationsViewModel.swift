//
//  MountainViewModel.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//

import Foundation
import MapKit
import SwiftUI
import Combine

class LocationsViewModel: ObservableObject {

    var imageSubscription: AnyCancellable?
    var cancellables = Set<AnyCancellable>()

    // All loaded locations
    @Published var locations: [Location]
    @Published var locationImages: [DownloadedImage]?
    
    // current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
            downloadImagefromNaver()
        }
    }
    
    // current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
    
    // show list of locations
    @Published var showLocationsList: Bool = false
    
    // show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    init() {
        let locations = MountainDataService.loadData()
        self.locations = locations ?? []
        self.mapLocation = (locations?.first!)!
        self.updateMapRegion(location: (locations?.first!)!)
        self.locationImages = []
        self.downloadImagefromNaver()
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func updateLocations() {
        if mapLocation.isVisited == true {
            if let idx = locations.firstIndex(of: mapLocation) {
                mapLocation = Location(title: mapLocation.title, subtitle: mapLocation.subtitle, height: mapLocation.height, address: mapLocation.address, reason: mapLocation.reason, overview: mapLocation.overview, description: mapLocation.description, transportation: mapLocation.transportation, coordinates: mapLocation.coordinates, isVisited: false)
                locations[idx] = mapLocation
            }
        } else {
            if let idx = locations.firstIndex(of: mapLocation) {
                mapLocation = Location(title: mapLocation.title, subtitle: mapLocation.subtitle, height: mapLocation.height, address: mapLocation.address, reason: mapLocation.reason, overview: mapLocation.overview, description: mapLocation.description, transportation: mapLocation.transportation, coordinates: mapLocation.coordinates, isVisited: true)
                locations[idx] = mapLocation
            }
        }
    }
    
    func updateLocations(of location: Location) {
        if location.isVisited == true {
            if let idx = locations.firstIndex(of: location) {
                let newLocation = Location(title: location.title, subtitle: location.subtitle, height: location.height, address: location.address, reason: location.reason, overview: location.overview, description: location.description, transportation: location.transportation, coordinates: location.coordinates, isVisited: false)
                locations[idx] = newLocation
            }
        } else {
            if let idx = locations.firstIndex(of: location) {
                let newLocation = Location(title: location.title, subtitle: location.subtitle, height: location.height, address: location.address, reason: location.reason, overview: location.overview, description: location.description, transportation: location.transportation, coordinates: location.coordinates, isVisited: true)
                locations[idx] = newLocation
            }
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        // get the current index
        
//        let currentIndex = locations.firstIndex { location in
//            return location == mapLocation
//        }

        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("cannot find current index in locations array!")
            return
        }
        
        // check if nextindex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // next is not vaild start from zero
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        //nextIndex is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    func downloadImagefromNaver() {
        
        guard let url = URL(
            string: "https://openapi.naver.com/v1/search/image.json?query=\(mapLocation.title)&display=3&start=1&sort=sim"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        else { return }

        imageSubscription = NetworkingManager.getNaverAPI(url: url)
            .decode(type: ImageResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedData in
//                print(returnedData)
                self?.locationImages = returnedData.items ?? []
                
                self?.imageSubscription?.cancel()
//                print(self?.locationImages)
            })
    }
}
