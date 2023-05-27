//
//  LoginView.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func showError(_ error: Error)
}

class LoginViewController: UIViewController, LoginViewProtocol {
    var presenter: LoginPresentationProtocol?

    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.setTitle("Iniciar", for: .normal)
            startButton.backgroundColor = .blue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        presenter?.didTapStartButton()
    }
    
    func showError(_ error: Error) {
        // Show error to user
    }
}
