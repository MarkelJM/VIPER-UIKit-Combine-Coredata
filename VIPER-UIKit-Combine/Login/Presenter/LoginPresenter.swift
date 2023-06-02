//
//  LoginPresenter.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import Foundation


protocol LoginPresentationProtocol: AnyObject {
    func didTapStartButton()
}

class LoginPresenter: LoginPresentationProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    func didTapStartButton() {
        interactor?.handleStartButtonTapped()
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didSuccessfullyHandleStartButtonTapped() {
        router?.closeLogin()
    }
    
    func didFailHandlingStartButtonTapped(withError error: Error) {
        view?.showError(error)
    }
}

/*
protocol LoginPresentationProtocol: AnyObject {
    func didTapStartButton()
}

class LoginPresenter: LoginPresentationProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    func didTapStartButton() {
        interactor?.handleStartButtonTapped()
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didSuccessfullyHandleStartButtonTapped() {
        router?.navigateToHeroesList()
    }
    
    func didFailHandlingStartButtonTapped(withError error: Error) {
        view?.showError(error)
    }
}
*/
