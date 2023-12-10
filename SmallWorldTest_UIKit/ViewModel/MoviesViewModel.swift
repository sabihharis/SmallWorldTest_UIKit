//
//  MoviesViewModel.swift
//  SmallWorldTest_UIKit
//
//  Created by Sabih Haris on 10/12/2023.
//

import Foundation

struct MoviesViewModel {
    
    func getMovies(completion: @escaping(_ result: MovieResponse?)-> Void) {
        
        let moviesResources = MoviesResources()
        moviesResources.getMovies { result in
            _ = completion(result)
        }
    }
    
    func getMovieById(id:Int,completion: @escaping(_ result: MovieDetailResponse?)-> Void) {

        let employeeRequest = MovieRequest(movieId: id)
        let employeeResource = MoviesResources()
        
        employeeResource.getMovieDetailsById(movieRequest: employeeRequest) { result in
            _ = completion(result)

        }

    }
}

