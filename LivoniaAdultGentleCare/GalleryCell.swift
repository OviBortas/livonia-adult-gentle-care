//
//  GalleryCell.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/20/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
   
   @IBOutlet weak var imageView: UIImageView!
   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var detailView: UIView!
   
   var cellData: GalleryData! {
      didSet {
         // Setup gallery cover
         if cellData.title != "None" {
            imageView.image = cellData.displayImg
            titleLabel.text = cellData.title
         }
         else {
            // Setup bottom logo
            imageView.image = cellData.displayImg
            detailView.isHidden = true
            imageView.alpha = 0.6
            isUserInteractionEnabled = false
         }
      }
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      addShadow()
   }
   
   func addShadow() {
      layer.shadowColor = UIColor.gray.cgColor
      layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
      layer.shadowOpacity = 1.0
      layer.masksToBounds = false
   }
}
