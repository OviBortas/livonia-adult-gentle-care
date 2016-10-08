//
//  CHTCollectionViewWaterfallLayout.swift
//  PinterestSwift
//
//  Created by Nicholas Tau on 6/30/14.
//  Copyright (c) 2014 Nicholas Tau. All rights reserved.
//

import Foundation
import UIKit


@objc public protocol CHTCollectionViewDelegateWaterfallLayout : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                       heightForHeaderInSection section: NSInteger) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                       heightForFooterInSection section: NSInteger) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                       insetForSectionAtIndex section: NSInteger) -> UIEdgeInsets
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                       minimumInteritemSpacingForSectionAtIndex section: NSInteger) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                       columnCountForSection section: NSInteger) -> NSInteger
}

public enum CHTCollectionViewWaterfallLayoutItemRenderDirection : NSInteger {
    case chtCollectionViewWaterfallLayoutItemRenderDirectionShortestFirst
    case chtCollectionViewWaterfallLayoutItemRenderDirectionLeftToRight
    case chtCollectionViewWaterfallLayoutItemRenderDirectionRightToLeft
}

public let CHTCollectionElementKindSectionHeader = "CHTCollectionElementKindSectionHeader"
public let CHTCollectionElementKindSectionFooter = "CHTCollectionElementKindSectionFooter"

open class CHTCollectionViewWaterfallLayout : UICollectionViewLayout {
    open var columnCount: NSInteger {
        didSet {
            invalidateLayout()
        }}
    
    open var minimumColumnSpacing: CGFloat {
        didSet {
            invalidateLayout()
        }}
    
    open var minimumInteritemSpacing: CGFloat {
        didSet {
            invalidateLayout()
        }}
    
    open var headerHeight: CGFloat {
        didSet {
            invalidateLayout()
        }}
    
    open var footerHeight: CGFloat {
        didSet {
            invalidateLayout()
        }}
    
    open var sectionInset: UIEdgeInsets {
        didSet {
            invalidateLayout()
        }}
    
    
    open var itemRenderDirection: CHTCollectionViewWaterfallLayoutItemRenderDirection {
        didSet {
            invalidateLayout()
        }}
    
    open weak var delegate: CHTCollectionViewDelegateWaterfallLayout? {
        get {
            return self.collectionView!.delegate as? CHTCollectionViewDelegateWaterfallLayout
        }}
    
    fileprivate var columnHeights: NSMutableArray
    fileprivate var sectionItemAttributes: NSMutableArray
    fileprivate var allItemAttributes: NSMutableArray
    fileprivate var headersAttributes: NSMutableDictionary
    fileprivate var footersAttributes: NSMutableDictionary
    fileprivate  var unionRects: NSMutableArray
    fileprivate let unionSize = 20
    
