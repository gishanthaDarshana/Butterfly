//
//  HTTPProtocol.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-15.
//

import Foundation
import Alamofire

protocol ButterflyHTTPProtocol {
    // genaric async network request
    func request<T: Decodable>(
            url: String,
            method: HTTPMethod,
            parameters: [String : Any]?,
            headers: HTTPHeaders?,
            encoding: ParameterEncoding?
        ) async throws -> T
    
}
