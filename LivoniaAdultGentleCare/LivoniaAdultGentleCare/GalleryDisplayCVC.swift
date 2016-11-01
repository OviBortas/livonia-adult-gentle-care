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
   
   var itemData: GalleryData!
   var pageC: PageControlView!
   
   lazy var titleLabel: UILabel = {
      var label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 29.0))
      label.textAlignment = .center
      label.font = UIFont(name: "AvenirNext-Medium", size: 19.0)
      label.textColor = .black
      label.text = self.itemData.imageDescription
      label.translatesAutoresizingMaskIntoConstraints = false
      
      return label
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      automaticallyAdjustsScrollViewInsets = false
      
      pageC = PageControlView(imgNames: itemData.imgNames)
      view.addSubview(pageC)
      pageC.delegate = self
      
      collectionView?.addSubview(titleLabel)
      anchorTitleLabel()
   }
   
   // Adds titleLabel on top of the collectionView, without this each cell would have its own title
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      titleLabel.removeFromSuperview()
      
      UIApplication.shared.keyWindow?.addSubview(titleLabel)
      anchorTitleLabel()
   }
   
   // Removes the titleLabel from the screen
   override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      titleLabel.removeFromSuperview()
   }
   
   func anchorTitleLabel() {
      titleLabel.topAnchor.constraint(equalTo: collectionView!.topAnchor, constant: 8.0).isActive = true
      titleLabel.centerXAnchor.constraint(equalTo: collectionView!.centerXAnchor).isActive = true
   }
   
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of items
      return itemData.imgNames.count
   }
   
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryDisplayCell else { return UICollectionViewCell() }
      
      cell.imgView.image = UIImage(named: itemData.imgNames[indexPath.item])
      
      return cell
   }
   
   // Set the size of the cell to be the size of the screen
   // Without this autolayout does not work properly
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return collectionView.bounds.size
   }
   
   override func scrollViewDidScroll(_ scrollView: UIScrollView) {
      guard let viewSize = collectionView?.visibleCells.first?.contentView.frame.size.width else { return }
      
      pageC.pageControlView(updateHorizontalBarConstraint: scrollView.contentOffset.x, collectionViewWidth: viewSize)
   }
   
   override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      pageC.currentVisibleIndex = collectionView.indexPathsForVisibleItems.first?.item
   }
   
   
   func pageControlView(_ pageControllView: PageControlView, didselectItemAt indexPath: IndexPath) {
      collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: .left)
   }
}