    override public init() {
        self.headerHeight = 0.0
        self.footerHeight = 0.0
        self.columnCount = 2
        self.minimumInteritemSpacing = 10
        self.minimumColumnSpacing = 10
        self.sectionInset = UIEdgeInsets.zero
        self.itemRenderDirection =
            CHTCollectionViewWaterfallLayoutItemRenderDirection.chtCollectionViewWaterfallLayoutItemRenderDirectionShortestFirst
        
        headersAttributes = NSMutableDictionary()
        footersAttributes = NSMutableDictionary()
        unionRects = NSMutableArray()
        columnHeights = NSMutableArray()
        allItemAttributes = NSMutableArray()
        sectionItemAttributes = NSMutableArray()
        
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func columnCountForSection(_ section: NSInteger) -> NSInteger {
        if let columnCount = delegate?.collectionView?(collectionView!, layout: self, columnCountForSection: section){
            return columnCount
        } else {
            return columnCount
        }
    }
    
    func itemWidthInSectionAtIndex(_ section: NSInteger) -> CGFloat {
        var insets : UIEdgeInsets
        if let sectionInsets = delegate?.collectionView?(collectionView!, layout: self, insetForSectionAtIndex: section) {
            insets = sectionInsets
        } else {
            insets = sectionInset
        }
        let width: CGFloat = collectionView!.bounds.size.width - insets.left-insets.right
        let columnCount = columnCountForSection(section)
        let spaceColumCount: CGFloat = CGFloat(columnCount - 1)
        return floor((width - (spaceColumCount * minimumColumnSpacing)) / CGFloat(columnCount))
    }
    
    override open func prepare() {
        super.prepare()
        
        let numberOfSections = collectionView!.numberOfSections
        if numberOfSections == 0 {
            return
        }
        
        self.headersAttributes.removeAllObjects()
        self.footersAttributes.removeAllObjects()
        self.unionRects.removeAllObjects()
        self.columnHeights.removeAllObjects()
        self.allItemAttributes.removeAllObjects()
        self.sectionItemAttributes.removeAllObjects()
        
        for section in 0 ..< numberOfSections {
            let columnCount = columnCountForSection(section)
            let sectionColumnHeights = NSMutableArray(capacity: columnCount)
            for idx in 0 ..< columnCount {
                sectionColumnHeights.add(idx)
            }
            columnHeights.add(sectionColumnHeights)
        }
        
        var top: CGFloat = 0.0
        var attributes = UICollectionViewLayoutAttributes()
        
        for section in 0 ..< numberOfSections {
            /*
             1. Get section-specific metrics (minimumInteritemSpacing, sectionInset)
             */
            var minimumInteritemSpacing: CGFloat
            if let miniumSpaceing = delegate?.collectionView?(collectionView!, layout: self, minimumInteritemSpacingForSectionAtIndex: section) {
                minimumInteritemSpacing = miniumSpaceing
            } else {
                minimumInteritemSpacing = minimumColumnSpacing
            }
            
            var sectionInsets:  UIEdgeInsets
            if let insets = delegate?.collectionView?(collectionView!, layout: self, insetForSectionAtIndex: section){
                sectionInsets = insets
            } else {
                sectionInsets = sectionInset
            }
            
            let width = collectionView!.bounds.size.width - sectionInsets.left - sectionInsets.right
            let columnCount = columnCountForSection(section)
            let spaceColumCount = CGFloat(columnCount - 1)
            let itemWidth = floor((width - (spaceColumCount * minimumColumnSpacing)) / CGFloat(columnCount))
            
            /*
             2. Section header
             */
            var heightHeader: CGFloat
            if let height = delegate?.collectionView?(collectionView!, layout: self, heightForHeaderInSection: section){
                heightHeader = height
            } else {
                heightHeader = headerHeight
            }
            
            if heightHeader > 0 {
                attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: CHTCollectionElementKindSectionHeader, with: IndexPath(row: 0, section: section))
                attributes.frame = CGRect(x: 0, y: top, width: collectionView!.bounds.size.width, height: heightHeader)
                headersAttributes.setObject(attributes, forKey: (section as NSCopying))
                allItemAttributes.add(attributes)
                
                top = attributes.frame.maxY
            }
            top += sectionInsets.top
            for idx in 0 ..< columnCount {
                if let sectionColumnHeights = columnHeights[section] as? NSMutableArray {
                    sectionColumnHeights[idx]=top
                }
            }
            
            /*
             3. Section items
             */
            let itemCount = collectionView!.numberOfItems(inSection: section)
            let itemAttributes = NSMutableArray(capacity: itemCount)
            
            // Item will be put into shortest column.
            for idx in 0 ..< itemCount {
                let indexPath = IndexPath(item: idx, section: section)
                
                let columnIndex = nextColumnIndexForItem(idx, section: section)
                let xOffset = sectionInsets.left + (itemWidth + minimumColumnSpacing) * CGFloat(columnIndex)
                let yOffset = (columnHeights[section] as AnyObject).objectAt(columnIndex).doubleValue
                //let yOffset = ((columnHeights[section] as Any).object(columnIndex) as Any).doubleValue
                let itemSize = delegate?.collectionView(collectionView!, layout: self, sizeForItemAtIndexPath: indexPath)
                var itemHeight: CGFloat = 0.0
                let zero: CGFloat = 0.0
                if let height = itemSize?.height, let width = itemSize?.width, height > zero && width > zero {
                    itemHeight = floor(itemSize!.height*itemWidth/itemSize!.width)
                }
                
                attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: CGFloat(yOffset!), width: itemWidth, height: itemHeight)
                itemAttributes.add(attributes)
                allItemAttributes.add(attributes)
                
                if let sectionColumnHeights = columnHeights[section] as? NSMutableArray {
                    sectionColumnHeights[columnIndex]=attributes.frame.maxY + minimumInteritemSpacing
                }
            }
            sectionItemAttributes.add(itemAttributes)
            
            /*
             4. Section footer
             */
            var footerHeight: CGFloat = 0.0
            let columnIndex  = longestColumnIndexInSection(section)
            top = CGFloat(((columnHeights[section] as AnyObject).objectAt(columnIndex)).floatValue) - minimumInteritemSpacing + sectionInsets.bottom
            
            if let height = delegate?.collectionView?(collectionView!, layout: self, heightForFooterInSection: section){
                footerHeight = height
            } else {
                self.footerHeight = footerHeight
            }
            
            if footerHeight > 0 {
                attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: CHTCollectionElementKindSectionFooter, with: IndexPath(item: 0, section: section))
                attributes.frame = CGRect(x: 0, y: top, width: collectionView!.bounds.size.width, height: footerHeight)
                footersAttributes.setObject(attributes, forKey: section as NSCopying)
                allItemAttributes.add(attributes)
                top = attributes.frame.maxY
            }
            
