//
//  GalleryDisplayCell.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/1/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class GalleryDisplayCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    var imgName: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        //imgView.image = UIImage(named: imgName)
    }

    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        imgView.image = UIImage(named: imgName)
//    }
    
}
