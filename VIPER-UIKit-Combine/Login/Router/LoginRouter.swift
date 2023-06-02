//
//  LoginRouter.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import UIKit




protocol LoginRouterProtocol: AnyObject {
    func closeLogin()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createLoginModule() -> UIViewController {
        let view = LoginViewController()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let presenter = LoginPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func closeLogin() {
        viewController?.dismiss(animated: true, completion: {
            let heroesListViewController = HeroesListRouter.createHeroesListModule()
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: heroesListViewController)
        })
    }
}

/*
protocol LoginRouterProtocol: AnyObject {
    func navigateToHeroesList()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createLoginModule() -> UIViewController {
        let view = LoginViewController()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let presenter = LoginPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func navigateToHeroesList() {
        let heroesListViewController = HeroesListRouter.createHeroesListModule()
        viewController?.navigationController?.pushViewController(heroesListViewController, animated: true)
    }
     
}
*/
