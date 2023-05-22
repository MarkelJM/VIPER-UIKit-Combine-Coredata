//
//  LoginRouter.swift
//  MarvelApp-UIKit-VIPER
//
//  Created by Markel Juaristi on 22/5/23.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    static func createLoginModule() -> UIViewController
    func closeLoginInterface(from view: LoginViewProtocol)
}

class LoginRouter: LoginRouterProtocol {
    static func createLoginModule() -> UIViewController {
        let view = LoginView()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorProtocol = LoginInteractor()
        let router: LoginRouterProtocol = LoginRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter

        return view
    }

    func closeLoginInterface(from view: LoginViewProtocol) {
        if let sourceView = view as? UIViewController {
            sourceView.dismiss(animated: true, completion: nil)
        }
    }
}


