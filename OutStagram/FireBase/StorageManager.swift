//
//  StoreManager.swift
//  OutStagram
//
//  Created by Terry on 2022/02/14.
//

import Foundation
import FirebaseStorage

public typealias UploadPictureCompletion = (Result<String, Error>) -> Void

class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("image/\(fileName)").putData(data, metadata: nil) { [weak self] metadata, error in
            guard let self = self else { return }
            guard error == nil else {
                print("파일 업로드 ERROR!!! ")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            self.storage.child("image/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("파일 다운로드 ERROR!!")
                    completion(.failure(StorageErrors.failedToUpload))
                    return
                }
                let urlString = url.absoluteString
                print("Download url : \(urlString)")
                completion(.success(urlString))
            }
        }
    }
    
    public func downloadURL(for path: String,completion: @escaping (Result<URL,Error>) -> Void ){
        let reference = storage.child(path)
        
        reference.downloadURL(completion: {url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            completion(.success(url))
        })
    }
    
    public enum StorageErrors: Error{
        case failedToUpload
        case failedToGetDownloadUrl
    }
}
