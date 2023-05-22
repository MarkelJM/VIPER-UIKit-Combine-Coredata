//
//  LoginPresenter.swift
//  MarvelApp-UIKit-VIPER
//
//  Created by Markel Juaristi on 22/5/23.
//


import UIKit

protocol LoginPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    func viewDidLoad()
    func didTapStartButton()
}

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?
    
    func viewDidLoad() {
        // primera accion
    }

    func didTapStartButton() {
        interactor?.performLogin()
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didLoginSuccessfully() {
        view?.navigateToHomeScreen()
    }

    func didFailToLogin(withError error: Error) {
        view?.showError()
    }
}

