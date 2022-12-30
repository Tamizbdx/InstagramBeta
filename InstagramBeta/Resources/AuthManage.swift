//
//  AuthManage.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 27/12/22.
//

import FirebaseAuth

public class Authmanage{
    static let shared = Authmanage()
    // MARK: - public
    public func RegisterNewUser(username: String,email: String,password: String, completion: @escaping (Bool)->Void){
        // - check if username, email, password is available
        DatabaseManage.shared.createNewUser(with: email, username: username) { created in
            if created{
//            - create account
//            - Insert account from database
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil, result != nil else {
                    completion(false)
                    return
                    }
                DatabaseManage.shared.InsertNewUser(with: email, username: username) { insert in
                    if insert{
                        completion(true)
                        return
                    }else{
                        completion(false)
                        return
                    }
                }
                }
            }else{
                completion(false)
            }
        }
        
    }
    public func LoginUser(username: String?,email: String?,password: String, completion: @escaping (Bool) -> Void){
        if let email = email{
            //email login
            Auth.auth().signIn(withEmail: email, password: password) { Authresult, error in
                guard Authresult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }else if let username = username {
            //username login
            Auth.auth().signIn(withEmail: username, password: password) { Authresult, error in
                guard Authresult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
    //attempt to logout
    public func Logout(completion: (Bool)-> Void){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }catch{
            print(error)
            completion(false)
        }
    }
}
