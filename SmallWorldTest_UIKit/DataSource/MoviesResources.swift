//
//  MoviesResources.swift
//  SmallWorldTest_UIKit
//
//  Created by Sabih Haris on 10/12/2023.
//

import Foundation

struct MoviesResources {
    func getMovies(completion: @escaping(_ result : MovieResponse?) -> Void) {
        let requestManager = RequestManager()
        let moviesEndpoint = "\(ApiEndpoints.allMovies)?api_key=\(ApiKey.key)"
        let requestUrl = URL(string:moviesEndpoint)!

        requestManager.getData(requestUrl: requestUrl, resultType: MovieResponse.self) { (moviesApiResponse) in
            _ = completion(moviesApiResponse)
        }
    }
}
