//
//  MoviesTableViewCell.swift
//  SmallWorldTest_UIKit
//
//  Created by Sabih Haris on 10/12/2023.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage:UIImageView!
    @IBOutlet weak var movieTitle:UILabel!
    @IBOutlet weak var movieShortDesc:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage.layer.cornerRadius = movieImage.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(data:MovieResult?){
        movieImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(data?.backdropPath ?? "")"), placeholder: UIImage(named: "placeholder"))

        movieTitle.text = data?.originalTitle ?? ""
        movieShortDesc.text = data?.overview ?? ""
        movieShortDesc.numberOfLines = 0
    }
    
}
