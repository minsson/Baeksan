//
//  NetworkingManager.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//

import Foundation
import Combine
import SwiftUI

class NetworkingManager : ObservableObject {
    
    enum NetworkingError: LocalizedError {
        case badURLRespose(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLRespose(url: let url): return "[🔥] Bad response from url : \(url)"
            case .unknown: return "[🥳] Unknown error occured"
            }
        }
    }
    
    static func postData(url: URL, json: [String: Any], completionHandler: @escaping (_ data: Data?) -> ()) {
        // method, body, requests
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in

            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error data.")
                completionHandler(nil)
                return
            }

            completionHandler(data)
        }.resume()
    }
    
    static func postDataWithJWT(url: URL, json: [String: Any], completionHandler: @escaping (_ data: Data?) -> ()) {
        // method, body, requests
        print(json)
        let token = UserDefaults.standard.string(forKey: "jwt") ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in

            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error data.")
                completionHandler(nil)
                return
            }

            completionHandler(data)
        }.resume()
    }
    
    
    
    static func patchDataWithJWT(url: URL, json: [String: Any], completionHandler: @escaping (_ data: Data?) -> ()) {
        // method, body, requests
        let token = UserDefaults.standard.string(forKey: "jwt") ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in

            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error data.")
                completionHandler(nil)
                return
            }

            completionHandler(data)
        }.resume()
    }
    
    static func patchWithJWT(url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        // method, body, requests
        let token = UserDefaults.standard.string(forKey: "jwt") ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(token, forHTTPHeaderField: "x-access-token")

        URLSession.shared.dataTask(with: request) { data, response, error in

            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error data.")
                completionHandler(nil)
                return
            }

            completionHandler(data)
        }.resume()
    }
    
    static func getNaverAPI(url: URL) -> AnyPublisher<Data, Error> {
        let clientID = "6BFXoGb073zt6ZnYYNa9"
        let token = "u7bSPGeoDd"
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(token, forHTTPHeaderField: "X-Naver-Client-Secret")

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLRespose(output: $0, url:url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static func getDataWithJWT(url: URL) -> AnyPublisher<Data, Error> {
        let token = UserDefaults.standard.string(forKey: "jwt") ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "x-access-token")

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLRespose(output: $0, url:url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func getData(url: URL) -> AnyPublisher<Data, Error> {

        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLRespose(output: $0, url:url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func deleteData(url: URL) -> AnyPublisher<Data, Error> {
        let token = UserDefaults.standard.string(forKey: "jwt") ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(token, forHTTPHeaderField: "x-access-token")

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLRespose(output: $0, url:url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    static func handleURLRespose(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let respose = output.response as? HTTPURLResponse,
              respose.statusCode >= 200 && respose.statusCode < 300 else {
            throw NetworkingError.badURLRespose(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
