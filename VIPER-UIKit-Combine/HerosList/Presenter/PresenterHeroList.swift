//
//  PresenterHeroList.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import Foundation
import Combine

protocol HeroesListPresentationProtocol: AnyObject {
    func viewDidLoad()
    func didSelectHero(_ hero: Hero)
}

class HeroesListPresenter: HeroesListPresentationProtocol {
    weak var view: HeroesListViewProtocol?
    var interactor: HeroesListInteractorInputProtocol
    var router: HeroesListRoutingProtocol
    var imageLoader: ImageLoaderProtocol
    private var cancellables = Set<AnyCancellable>()

    init(view: HeroesListViewProtocol, interactor: HeroesListInteractorInputProtocol, router: HeroesListRoutingProtocol, imageLoader: ImageLoaderProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.imageLoader = imageLoader
    }

    func viewDidLoad() {
        interactor.fetchHeroes()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.view?.showError(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] heroes in
                //print("Presenter received heroes: \(heroes)")
                self?.view?.updateHeroes(heroes)
            }
            .store(in: &cancellables)
    }

    func didSelectHero(_ hero: Hero) {
        router.presentHeroSeries(for: hero)
    }
}
