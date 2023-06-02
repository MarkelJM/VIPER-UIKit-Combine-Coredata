//
//  PresenterSeries.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 28/5/23.
//

import Foundation
import UIKit
import Combine

protocol SeriesListPresentationProtocol: AnyObject {
    func viewDidLoad()
}

class SeriesListPresenter: SeriesListPresentationProtocol {
    weak var view: SeriesListViewProtocol?
    var interactor: SeriesListInteractorInputProtocol
    var router: SeriesListRoutingProtocol
    var imageLoader: ImageLoaderProtocol
    private var cancellables = Set<AnyCancellable>()
    private let hero: Hero

    init(view: SeriesListViewProtocol, interactor: SeriesListInteractorInputProtocol, router: SeriesListRoutingProtocol, imageLoader: ImageLoaderProtocol, hero: Hero) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.imageLoader = imageLoader
        self.hero = hero
    }

    func viewDidLoad() {
        interactor.fetchSeries(for: hero, limit: 5)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.view?.showError(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] series in
                self?.view?.updateSeries(series)
            }
            .store(in: &cancellables)
    }
}

