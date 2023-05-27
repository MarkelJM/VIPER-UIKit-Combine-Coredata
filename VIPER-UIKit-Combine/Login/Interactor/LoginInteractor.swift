//
//  LoginInteractor.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import Foundation

protocol LoginInteractorInputProtocol: AnyObject {
    func handleStartButtonTapped()
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func didSuccessfullyHandleStartButtonTapped()
    func didFailHandlingStartButtonTapped(withError error: Error)
}

class LoginInteractor: LoginInteractorInputProtocol {
    weak var presenter: LoginInteractorOutputProtocol?

    func handleStartButtonTapped() {
        // Handle business logic
        // If business logic is successful
        presenter?.didSuccessfullyHandleStartButtonTapped()
        
        // If business logic fails
        // presenter?.didFailHandlingStartButtonTapped(withError: error)
    }
}
