//
//  IntrestCell.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/10/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

// [.application, .normal, .disabled, .focused, .highlighted, .reserved, .selected]

class IntrestCell: UITableViewCell {
   
   var post: InterestPost? {
      didSet {
         //articleBody.titleLabel?.numberOfLines = 2
         
         authorPhoto.image = UIImage(named: "Website Icon")
         authorName.text = post?.author
         publishTime.text = post?.timeAgo
         articleImage.image = post?.articlePhoto
         articleBody.setTitle(post?.body, for: .normal)
         articleTitle.setTitle(post?.articleTitle, for: .normal)
      }
   }
   
   @IBOutlet weak var authorPhoto: UIImageView!
   @IBOutlet weak var authorName: UILabel!
   @IBOutlet weak var publishTime: UILabel!
   @IBOutlet weak var articleImage: UIImageView!
   @IBOutlet weak var articleBody: UIButton!
   @IBOutlet weak var articleTitle: UIButton!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      setupCell()
   }
   
   func setupCell() {
      authorPhoto.layer.cornerRadius = 20
      
      articleTitle.contentHorizontalAlignment = .left
      
      articleBody.titleLabel?.numberOfLines = 2
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
}
