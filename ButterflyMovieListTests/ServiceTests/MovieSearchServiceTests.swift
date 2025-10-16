//
//  MovieSearchServiceTests.swift
//  ButterflyMovieListTests
//
//  Created by Gishantha Darshana on 2025-10-17.
//

import Testing
import Alamofire
@testable import ButterflyMovieList
import Foundation

class MockNetwork: ButterflyHTTPProtocol {
    
    var shouldReturnError = false
    var response: MovieSearchResponse?
    
    func request<T>(url: String, method: Alamofire.HTTPMethod, parameters: [String : Any]?, headers: Alamofire.HTTPHeaders?, encoding: (any Alamofire.ParameterEncoding)?) async throws -> T where T : Decodable {
        
        if shouldReturnError {
            throw NetworkError.invalidResponse
        }
        
        guard let response = response as? T else {
            throw NetworkError.decodingError(NSError(domain: "", code: -1, userInfo: nil))
        }
        return response
    }
    
}
struct MovieSearchServiceTests {
    
    @Test func testFetchMoviesSuccess() async throws {
        let mockNetwork = MockNetwork()
        let expectedResponse = MovieSearchResponse(page: 1, results: [], totalPages: 0, totalResults: 0)
        mockNetwork.response = expectedResponse
        let service = MovieSearchService(network: mockNetwork)
        
        let result = try await service.fetchMovies(query: "test", page: 1)
        switch result {
        case .success(let response):
            #expect(response.totalResults == 0)
        default:
            #expect(Bool(false), "Expected success but got failure")
        }
    }
    
    @Test func testFetchMoviesNetworkError() async {
        let mockNetwork = MockNetwork()
        mockNetwork.shouldReturnError = true
        let service = MovieSearchService(network: mockNetwork)
        
        do {
            _ = try await service.fetchMovies(query: "test", page: 1)
            #expect(Bool(false), "Expected failure but got success")
        } catch let error as MovieSearchError {
            switch error {
            case .networkError:
                #expect(Bool(true), "Expected network error")
            default:
                #expect(Bool(false), "Expected network error but got different error")
            }
        } catch {
            #expect(Bool(false), "Expected MovieSearchError but got different error")
        }
    }
    
    @Test func testFetchMoviesInvalidResponse() async {
        let mockNetwork = MockNetwork()
        mockNetwork.response = nil
        let service = MovieSearchService(network: mockNetwork)
        
        do {
            let result = try await service.fetchMovies(query: "test", page: 1)
            
            switch result {
                case .success(_):
                    #expect(Bool(false), "Expected failure but got success")
            case .failure(let error):
                #expect(Bool(true), "Expected failure with error: \(error)")
            }
            
        } catch let error as MovieSearchError {
            switch error {
            case .networkError(error: _):
                #expect(Bool(true), "Expected invalid response error")
            default:
                #expect(Bool(false), "Expected invalid response error but got different error")
            }
        } catch {
            #expect(Bool(false), "Expected MovieSearchError but got different error")
        }
    }
    
}
