//
//  PageControlView.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/6/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

protocol PageControlViewDelegate {
    func pageControlView(_ pageControllView: PageControlView, didselectItemAt indexPath: IndexPath)
}

class PageControlView: UIView, PageControlViewDelegate {
    
    var delegate: PageControlViewDelegate!
    var index = 0
    
    fileprivate let imgNames: [String]!
    fileprivate var _currentVisibleIndex: Int? = 0
    var currentVisibleIndex: Int? {
        didSet {
            
            guard let currentVisibleIndex = currentVisibleIndex else { return }
            
            switch currentVisibleIndex {
            case 0:
                horizontalBarLeftAnchorConstraint.constant = 0.0 // set it back to its original position
            case 1 ... imgNames.count:
                let spaceSize = CGFloat(currentVisibleIndex) * stackViewSpacing
                horizontalBarLeftAnchorConstraint.constant = (imgHeight * CGFloat(currentVisibleIndex)) + spaceSize
            default:
                print("Out of range?")
            }
            
            hView.setNeedsLayout()
            
            UIView.animate(withDuration: 0.15, delay: 0.0, options: [.beginFromCurrentState, .curveEaseInOut], animations: {
                self.layoutIfNeeded()
                }, completion: nil )

            _currentVisibleIndex = currentVisibleIndex
        }
    }
    
    
    fileprivate let imgHeight: CGFloat = 50.0
    
    fileprivate var hView: UIView!
    fileprivate let hViewHeight: CGFloat = 4.0
    
    fileprivate var horizontalBarLeftAnchorConstraint: NSLayoutConstraint!
    
    fileprivate var stackView: UIStackView!
    fileprivate let stackViewSpacing: CGFloat = 2.0
    
    lazy var stackViewWidth: CGFloat = {
        
        return self.stackView.frame.width
    }()
    
    init(imgNames: [String]) {
        self.imgNames = imgNames
        
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let tabBar = (parentViewController?.parent?.parent as? TabBarController)?.tabBar else {
            print("Could not grab parent TabBarController")
            return
        }
        
        var imgViews: [UIButton] = [UIButton]()
        
        // Setup images to display in pagecontrol
        var buttonIndex = 0
        imgNames.forEach { (name) in
            
            let button = UIButton(frame: .zero)
            button.setImage(UIImage(named: name), for: .normal)
            button.adjustsImageWhenHighlighted = false
            button.imageView?.contentMode = .scaleAspectFill
            button.tag = buttonIndex
            
            button.addTarget(self, action: #selector(imgTappeded(_:)), for: .touchUpInside)
            
            button.widthAnchor.constraint(equalToConstant: imgHeight).isActive = true
            
            imgViews.append(button)
            
            buttonIndex += 1
        }
        
        // Setup StackView to hold images
        stackView = UIStackView(arrangedSubviews: imgViews)
        stackView.distribution = .fill
        
        let imgSpaceing = Int(stackViewSpacing)
        stackView.spacing = stackViewSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        superview!.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: (tabBar.frame.height + 10).negated()).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: imgHeight).isActive = true
        
        stackView.widthAnchor.constraint(equalToConstant: CGFloat(((50 + imgSpaceing) * imgViews.count) - imgSpaceing)).isActive = true
        
        // Setup horizontal line under StackView
        hView = UIView(frame: .zero)
        hView.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        superview!.addSubview(hView)
        
        hView.translatesAutoresizingMaskIntoConstraints = false
        horizontalBarLeftAnchorConstraint = hView.leftAnchor.constraint(equalTo: stackView.leftAnchor)
        horizontalBarLeftAnchorConstraint.isActive = true
        hView.heightAnchor.constraint(equalToConstant: hViewHeight).isActive = true
        hView.widthAnchor.constraint(equalToConstant: imgHeight).isActive = true
        hView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4.0).isActive = true
        
        hView.layer.cornerRadius = hViewHeight / 2.0
    }
    
    @objc fileprivate func imgTappeded(_ sender: UIButton) { // need @objc becuase of fileprvate
        // Change button to selected index
        let indexTapped = IndexPath(item: sender.tag, section: 0)
        delegate?.pageControlView(self, didselectItemAt: indexTapped)
    }
    
    func pageControlView(updateHorizontalBarConstraint scrollViewContentX: CGFloat, collectionViewWidth viewSize: CGFloat) {
        horizontalBarLeftAnchorConstraint.constant = ((stackViewWidth / viewSize) * scrollViewContentX) / CGFloat(imgNames.count)
    }
}


extension PageControlView {
    func pageControlView(_ pageControllView: PageControlView, didselectItemAt indexPath: IndexPath) {
    }
}


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
