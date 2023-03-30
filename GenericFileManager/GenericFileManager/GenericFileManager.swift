//
//  GenericFileManager.swift
//  GenericFileManager
//
//  Created by Oktay Tanrıkulu on 30.03.2023.
//

import Foundation

enum FileError: String, Error {
    case dataFailure = "Invalid data file"
    case decodingError = "Data cannot decode"
    case encodingError = "Data cannot encode"
}

final class GenericFileManager {
    
    static let shared = GenericFileManager()
    
    private init() {}
    
    
    func readJSON<T: Decodable>(from file: String, completion: @escaping (Result<T, FileError>) -> Void) {
        guard let data = try? Data(contentsOf: getJSONPath(for: file)) else {
            completion(.failure(.dataFailure))
            return
        }
        
        print(getJSONPath(for: file))
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.decodingError))
        }
    }
    
    
    func write<T: Encodable>(to file: String, value: T, completion: @escaping (Result<Bool, FileError>) -> Void) {
        guard let data = try? JSONEncoder().encode(value) else {
            completion(.failure(.encodingError))
            return
        }
        
        do {
            try data.write(to: getJSONPath(for: file))
            completion(.success(true))
        } catch {
            completion(.failure(.dataFailure))
        }
    }
    
    
    // MARK: - Helper methods
    private func getDocPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func getJSONPath(for file: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appending(path: file)
    }
}
