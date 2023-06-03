//
//  InteractorSeries.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 28/5/23.
//

import Foundation
import Combine

protocol SeriesListInteractorInputProtocol: AnyObject {
    func fetchSeries(for hero: Hero, limit: Int) -> AnyPublisher<[Serie], Error>
}

protocol SeriesListInteractorOutputProtocol: AnyObject {
    // Any necessary interactor output goes here
}

class SeriesListInteractor: SeriesListInteractorInputProtocol {
    private let api: MarvelAPI

    init(api: MarvelAPI) {
        self.api = api
    }

    func fetchSeries(for hero: Hero, limit: Int) -> AnyPublisher<[Serie], Error> {
        let request = api.getSeriesRequest(for: hero, limit: limit)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .handleEvents(receiveOutput: { data in
                    print(String(data: data, encoding: .utf8) ?? "Invalid data")  // lo mismo que llamada api de heroe
                })
            .decode(type: SerieWelcome.self, decoder: JSONDecoder())
            .map { $0.data.results }
            .eraseToAnyPublisher()
    }
}
