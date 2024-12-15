//
//  LoginInterface.swift
//  Barman
//
//  Created by Ángel González on 07/12/24.
//

import Foundation
import UIKit
import AuthenticationServices
import GoogleSignIn

class LoginInterface: UIViewController, CustomLoginDelegate, ASAuthorizationControllerPresentationContextProviding {
    // MARK: - Activity Indicator
    let actInd = UIActivityIndicatorView(style: .large)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Reutilizar CustomLoginViewController
        let loginVC = CustomLoginViewController()
        loginVC.delegate = self // Configura el delegado
        
        // Agregar como vista hija
        self.addChild(loginVC)
        loginVC.view.frame = CGRect(x: 0, y: 45, width: self.view.bounds.width, height: self.view.bounds.height * 0.5)
        self.view.addSubview(loginVC.view)

        // Botón para AppleID
        let appleIDBtn = ASAuthorizationAppleIDButton()
        self.view.addSubview(appleIDBtn)
        appleIDBtn.center = self.view.center
        appleIDBtn.frame.origin.y = loginVC.view.frame.maxY + 10
        appleIDBtn.addTarget(self, action: #selector(appleBtnTouch), for: .touchUpInside)

        // Botón para Google
        let googleBtn = GIDSignInButton(frame: CGRect(x: 0, y: appleIDBtn.frame.maxY + 10, width: appleIDBtn.frame.width, height: appleIDBtn.frame.height))
        googleBtn.center.x = self.view.center.x
        self.view.addSubview(googleBtn)
        googleBtn.addTarget(self, action: #selector(googleBtnTouch), for: .touchUpInside)
    }

    // MARK: - Delegate Implementation
    func didPressSignIn(email: String, password: String) {
        print("Email: \(email), Password: \(password)")
        // Aquí puedes implementar tu lógica de autenticación
        Utils.showMessage("Attempting login with email: \(email)")
    }

    // MARK: - Apple ID Login
    @objc func appleBtnTouch() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.performRequests()
    }

    // MARK: - Google Login
    @objc func googleBtnTouch() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if let error = error {
                Utils.showMessage("Error: \(error.localizedDescription)")
            } else {
                guard let user = result?.user else { return }
                print("Google User: \(user.profile?.name ?? ""), Email: \(user.profile?.email ?? "")")
            }
        }
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
