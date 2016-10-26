//
//  GalleryCVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/20/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "gallaryCollectionCell"

class GalleryCVC: UICollectionViewController, CHTCollectionViewDelegateWaterfallLayout {
    
    let model = GalleryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateCollection()
    }
    
    func animateCollection() {
        
        collectionView?.performBatchUpdates( { self.performAnimation(direction: .vertical) }, completion: nil)
    }
    
    enum AnimationDirection {
        case horizontal
        case vertical
    }
    
    fileprivate func performAnimation(direction: AnimationDirection) {
        self.collectionView?.reloadData()
        
        guard let cells = self.collectionView?.visibleCells,
            let collectionViewHeight = self.collectionView?.bounds.size.height,
            let collectionViewWidth = self.collectionView?.bounds.size.width else {
            print("could not unwrap data \(#line)")
            return
        }
        
        if direction == .horizontal {
            for cell in cells {
                if cell.tag == 0 { // lhs
                    cell.transform = CGAffineTransform(translationX: collectionViewWidth.negated(), y: 0)
                }
                else if cell.tag == 1 { // rhs
                    cell.transform = CGAffineTransform(translationX: collectionViewWidth, y: 0)
                }
                else if cell.tag % 2 == 0 { // rhs
                    cell.transform = CGAffineTransform(translationX: collectionViewWidth, y: 0)
                }
                else { // lhs
                    cell.transform = CGAffineTransform(translationX: collectionViewWidth.negated(), y: 0)
                }
            }
        }
        else if direction == .vertical {
            for cell in cells {
                cell.transform = CGAffineTransform(translationX: 0, y: collectionViewHeight)
            }
        }
        
        var delayCounter: Double = 0.0
        for cell in cells {
            UIView.animate(withDuration: 1.25, delay: delayCounter * 0.05, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
                cell.transform = CGAffineTransform.identity
                }, completion: nil)
            delayCounter += 1
        }
    }
    
    func setupLayout() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 2
        
        layout.minimumColumnSpacing = 10.0
        layout.minimumInteritemSpacing = 1.0
        
        let bottomInset = UITabBarController().tabBar.frame.size.height + 4.0 + 2.0
        layout.sectionInset = UIEdgeInsets(top: 4.0, left: 8.0, bottom: bottomInset, right: 8.0)
        
        collectionView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.collectionViewLayout = layout
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "imgDisplaySegue" {
            let vc = segue.destination as! GalleryDisplayCVC
            
            // get the cell index the user selected
            guard let index = collectionView?.indexPathsForSelectedItems?.first?.row else { return }
            
            vc.imgNames = model.data[index].imgNames
            vc.title = model.data[index].title
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return model.data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCell
        
        // Configure the cell
        
        cell.imageView.image = model.data[indexPath.row].displayImg
        cell.titleLabel.text = model.data[indexPath.row].title + " \(indexPath.item)"
        cell.tag = indexPath.item
        
        if indexPath.row == model.data.count - 1 {
            cell.detailView.isHidden = true
            cell.imageView.alpha = 0.6
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    
    // MARK:- CHTCollectionViewDelegateWaterfallLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let imageSize = model.data[indexPath.row].displayImg.size
        return imageSize
        
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
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
