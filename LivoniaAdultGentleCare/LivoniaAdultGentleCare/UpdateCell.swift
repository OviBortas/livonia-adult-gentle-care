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
         
         if let didView = post?.didView, didView {
            ring.image = UIImage(named: "Grey Ring")
         }
         else {
            ring.image = UIImage(named: "Blue Ring")
         }
      }
   }
   
   weak var tableView: UITableView?
   var isExpanded: Bool = false
   
   @IBOutlet weak var authorName: UILabel!
   @IBOutlet weak var publishTime: UILabel!
   @IBOutlet weak var title: UILabel!
   @IBOutlet weak var body: UILabel!
   @IBOutlet weak var ring: UIImageView!
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      tableView?.beginUpdates()
      // Selected a new cell
      if selected, !isExpanded {
         expandLabel()
         isExpanded = true
      }
      // Selected the same cell
      else if selected, isExpanded {
         collapseLabel()
         isExpanded = false
      }
      // Deselected the cell
      else {
         isExpanded = selected
         collapseLabel()
      }
      tableView?.endUpdates()
      
      // When the cell is selected and was not viewed before change ring image and save changes
      if selected, let didView = post?.didView, !didView {
         ring.image = UIImage(named: "Grey Ring")
         post?.didView = true
         PostManager.sharedInstance.saveChanges()
      }
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      body.numberOfLines = 4
   }
   
   func expandLabel() {
      body.numberOfLines = 0
      
   }
   
   func collapseLabel() {
      body.numberOfLines = 4
   }
}
