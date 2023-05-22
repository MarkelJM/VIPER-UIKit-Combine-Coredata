//
//  LoginInteractor.swift
//  MarvelApp-UIKit-VIPER
//
//  Created by Markel Juaristi on 22/5/23.
//


import Foundation

protocol LoginInteractorOutputProtocol: AnyObject {
    func didLoginSuccessfully()
    func didFailToLogin(withError error: Error)
}

protocol LoginInteractorProtocol: AnyObject {
    var output: LoginInteractorOutputProtocol? { get set }
    func performLogin()
}

class LoginInteractor: LoginInteractorProtocol {
    var output: LoginInteractorOutputProtocol?

    // Perform login operations here
    func performLogin() {
        // Perform login here, then use output to inform the presenter of the result.
        // For now, I will just simulate a successful login.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.output?.didLoginSuccessfully()
        }
    }
}



