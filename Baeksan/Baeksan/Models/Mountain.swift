//
//  Mountain.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//

import Foundation

//TODO: - Mountain 모델 데이터 구현


import Foundation

struct Content: Decodable {
    let name: String
    let imageName: String
    let shortDescription: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageName = "image_name"
        case shortDescription = "short_desc"
        case description = "desc"
    }
}
