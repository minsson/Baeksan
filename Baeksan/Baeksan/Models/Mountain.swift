//
//  Mountain.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//

import CoreLocation

struct Mountain: Decodable {
    let title: String
    let subtitle: String // 산부제정보
    let height: Int
    let address: String
    let reason: String // 100대 명산 선정 이유
    let overview: String // 산 정보 개요 상세내용
    let description: String // 산 추가설명
    let transportation: String // 교통정보
    let location: Coordinate
}

struct Coordinate: Codable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}
