//
//  JSONDecoder.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//

import Foundation

struct Decoder {
    func parse<T: Decodable>(_ data: Data, into type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        
        do {
            let decodedData = try jsonDecoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Unexpected error: \(error)")
            return nil
        }
    }
}
