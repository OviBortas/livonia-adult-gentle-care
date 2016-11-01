//
//  ContactVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/17/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {
   
   @IBOutlet var textViews: [UITextView]!
   @IBOutlet var textLabels: [UILabel]!
   @IBOutlet var socialIcons: [UIImageView]!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      fixLayoutForSmallerScreen()
      
      socialIcons.forEach { icon in
         icon.layer.cornerRadius = 4
         icon.clipsToBounds = true
      }
   }
   
   /*
    Adjust constraint to be closer to the leading margin for smaller screens else the
    objects on screen will be too close to the leading edge.
    */
   func fixLayoutForSmallerScreen() {
      // Is iPhone 5 or lower
      if UIScreen.main.bounds.width <= 320.0 {
         for constraint in view.constraints where constraint.identifier == "PhoneLeadingAnchor" {
            constraint.constant = 20.0
         }
      }
   }
}
