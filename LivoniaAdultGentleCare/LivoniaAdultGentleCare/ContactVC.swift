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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textViews.forEach { (textView) in
            textView.textContainerInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        }
        
//        textLabels.forEach { (label) in
//            label.baselineAdjustment = .alignBaselines
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
