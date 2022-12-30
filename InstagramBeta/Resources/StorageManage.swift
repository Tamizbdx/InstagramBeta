//
//  StorageManage.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 27/12/22.
//

import FirebaseStorage

public class StorageManage{
    static let shared = StorageManage()
    private let bucket = Storage.storage().reference()
    
    public enum StorageManagerError: Error{
        case failtoDownload
    }
    //MARK: - public
    public func Uploadpost(model: Userpost, completion: (Result<URL, Error>)-> Void) {
    
    }
    
    public func downloadimage(with reference: String, completion: @escaping (Result<URL, StorageManagerError>)-> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failtoDownload))
                return
            }
            completion(.success(url))
        }
    }
    
}

public enum UserpostType{
    case photo,video
}

public struct Userpost {
    let posttype: UserpostType
}