            for idx in 0 ..< columnCount {
                if let sectionColumnHeights = columnHeights[section] as? NSMutableArray {
                    sectionColumnHeights[idx]=top
                }
            }
        }
        
        var idx = 0
        let itemCounts = allItemAttributes.count
        while(idx < itemCounts) {
            let rect1 = (allItemAttributes.object(at: idx) as AnyObject).frame as CGRect
            idx = min(idx + unionSize, itemCounts) - 1
            let rect2 = (allItemAttributes.object(at: idx) as AnyObject).frame as CGRect
            unionRects.add(NSValue(cgRect:rect1.union(rect2)))
            idx += 1
        }
    }
    
    override open var collectionViewContentSize: CGSize {
        let numberOfSections = collectionView!.numberOfSections
        if numberOfSections == 0 {
            return CGSize.zero
        }
        
        var contentSize = collectionView!.bounds.size as CGSize
        let height = (columnHeights.lastObject! as AnyObject).firstObject as! NSNumber
        contentSize.height = CGFloat(height.doubleValue)
        return contentSize
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if (indexPath as NSIndexPath).section >= sectionItemAttributes.count {
            return nil
        }
        let list = sectionItemAttributes.object(at: (indexPath as NSIndexPath).section) as! NSArray
        
        if (indexPath as NSIndexPath).item >= list.count {
            return nil
        }
        return list.object(at: (indexPath as NSIndexPath).item) as? UICollectionViewLayoutAttributes
    }
    
    override open func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        var attribute = UICollectionViewLayoutAttributes()
        if elementKind == CHTCollectionElementKindSectionHeader {
            attribute = headersAttributes.object(forKey: (indexPath as NSIndexPath).section) as! UICollectionViewLayoutAttributes
        } else if elementKind == CHTCollectionElementKindSectionFooter {
            attribute = footersAttributes.object(forKey: (indexPath as NSIndexPath).section) as! UICollectionViewLayoutAttributes
        }
        return attribute
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var begin = 0, end = unionRects.count
        let attrs = NSMutableArray()
        
        for i in 0 ..< end {
            if let unionRect = unionRects.object(at: i) as? NSValue {
                if rect.intersects(unionRect.cgRectValue) {
                    begin = i * unionSize
                    break
                }
            }
        }
        for i in (0 ..< self.unionRects.count).reversed() {
            if let unionRect = unionRects.object(at: i) as? NSValue {
                if rect.intersects(unionRect.cgRectValue) {
                    end = min((i + 1) * unionSize, allItemAttributes.count)
                    break
                }
            }
        }
        for i in begin ..< end {
            let attr = allItemAttributes.object(at: i) as! UICollectionViewLayoutAttributes
            if rect.intersects(attr.frame) {
                attrs.add(attr)
            }
        }
        
        return NSArray(array: attrs) as? [UICollectionViewLayoutAttributes]
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds : CGRect) -> Bool {
        let oldBounds = collectionView!.bounds
        if newBounds.width != oldBounds.width{
            return true
        }
        return false
    }
    
    
    /*
     *  Find the shortest column.
     *
     *  @return index for the shortest column
     */
    func shortestColumnIndexInSection(_ section: NSInteger) -> NSInteger {
        var index = 0
        var shorestHeight = MAXFLOAT
        
        (self.columnHeights[section] as AnyObject).enumerateObjects({(object, idx,pointer) in
            if let height = object as? Float {
                if height < shorestHeight {
                    shorestHeight = height
                    index = idx
                }
            }
        })
        return index
    }
    
    /*
     *  Find the longest column.
     *
     *  @return index for the longest column
     */
    func longestColumnIndexInSection(_ section: NSInteger) -> NSInteger {
        var index = 0
        var longestHeight: CGFloat = 0.0
        
        (self.columnHeights[section] as AnyObject).enumerateObjects({(object, idx, pointer) in
            if let height = object as? CGFloat {
                if height > longestHeight {
                    longestHeight = height
                    index = idx
                }
            }
        })
        return index
    }
    
    /**
     *  Find the index for the next column.
     *
     *  @return index for the next column
     */
    func nextColumnIndexForItem(_ item : NSInteger, section: NSInteger) -> Int {
        var index = 0
        let columnCount = columnCountForSection(section)
        switch itemRenderDirection {
        case .chtCollectionViewWaterfallLayoutItemRenderDirectionShortestFirst:
            index = shortestColumnIndexInSection(section)
        case .chtCollectionViewWaterfallLayoutItemRenderDirectionLeftToRight:
            index = (item%columnCount)
        case .chtCollectionViewWaterfallLayoutItemRenderDirectionRightToLeft:
            index = (columnCount - 1) - (item % columnCount)
        }
        return index
    }
}
