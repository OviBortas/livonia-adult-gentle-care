//
//  HomeVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/17/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit


class HomeVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var angleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTF: UITextView!
    @IBOutlet weak var labelLine: UIView!
    
    var data: HomeDisplayData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
        bodyTF.text = data.body
        
        labelLine.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                labelLine.layer.cornerRadius = constraint.constant / 2
            }
        }
        
        labelLine.layer.shadowColor = labelLine.backgroundColor?.withAlphaComponent(0.8).cgColor
        labelLine.layer.shadowOffset = CGSize(width: 0, height: 0)
        labelLine.layer.shadowOpacity = 1.0
    
        
        
    }
}




class View: UIView {
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        
        ctx?.beginPath()
        ctx?.move(to: CGPoint(x: bounds.origin.x, y: bounds.size.height))
        ctx?.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        ctx?.addLine(to: CGPoint(x: bounds.size.width, y: bounds.origin.y))
        ctx?.addLine(to: CGPoint(x: bounds.origin.x, y: bounds.size.height))
        ctx?.closePath()
        
        ctx?.setFillColor(UIColor.white.cgColor)
        ctx?.fillPath()
    }
}
