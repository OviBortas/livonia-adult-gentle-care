//
//  NewsTVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/10/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

enum Display {
   
   case ofInterest
   case update
}

class NewsTVC: UITableViewController {
   
   fileprivate let ofInterestCellId = "InterestCellId"
   fileprivate let updateCellId = "UpdateCellId"
   fileprivate let cellHeight: CGFloat = 326.0
   fileprivate let postManager = PostManager.sharedInstance
   fileprivate var lastSelectedIndex: IndexPath? = nil
   
   var display: Display = .update {
      didSet {
         //Reloads the tableview data when a NEW category is selected
         if oldValue != display {
            let animationDirection: UITableViewRowAnimation = oldValue == .update ? .left : .right
   
            tableView.reloadSections(IndexSet(integer: 0), with: animationDirection)
         }
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.estimatedRowHeight = cellHeight
   }
   
   // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return display == .ofInterest ? postManager.interestPosts?.count ?? 0 : postManager.updatePosts?.count ?? 0
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return newCell(forRowAt: indexPath)
   }
   
   func newCell(forRowAt indexPath: IndexPath) -> UITableViewCell {
      switch display {
      case  .ofInterest:
         let cell = tableView.dequeueReusableCell(withIdentifier: ofInterestCellId, for: indexPath) as! InterestCell
         cell.post = postManager.interestPosts?[indexPath.row]
         return cell
      case .update:
         let cell = tableView.dequeueReusableCell(withIdentifier: updateCellId, for: indexPath) as! UpdateCell
         cell.post = postManager.updatePosts?[indexPath.row]
         
         if cell.tableView == nil {
            cell.tableView = tableView
         }
         return cell
      }
   }
   
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return display == .ofInterest ? cellHeight : UITableViewAutomaticDimension
   }
   
   /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
   
   /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    // Delete the row from the data source
    tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
   
   /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    
    }
    */
   
   /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
   
   /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
   
}
