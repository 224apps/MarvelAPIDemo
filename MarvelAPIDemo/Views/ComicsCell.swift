//
//  MoviesTableViewCell.swift
//  MarvelAPIDemo
//
//  Created by Abdoulaye Diallo on 9/10/18.
//  Copyright © 2018 224Apps. All rights reserved.
//

import UIKit
import Kingfisher


class ComicsCell: UITableViewCell {
    public static let reuseIdentifier = "ComicCell"
    
    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet weak var atitle: UILabel!
    @IBOutlet weak var aDescription: UILabel!
    
    public func configureWith(_ comic: Comic) {
        atitle.text = comic.title
        aDescription.text = comic.description ?? "No description available"
        aImageView.kf.setImage(with: comic.thumbnail.url, options: [.transition(.fade(0.3))])
    }
}
