//
//  HomeViewController.swift
//  SmallWorldTest_UIKit
//
//  Created by Sabih Haris on 10/12/2023.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar : UISearchBar!
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
    var searchActive : Bool = false

    
    var moviesViewModel : MoviesViewModel? = MoviesViewModel()
    var moviesTableData : [MovieResult]? = nil
    var moviesFilteredTableData : [MovieResult]? = nil

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getMoviesData()
        searchBar.delegate = self

        
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
        moviesViewModel?.getMovies { [weak self] movieResponse in
            if(movieResponse != nil) {
                self?.moviesTableData = movieResponse?.results
                self?.moviesFilteredTableData = movieResponse?.results

                DispatchQueue.main.async {
                    self?.moviesTable.reloadData()
                }
            }
            
        }
    }
    
}

// MARK: - Extensions - TableView

extension MoviesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            return self.moviesFilteredTableData?.count ?? 0
        }
        return self.moviesTableData?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: moviesCell, for: indexPath) as! MoviesTableViewCell

        if(searchActive){
            cell.bindData(data: moviesFilteredTableData?[indexPath.row])
        } else {
            cell.bindData(data: moviesTableData?[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension MoviesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController : MovieDetailViewController = MovieDetailViewController.initWithNib()
        detailViewController.movieId = moviesTableData?[indexPath.row].id ?? 0
        detailViewController.navigationTitle = moviesTableData?[indexPath.row].originalTitle ?? ""
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - Extensions - SearchBar

extension MoviesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.text = nil
        performfilter(text: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text == ""{
            performfilter(text: nil)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            performfilter(text: searchText)
            return
        }
        performfilter(text: nil)
    }
    
    private func performfilter(text:String?) {
        let searchText = text
        if let data = searchText {
            var searched_transactions = [MovieResult]()
            searched_transactions = (self.moviesTableData?.filter({( transaction : MovieResult) -> Bool in
                if ((transaction.originalTitle?.lowercased().contains(data.lowercased())) ?? false) {
                    return true
                }
                return false
            }))!
            self.searchActive = true
            self.moviesFilteredTableData = searched_transactions
        }
        else{
            resetSearch()
        }
        self.moviesTable.reloadData()
    }
    
    func resetSearch() {
        if #available(iOS 13.0, *) {
            self.searchBar.searchTextField.text = ""
        } else {
            self.searchBar.text = ""
        }
        self.searchBar.showsCancelButton = false
        self.searchActive = false
        self.moviesFilteredTableData?.removeAll()
        self.moviesFilteredTableData = nil
        self.moviesTable.reloadData()
    }
}
