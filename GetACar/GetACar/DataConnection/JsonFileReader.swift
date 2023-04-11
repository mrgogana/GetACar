//
//  JsonFileReader.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import Foundation

class JsonFileReader {
    func getData<T>(filename: String, decode: [T].Type) -> Result<[T], NetworkError> where T: Decodable {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode(decode, from: data)
                return .success(jsonResult)
              } catch {
                  return .failure(.dataError(error.localizedDescription))
              }
        } else {
            return .failure(.fileNotFound)
        }
    }
}
