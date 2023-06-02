//
//  RouterHeroList.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import Foundation
import UIKit

protocol HeroesListRoutingProtocol: AnyObject {
    func presentHeroSeries(for hero: Hero)
}

class HeroesListRouter: HeroesListRoutingProtocol {
    weak var viewController: UIViewController?
    
    static func createHeroesListModule() -> UIViewController {
        let view = HeroesListViewController()
        let interactor = HeroesListInteractor(marvelAPI: MarvelAPI())
        let router = HeroesListRouter()
        let imageLoader = ImageLoader()
        let presenter = HeroesListPresenter(view: view, interactor: interactor, router: router, imageLoader: imageLoader)

        view.presenter = presenter
        router.viewController = view

        return view
    }

    
    func presentHeroSeries(for hero: Hero) {
        // Instantiate and present HeroDetailViewController here
        // you will implement this function in the future
    }
}

