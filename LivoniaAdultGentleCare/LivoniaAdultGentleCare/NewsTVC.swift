//
//  NewsTVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/10/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

enum Display {
   case ofIntest
   case update
}

class NewsTVC: UITableViewController {
   fileprivate let ofIntrestCellId = "IntrestCellId"
   fileprivate let updateCellId = "UpdateCellId"
   
   fileprivate let postManager = PostManager.sharedInstance
   
   var display: Display = .ofIntest {
      didSet { tableView.reloadData() }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.estimatedRowHeight = 292.0
   }
   
   // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return display == .ofIntest ? postManager.interestPosts?.count ?? 0 : postManager.updatePosts?.count ?? 0
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return cell(forRowAt: indexPath)
   }
   
   func cell(forRowAt indexPath: IndexPath) -> UITableViewCell {
      
      
      
      switch display {
      case .ofIntest:
         let cell = tableView.dequeueReusableCell(withIdentifier: ofIntrestCellId, for: indexPath) as! IntrestCell
         
         cell.post = postManager.interestPosts?[indexPath.row]
         
         return cell
         
      case .update:
         let cell = tableView.dequeueReusableCell(withIdentifier: updateCellId, for: indexPath) as! UpdateCell
         
         cell.post = postManager.updatePosts?[indexPath.row]
         
         return cell
      }
   }
   
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return display == .ofIntest ? 292.0 : UITableViewAutomaticDimension
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print(display)
      print(postManager.interestPosts!)
      print(postManager.updatePosts!)
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
