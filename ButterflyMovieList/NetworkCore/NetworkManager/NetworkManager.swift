//
//  NetworkManager.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-15.
//

import Foundation
import Alamofire
class NetworkManager : ButterflyHTTPProtocol {
    
    private let baseURL = "https://api.themoviedb.org/3"
    
    // Usually, Auth tokens should be securely stored and not hardcoded. This is just for demonstration purposes.
    private let defaultHeaders: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NDU0MWY5YTc4ODZlYTFhNGIxMDJkZjNhNTY2NTI1OSIsIm5iZiI6MTc2MDU0NjMxNS44NzksInN1YiI6IjY4ZWZjZTBiZDJhNjNiM2YxYWYwYTMwZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.H7pi8PhO9yrvuQJ-Wmz0J_kPWElmTl8EkyEAqRSRTWE"
    ]
    
    func request<T>(url: String, method: HTTPMethod, parameters: [String : Any]?, headers: HTTPHeaders?, encoding: ParameterEncoding?) async throws -> T where T : Decodable {
        
        // Validate URL
        guard let requestURL = URL(string: baseURL + url) else {
            throw NetworkError.invalidURL
        }
        
        
        let encodingType: ParameterEncoding = encoding ?? (method == .get ? URLEncoding.default : JSONEncoding.default)
        let headers = headers ?? defaultHeaders
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(requestURL,
                       method: method,
                       parameters: parameters,
                       encoding: encodingType,
                       headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    if let afError = error.asAFError {
                        // 🔍 Check for decoding errors inside AFError
                        if case .responseSerializationFailed(let reason) = afError,
                           case .decodingFailed(let underlyingError) = reason {
                            continuation.resume(throwing: NetworkError.decodingError(underlyingError))
                        } else {
                            continuation.resume(throwing: NetworkError.afError(afError))
                        }
                    } else {
                        continuation.resume(throwing: NetworkError.unknown(error))
                    }
                }
            }
        }
    }
    
}
