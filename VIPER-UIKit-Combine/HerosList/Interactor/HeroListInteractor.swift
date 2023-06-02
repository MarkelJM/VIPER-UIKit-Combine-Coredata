//
//  HeroListInteractor.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import Foundation
import Combine

protocol HeroesListInteractorInputProtocol: AnyObject {
    func fetchHeroes() -> AnyPublisher<[Hero], Error>
}

class HeroesListInteractor: HeroesListInteractorInputProtocol {
    private let marvelAPI: MarvelAPI
    private var cancellables = Set<AnyCancellable>()
    
    init(marvelAPI: MarvelAPI) {
        self.marvelAPI = marvelAPI
    }
    /*
    func fetchHeroes() -> AnyPublisher<[Hero], Error> {
        return marvelAPI.getHeroesRequest().eraseToAnyPublisher()
    }
     */
    func fetchHeroes() -> AnyPublisher<[Hero], Error> {
        return marvelAPI.getHeroesRequest()
            .receive(on: DispatchQueue.main)
            .map { result in
                print("API Response: \(result)") // Imprime la respuesta de la API
                print("Interactor received API response: \(result)") //es lo mismo de arriba, pero comprobar si los demas prinst no aparecen por limitacion de carcateres o porque no llega
                return result
            }
            .eraseToAnyPublisher()
    }

}
