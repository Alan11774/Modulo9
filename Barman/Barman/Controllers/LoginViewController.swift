//
//  CustomLoginViewController.swift
//  Loginzes
//
//  Created by Angel Gonzalez Torres on 22/11/23.
//

import UIKit

protocol CustomLoginDelegate: AnyObject {
    func didPressSignIn()
}
class CustomLoginViewController: UIViewController, UITextFieldDelegate {
    // MARK: - UI Elements
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let emailField = UITextField()
    let passwordField = UITextField()
    let rememberMeCheckbox = UIButton()
    let forgetPasswordButton = UIButton()
    let signInButton = UIButton()
    let signUpLabel = UILabel()
    let signUpButton = UIButton()

    // MARK: - Delegate
    weak var delegate: CustomLoginDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Methods
    private func setupViews() {
        // Logo
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)

        // Title Label
        titleLabel.text = "Your Lawyer"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Subtitle Label
        subtitleLabel.text = "Please enter your email & password to access"
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)

        // Email Field
        emailField.placeholder = "email address"
        emailField.borderStyle = .roundedRect
        emailField.autocapitalizationType = .none
        emailField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailField)

        // Password Field
        passwordField.placeholder = "password"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordField)

        // Remember Me Checkbox
        rememberMeCheckbox.setTitle(" Remember me", for: .normal)
        rememberMeCheckbox.setTitleColor(.black, for: .normal)
        rememberMeCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
        rememberMeCheckbox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        rememberMeCheckbox.translatesAutoresizingMaskIntoConstraints = false
        rememberMeCheckbox.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        view.addSubview(rememberMeCheckbox)

        // Forget Password Button
        forgetPasswordButton.setTitle("Forget password?", for: .normal)
        forgetPasswordButton.setTitleColor(.systemBlue, for: .normal)
        forgetPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forgetPasswordButton)

        // Sign In Button
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = UIColor.systemBlue
        signInButton.layer.cornerRadius = 10
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        view.addSubview(signInButton)

        // Sign Up Label
        signUpLabel.text = "Don't have an account?"
        signUpLabel.font = UIFont.systemFont(ofSize: 14)
        signUpLabel.textColor = .gray
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpLabel)

        // Sign Up Button
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Logo
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),

            // Title
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            // Email Field
            emailField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 40),

            // Password Field
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 40),

            // Remember Me Checkbox
            rememberMeCheckbox.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15),
            rememberMeCheckbox.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),

            // Forget Password
            forgetPasswordButton.centerYAnchor.constraint(equalTo: rememberMeCheckbox.centerYAnchor),
            forgetPasswordButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),

            // Sign In Button
            signInButton.topAnchor.constraint(equalTo: rememberMeCheckbox.bottomAnchor, constant: 30),
            signInButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),

            // Sign Up Label
            signUpLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),

            // Sign Up Button
            signUpButton.leadingAnchor.constraint(equalTo: signUpLabel.trailingAnchor, constant: 5),
            signUpButton.centerYAnchor.constraint(equalTo: signUpLabel.centerYAnchor)
        ])
    }
    @objc private func toggleCheckbox() {
        rememberMeCheckbox.isSelected.toggle()
        if rememberMeCheckbox.isEnabled {
            print("Remember me checkbox enabled")
        }else{
            print("Remember me checkbox disabled")
        }
    }

    // MARK: - Actions
    @objc private func signInAction() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            Utils.showMessage("Please fill in all fields.")
            return
        }

        loginAction()
        delegate?.didPressSignIn()
    }
    @objc func loginAction() {
        self.view.endEditing(true)
        var message = ""
        guard let account = self.emailField.text,
              let pass = self.passwordField.text
        else {
            return
        }
        if account.isEmpty {
            message = "Por favor ingrese su correo"
        }
        else if pass.isEmpty {
            message = "Por favor ingrese su password"
        }
        if message.isEmpty {
            Services().loginService(account, pass) { dict in
                DispatchQueue.main.async {  // hay que volver al thread principal para hacer cambios en la UI
                    // TODO: agregar un activity indicator, y desactivarlo aqui
                    guard let codigo = dict?["code"] as? Int,
                          let mensaje = dict?["message"] as? String
                    else {
                        Utils.showMessage("Ocurrió un error. Reintente más tarde o contacte a servicio al cliente")
                        return
                    }
                    if codigo == 200 {
                        // TODO: Implementar con UserDefaults la comprobación de sesión iniciada
                        self.delegate?.didPressSignIn()
//                        self.performSegue(withIdentifier: "loginOK", sender:self)
                    }
                    else {
                        Utils.showMessage(mensaje)
                    }
                }
            }
            if parent != nil {
                //let localParent = parent as! LoginInterface
                //localParent.customLogin(mail:account, password:pass)
            }
        }
        else {
            Utils.showMessage(message)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
            return false
        }
        if textField == passwordField {
            passwordField.becomeFirstResponder()
            return false
        }
        return true
    }
}
