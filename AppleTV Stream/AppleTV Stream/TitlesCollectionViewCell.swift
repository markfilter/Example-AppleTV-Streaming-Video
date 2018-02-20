//
//  TitlesCollectionViewCell.swift
//  AppleTV Stream
//
//  Created by Mark Filter on 2/20/18.
//  Copyright © 2018 Mark Filter. All rights reserved.
//

import UIKit

class TitlesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleImageView: UIImageView!
    
    func setImageView(url: URL) {
        NetworkUtils.fetchImageFrom(url: url) { (image) -> (Void) in
            self.titleImageView.image = image
        }
    }
    
}
