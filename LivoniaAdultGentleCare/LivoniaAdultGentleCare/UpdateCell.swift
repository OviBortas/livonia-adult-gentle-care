//
//  UpdateCell.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/10/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class UpdateCell: UITableViewCell {
   
   var post: UpdatePost? {
      didSet {
         authorName.text = post?.author
         publishTime.text = post?.timeAgo
         title.text = post?.title
         body.text = post?.body
      }
   }
   
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var publishTime: UILabel!
   @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
