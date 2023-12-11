//
//  MovieDetailViewController.swift
//  SmallWorldTest_UIKit
//
//  Created by Sabih Haris on 10/12/2023.
//

import UIKit

class MovieDetailViewController: UIViewController {


    // MARK: - Outlets

    @IBOutlet weak var moviePoster : UIImageView!
    @IBOutlet weak var movieName : UILabel!
    @IBOutlet weak var movieLanguage : UILabel!
    @IBOutlet weak var movieStatus : UILabel!
    @IBOutlet weak var movieReleaseDate : UILabel!

    // MARK: - Class Level Variables

    var movieId = 0
    var navigationTitle = ""
    let moviesViewModel : MoviesViewModel = MoviesViewModel()
    var movieData : MovieDetailResponse? = nil
    
    // MARK: - View Life Cycle


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = false
        
        getData()
    }
    
    deinit {
        print("MovieDetailViewController is deinitialized successfully")
    }


    // MARK: - Class Level Fuctions
 
    private func getData() {
        moviesViewModel.getMovieById(id: self.movieId) { [weak self] result in
            self?.movieData = result
            DispatchQueue.main.async {
                self?.setData()

            }
        }
    }
    
    private func setData() {
        moviePoster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movieData?.posterPath ?? "")"), placeholder: UIImage(named: "placeholder"))

        movieName.text = "Language:" + " " + (movieData?.originalLanguage ?? "")
        movieLanguage.text = "Status:" + " " + (movieData?.status ?? "")
        movieStatus.text = "Vote Count:" + " " + String(movieData?.voteCount ?? 0)
        movieReleaseDate.text = "Budget:" + " " + String(movieData?.budget ?? 0)
    }
    

}
