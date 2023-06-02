//
//  RouterSeries.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 28/5/23.
//

import Foundation
import UIKit

protocol SeriesListRoutingProtocol: AnyObject {
    // para navegar, pero no es necesario aun
}

class SeriesListRouter: SeriesListRoutingProtocol {
    weak var viewController: UIViewController?
    
    static func createSeriesListModule(for hero: Hero) -> UIViewController {
            let view = SeriesListView(imageLoader: ImageLoader())
            let interactor = SeriesListInteractor(api: MarvelAPI())
            let router = SeriesListRouter()
            let presenter = SeriesListPresenter(view: view, interactor: interactor, router: router, imageLoader: ImageLoader(), hero: hero)

            view.presenter = presenter
            router.viewController = view

            return view
        }
}


