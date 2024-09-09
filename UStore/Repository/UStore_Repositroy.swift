//
//  UStore_Repositroy.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation

protocol UStore_Repository {
    func signUp(email: String, password: String) async throws
    func signIn(email: String, password: String)async throws
    func resetPassword(email: String)async throws
    func signOut()throws
    var userIsLogin: Bool { get }
    
}

