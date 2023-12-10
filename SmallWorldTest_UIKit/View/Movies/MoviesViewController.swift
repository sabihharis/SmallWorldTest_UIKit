//
//  HomeViewController.swift
//  SmallWorldTest_UIKit
//
//  Created by Sabih Haris on 10/12/2023.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var moviesTable : UITableView! {
        didSet {
            moviesTable.delegate = self
            moviesTable.dataSource = self
            moviesTable.rowHeight = UITableView.automaticDimension
            moviesTable.register(UINib.init(nibName: moviesCell, bundle: nil), forCellReuseIdentifier: moviesCell)
        }
    }
    
    // MARK: - Class Level Variables
    
    private var moviesCell = "MoviesTableViewCell"
    private var navigationTitle = "Movies"
    
    let moviesViewModel : MoviesViewModel = MoviesViewModel()
    var moviesTableData : MovieResponse? = nil
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getMoviesData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationItem()
    }
    
    // MARK: - Class Level Functions
    
    func setupNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.title = navigationTitle
    }
    
    func getMoviesData() {
        moviesViewModel.getMovies { movieResponse in
            if(movieResponse != nil) {
                self.moviesTableData = movieResponse
                
                DispatchQueue.main.async {
                    self.moviesTable.reloadData()
                }
            }
            
        }
    }
    
}

// MARK: - Extensions

extension MoviesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesTableData?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: moviesCell, for: indexPath) as! MoviesTableViewCell
        cell.bindData(data: moviesTableData?.results?[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension MoviesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController : MovieDetailViewController = MovieDetailViewController.initWithNib()
        detailViewController.movieId = moviesTableData?.results?[indexPath.row].id ?? 0
        detailViewController.navigationTitle = moviesTableData?.results?[indexPath.row].originalTitle ?? ""
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
