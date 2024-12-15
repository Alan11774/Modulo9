//
//  AuthService.swift
//  Barman
//
//  Created by Alan Ulises on 14/12/24.
//

import GoogleSignIn
import AuthenticationServices
import UIKit

class AuthService: NSObject, ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    static let shared = AuthService() // Singleton para acceso global
    
    // MARK: - Google Sign In
    func signInWithGoogle(presenting viewController: UIViewController, completion: @escaping (Result<GIDGoogleUser, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    // MARK: - Apple Sign In
    private var appleCompletion: ((Result<ASAuthorizationAppleIDCredential, Error>) -> Void)?
    
    func signInWithApple(completion: @escaping (Result<ASAuthorizationAppleIDCredential, Error>) -> Void) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.delegate = self
        authController.performRequests()
        
        self.appleCompletion = completion
    }
    
    // MARK: - ASAuthorizationController Delegate
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            appleCompletion?(.success(appleIDCredential))
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleCompletion?(.failure(error))
    }
}
