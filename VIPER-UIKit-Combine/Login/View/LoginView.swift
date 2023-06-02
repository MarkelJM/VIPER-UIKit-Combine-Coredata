//
//  LoginView.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//
import UIKit
import Foundation

protocol LoginViewProtocol: AnyObject {
    func showError(_ error: Error)
}



class LoginViewController: UIViewController, LoginViewProtocol {
    var presenter: LoginPresentationProtocol?
    var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButton()
        setupConstraints()
    }
    
    func setupView() {
        self.view.backgroundColor = .black
    }

    func setupButton() {
        startButton = UIButton(type: .system)
        startButton.setTitle("Iniciar", for: .normal)
        startButton.backgroundColor = .blue
        startButton.setTitleColor(.white, for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
    }
    
    func setupConstraints() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            startButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func startButtonTapped(_ sender: UIButton) {
        presenter?.didTapStartButton()
    }
    
    func showError(_ error: Error) {
        // mostrar error, pero lo hare mas tarde
    }
}


/*
class LoginView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLoginView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    let loginButtonView = {
            let button = UIButton()
            button.setTitle("Login", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .blue
            button.layer.cornerRadius = 5
        
            
        
            button.translatesAutoresizingMaskIntoConstraints = false
        
            return button
        }()
    
    
    func setUpLoginView() {
        backgroundColor = .lightGray
        
        
        addSubview(loginButtonView)
        
        NSLayoutConstraint.activate([
            
            
            loginButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            loginButtonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            loginButtonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            loginButtonView.heightAnchor.constraint(equalToConstant: 30),
            
            
            
        ])
        
        
    }
   
    
    func getLoginButtonView() -> UIButton {
        return loginButtonView
    }
    
    func getEmailView()-> UITextField {
        return usernameView
    }
    
    func getPasswordView()-> UITextField {
        return passwordView
    }
    
    func getLoggedMessage()-> UILabel {
        return loggedTextView
    }
     
}
*/
