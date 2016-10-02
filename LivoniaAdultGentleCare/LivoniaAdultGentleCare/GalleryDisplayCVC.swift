//
//  GalleryDisplayCVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/1/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "galleryDisplayCell"

class GalleryDisplayCVC: UICollectionViewController {
    
    var imgNames: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageControl()
    }
    
    func imgTappeded(_ sender: UIButton) {
        
        print(sender.tag)
    }
    
    func setupPageControl() {
        guard let tabBar = (parent?.parent as? TabBarController)?.tabBar else {
            print("could not grab parent TabBarController")
            return
        }
        
        let imgHeight: CGFloat = 50.0
        
        
        var imgViews: [UIButton] = [UIButton]()
        
        var buttonIndex = 0
        imgNames.forEach { (name) in
            
            let button = UIButton(frame: CGRect.zero)
            button.setImage(UIImage(named: name), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.tag = buttonIndex
            
            button.addTarget(self, action: #selector(imgTappeded(_:)), for: .touchUpInside)
            
            button.widthAnchor.constraint(equalToConstant: imgHeight).isActive = true
            
            imgViews.append(button)
            
            buttonIndex += 1
        }
        
        let stackView = UIStackView(arrangedSubviews: imgViews)
        stackView.distribution = .fill
        
        let imgSpaceing = 1
        stackView.spacing = CGFloat(imgSpaceing)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (tabBar.frame.height + 10).negated()).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: imgHeight).isActive = true
        
        stackView.widthAnchor.constraint(equalToConstant: CGFloat(((50 + imgSpaceing) * imgViews.count) - imgSpaceing)).isActive = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(imgNames.count)
        return imgNames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryDisplayCell else { return UICollectionViewCell() }
        
        cell.imgView.image = UIImage(named: imgNames[indexPath.item])
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
