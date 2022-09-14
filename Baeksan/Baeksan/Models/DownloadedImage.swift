//
//  DownloadedImage.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//


import Foundation


struct ImageResponse: Codable {
    let lastBuildDate: String?
    let total, start, display: Int?
    let items: [DownloadedImage]?
}

struct DownloadedImage : Codable, Hashable {
    let title: String?
    let link: String
    let thumbnail: String
    let sizeheight, sizewidth: String?
}

