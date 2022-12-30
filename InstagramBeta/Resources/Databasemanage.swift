//
//  Databasemanage.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 27/12/22.
//

import FirebaseDatabase
public class DatabaseManage{
    static let shared = DatabaseManage()
    private let database = Database.database().reference()
    //MARK: - public
    public func createNewUser(with email: String, username: String, completion: (Bool)->Void){
        completion(true)
    }
    public func InsertNewUser(with email: String, username: String, completion: @escaping (Bool)-> Void){
        database.child(email.safedatabasekey()).setValue(["username":username]) { error , _ in
            if error == nil{
                completion(true)
                return
            }else{
                completion(false)
                return
            }
            
        }
    }
}
