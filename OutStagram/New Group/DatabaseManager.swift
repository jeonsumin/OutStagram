//
//  DatabaseManager.swift
//  OutStagram
//
//  Created by Terry on 2022/02/09.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    static func safeEmail(email: String) -> String {
        var safeEmail = email.replacingOccurrences(of: "@", with: "_")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "_")
        return safeEmail
    }
}
extension DatabaseManager {
    public func getDataFor(path: String, completion: @escaping (Result<Any,Error>) -> Void ){
        database.child("\(path)").observeSingleEvent(of: .value) { snapshop in
            guard let value = snapshop.value else {
                completion(.failure(DatabaseError.failedToFecth))
                return
            }
            completion(.success(value))
        }
    }
    
    public func selectUser(with email: String, completion: @escaping((Bool) -> Void )) {
        let email = DatabaseManager.safeEmail(email: email)
        
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? [String: Any] != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    public func insertUser(with user: User, completion: @escaping (Bool) -> Void) {
        let setValue = [
            "name": user.name,
            "userName" :user.username
        ]
        database.child(user.safeEmail).setValue(setValue) {error, _ in
            guard error == nil else {
                print("Database write ERROR!!!")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    public enum DatabaseError : Error {
        case failedToFecth
        
        public var localizedDescription: String{
            switch self {
            case .failedToFecth:
                return "This means blah failed"
            }
        }
    }
    
}


struct User{
    let email: String
    let name: String
    let username: String
    let password : String
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: "@", with: "_")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "_")
        return safeEmail
    }
    var profileImage: String {
        return "\(safeEmail)_profile_image.png"
    }
}
