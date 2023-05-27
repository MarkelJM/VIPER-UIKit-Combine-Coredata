//
//  SeriesModel.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import Foundation

struct SerieWelcome: Codable {
    let data: SerieDataClass
}

struct SerieDataClass: Codable {
    let results: [Serie]
}

struct Serie: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: SerieThumbnail
}

struct SerieThumbnail: Codable {
    let path: String
    let thumbnailExtension: String?

    enum SerieCodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
