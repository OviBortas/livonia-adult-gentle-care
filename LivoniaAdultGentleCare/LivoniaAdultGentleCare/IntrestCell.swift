//
//  InterestCell.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/10/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit


class InterestCell: UITableViewCell {
   
   var post: InterestPost? {
      didSet {
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
      authorPhoto.layer.cornerRadius = 14
      articleTitle.contentHorizontalAlignment = .left
      articleBody.titleLabel?.numberOfLines = 2
      articleTitle.alpha = 0.6
   }
   
   @IBAction func showArticleInWeb(_ sender: UIButton) {
      if let url = post?.articleURL {
         UIApplication.shared.openURL(url)
      }
   }
}
