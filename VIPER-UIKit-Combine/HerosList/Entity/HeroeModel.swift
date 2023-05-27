//
//  HeroeModel.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import Foundation

struct HeroeWelcome: Codable {
    let data: HeroeDataClass
}

struct HeroeDataClass: Codable {
    let results: [Hero]
}

struct Hero: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: HeroeThumbnail
}

struct HeroeThumbnail: Codable {
    let path: String
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}


// MARK: - URLElement
struct HeroeURLElement: Codable {
    let type, url: String
}
