//
//  LoginView.swift
//  MarvelApp-UIKit-VIPER
//
//  Created by Markel Juaristi on 22/5/23.
//


import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
    func showError()
    func navigateToHomeScreen()
}

class LoginView: UIViewController, LoginViewProtocol {
    var presenter: LoginPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        presenter?.viewDidLoad()
        setupView()
    }

    func setupView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "MarvelLogo") // Reemplace "marvelLogo" con el nombre de su imagen de logotipo de Marvel
        
        let startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Iniciar", for: .normal)
        startButton.backgroundColor = .blue
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(imageView)
        self.view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            startButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }


    @objc func startButtonTapped() {
        presenter?.didTapStartButton()
    }

    func showError() {
        // Display an error message
    }

    func navigateToHomeScreen() {
        // Navigate to the Home screen
    }
}
