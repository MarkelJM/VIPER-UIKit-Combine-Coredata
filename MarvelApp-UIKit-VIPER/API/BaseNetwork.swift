//
//  BaseNetwork.swift
//  MarvelApp-UIKit-VIPER
//
//  Created by Markel Juaristi on 21/5/23.
//

import Foundation

struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    static let content = "application/json"
}

struct MarvelAPI {
    private let baseURL = "https://gateway.marvel.com/v1/public"
    private let apiKey = "432e4184d35ad24e3735e1802e8901a6"
    private let apiHash = "6dc8945eb3e9ef983687e97d9ee2445b"
    private let apiTimestamp = "1"
    
    func getHeroesRequest() -> URLRequest {
        let urlPath = "/characters"
        let urlApi = "\(baseURL)\(urlPath)?ts=\(apiTimestamp)&apikey=\(apiKey)&hash=\(apiHash)&orderBy=-modified"
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = HTTPMethods.get
        return request
    }

    func getSeriesRequest(for hero: Hero, limit: Int) -> URLRequest {
        let urlPath = "/characters/\(hero.id)/series"
        let urlApi = "\(baseURL)\(urlPath)?ts=\(apiTimestamp)&apikey=\(apiKey)&hash=\(apiHash)&orderBy=-modified&limit=\(limit)"
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = HTTPMethods.get
        return request
    }

    func getImageRequest(for thumbnail: HeroeThumbnail) -> URLRequest? {
        guard let imagePath = thumbnail.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let imageExtension = thumbnail.thumbnailExtension else {
            debugPrint("Error: No se pudo obtener la URL de la imagen")
            return nil
        }
        let imageUrlString = "\(imagePath).\(imageExtension)"
        
        guard let imageUrl = URL(string: imageUrlString) else {
            debugPrint("Error: No se pudo crear la URL de la imagen")
            return nil
        }
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
}
