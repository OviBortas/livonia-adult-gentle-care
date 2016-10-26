//
//  NewsVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/17/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    fileprivate var newsTVC: NewsTVC!

    @IBOutlet weak var horizontalBar: UIView!
    
//    let pManager = PostManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Determin in which direction the translation should be
        let isOnLefHand = horizontalBar.frame.origin.x < view.bounds.size.width / 2
        var translationX = horizontalBar.bounds.width * 2
        translationX = isOnLefHand ? translationX.negated() : translationX
        
        // Create and animate the translation
        horizontalBar.transform = CGAffineTransform(translationX: translationX, y: 0)
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
            self.horizontalBar.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
    @IBAction func ofIntrestButtonTappred(_ sender: UIButton) {
        animateHorizontalBar(to: sender)
        newsTVC.display = .ofIntest
      
      
    }
    
    @IBAction func updatesTapped(_ sender: UIButton) {
        animateHorizontalBar(to: sender)
        newsTVC.display = .update
      
    }
    
    fileprivate func animateHorizontalBar(to destination: UIButton) {
        let identifier = "AlignCenterX"
        // Locate the constraint and gaurd for nil value
        let constraintX = horizontalBar.constraintsAffectingLayout(for: .horizontal).first{ $0.identifier == identifier }
        guard let constraint = constraintX else {
            print("Found no constraint at", #function, #line)
            return
        }
        
        // Remove old constraint and add new constraint
        constraint.isActive = false
        horizontalBar.removeConstraint(constraint)
        
        let newConstraint = horizontalBar.centerXAnchor.constraint(equalTo: destination.centerXAnchor, constant: 0)
        newConstraint.identifier = identifier
        newConstraint.isActive = true
        
        
        // Animate the constraint change
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NewsTVCId" {
            if let tableView = segue.destination as? NewsTVC {
                newsTVC = tableView
            }
        }
    }

}
