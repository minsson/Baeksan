//
//  Mountain.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//
import CoreLocation

struct MountainModel: Codable {
    let mountain: [Mountain]
}

struct Mountain: Codable {
    let title: String
    let subtitle: String // 산부제정보
    let height: Int
    let address: String
    let reason: String // 100대 명산 선정 이유
    let overview: String // 산 정보 개요 상세내용
    let description: String // 산 추가설명
    let transportation: String // 교통정보
    let latitude: Double
    let longitude: Double
}

struct Coordinate: Codable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}

struct Location: Identifiable, Equatable {
    let title: String
    let subtitle: String // 산부제정보
    let height: Int
    let address: String
    let reason: String // 100대 명산 선정 이유
    let overview: String // 산 정보 개요 상세내용
    let description: String // 산 추가설명
    let transportation: String // 교통정보
    
    let coordinates: CLLocationCoordinate2D
    var isVisited: Bool = false

    //idenfiable
    var id: String {
        //name = "Colosseum"
        //cityName = "Rome"
        //id = "ColosseumRome"
        title + String(subtitle)
    }
    
    //equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    mutating func visited() {
        isVisited.toggle()
    }
}
