//
//  UStore_Repositroy.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation

protocol UStore_Repository {
    func signUp(email: String, password: String)
    func signIn(email: String, password: String)
    func resetPassword(email: String)
    func signOut()
    var authCallback: AuthCallback { get }
    var userIsLogin: Bool { get }
}

