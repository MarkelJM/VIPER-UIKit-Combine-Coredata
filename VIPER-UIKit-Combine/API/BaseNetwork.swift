//
//  BaseNetwork.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import Foundation
import Combine

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
    
    /*
    func getHeroesRequest() -> URLRequest {
        let urlPath = "/characters"
        let urlApi = "\(baseURL)\(urlPath)?ts=\(apiTimestamp)&apikey=\(apiKey)&hash=\(apiHash)&orderBy=-modified"
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = HTTPMethods.get
        return request
    }
     */
    
    func getHeroesRequest() -> AnyPublisher<[Hero], Error> {
        let urlPath = "/characters"
        let urlApi = "\(baseURL)\(urlPath)?ts=\(apiTimestamp)&apikey=\(apiKey)&hash=\(apiHash)&orderBy=-modified"
        guard let url = URL(string: urlApi) else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .handleEvents(receiveOutput: { data in
                    print(String(data: data, encoding: .utf8) ?? "Invalid data")  ///comprobamos datos
                })
            .decode(type: HeroeWelcome.self, decoder: JSONDecoder())
            .map { $0.data.results }
            .eraseToAnyPublisher()
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
    
    
    /*probando problemas en la lista:*/
    private var cancellables = Set<AnyCancellable>()

    mutating func testGetHeroesRequest() {
        getHeroesRequest()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching heroes: \(error)")
                case .finished:
                    print("Finished fetching heroes")
                }
            } receiveValue: { heroes in
                for hero in heroes.prefix(10) {
                    print("Hero: \(hero)")
                }
            }
            .store(in: &cancellables)
    }
}


