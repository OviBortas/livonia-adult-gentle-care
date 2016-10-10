//
//  GalleryDisplayCVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/1/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "galleryDisplayCell"

class GalleryDisplayCVC: UICollectionViewController, PageControlViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var imgNames: [String] = [String]()
    var pageC: PageControlView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        pageC = PageControlView(imgNames: imgNames)
        view.addSubview(pageC)
        pageC.delegate = self
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imgNames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryDisplayCell else { return UICollectionViewCell() }
        
        cell.imgView.image = UIImage(named: imgNames[indexPath.item])
    
        return cell
    }
    
    // Set the size of the cell to be the size of the screen
    // Without this autolayout does not work properly
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
        
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(collectionViewLayout.collectionViewContentSize.width / CGFloat(imgNames.count))
        
        guard let viewSize = collectionView?.visibleCells.first?.contentView.frame.size.width else { return }
        
        pageC.pageControlView(updateHorizontalBarConstraint: scrollView.contentOffset.x, collectionViewWidth: viewSize)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageC.currentVisibleIndex = collectionView.indexPathsForVisibleItems.first?.item
    }
    
    
    func pageControlView(_ pageControllView: PageControlView, didselectItemAt indexPath: IndexPath) {
        collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: .left)
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
