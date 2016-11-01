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
   
   func setupLayout() {
      let layout = CHTCollectionViewWaterfallLayout()
      layout.columnCount = 2
      
      layout.minimumColumnSpacing = 10.0
      layout.minimumInteritemSpacing = 1.0
   
      layout.sectionInset = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 8.0, right: 8.0)
      
      collectionView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      collectionView?.alwaysBounceVertical = true
      
      collectionView?.collectionViewLayout = layout
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
         UIView.animate(withDuration: 1.0, delay: delayCounter * 0.05, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            cell.transform = CGAffineTransform.identity
         }, completion: nil)
         delayCounter += 1
      }
   }
   
   // MARK: - Navigation
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      if segue.identifier == "imgDisplaySegue" {
         let vc = segue.destination as! GalleryDisplayCVC
         
         // get the cell index the user selected
         guard let index = collectionView?.indexPathsForSelectedItems?.first?.row else { return }
         
         vc.itemData = model.data[index]
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
      reset(cell:  cell)
      
      // Configure the cell

      cell.cellData = model.data[indexPath.row]
      cell.tag = indexPath.item
      
      if indexPath.row == model.data.count - 1 {
         cell.detailView.isHidden = true
         cell.imageView.alpha = 0.3
         cell.isUserInteractionEnabled = false
      }
      
      return cell
   }
   
   func reset(cell: GalleryCell) {
      cell.alpha = 1.0
      cell.detailView.isHidden = false
      cell.isUserInteractionEnabled = true
   }
   
   // MARK:- CHTCollectionViewDelegateWaterfallLayout
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
      let imageSize = model.data[indexPath.row].displayImg.size
      return imageSize
   }
}










