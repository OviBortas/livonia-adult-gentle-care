//
//  GalleryModel.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/24/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

struct GalleryData {
   
   let title: String
   let displayImg: UIImage
   let imgNames: [String]
   let imageDescription: String
}

class GalleryModel {
   
   let data: [GalleryData] = {
      // set the names of the pictures associated with the item
      let item1Assets = ["FrontYard1", "FrontYard2", "BackYard1", "BackYard2", "BackYard3", "BackYard4", "BackYard5"]
      let item1 = GalleryData(title: "Exterior", displayImg: UIImage(named: "ExteriorP")!, imgNames: item1Assets, imageDescription: "Front Yard and Back Yard")
      
      let item2Assets = ["Bedroom1-1", "Bedroom1-2", "Bedroom1-3", "Bath1-1", "Bath1-2", "Bath1-3"]
      let item2 = GalleryData(title: "Room 1", displayImg: UIImage(named: "Room 1P")!, imgNames: item2Assets, imageDescription: "Room 1/Shared Bath")
      
      let item3Assets = ["Bedroom2-1", "Bedroom2-2", "Bedroom2-3", "Bath1-1", "Bath1-2", "Bath1-3"]
      let item3 = GalleryData(title: "Room 2", displayImg: UIImage(named: "Room 2P")!, imgNames: item3Assets, imageDescription: "Room 2/Shared Bath")
      
      let item4Assets = ["Bedroom3-1", "Bedroom3-2", "Bedroom3-3", "Bath2-1", "Bath2-2"]
      let item4 = GalleryData(title: "Room 3", displayImg: UIImage(named: "Room 3P")!, imgNames: item4Assets, imageDescription: "Room 3/Private Bath")
      
      let item5Assets = ["Bedroom4-1", "Bath3-1", "Bath3-2"]
      let item5 = GalleryData(title: "Room 4", displayImg: UIImage(named: "Room 4P")!, imgNames: item5Assets, imageDescription: "Room 4/Private Bath")
      
      let item6Assets = ["Livingroom1", "Livingroom2", "Livingroom3", "Hall2", "Nook1", "Nook2"]
      let item6 = GalleryData(title: "Living Room", displayImg: UIImage(named: "Living RoomP")!, imgNames: item6Assets, imageDescription: "Living Room/Hallways")
      
      let item7Assets = ["Kitchen4", "Kitchen1", "Kitchen2", "Kitchen3"]
      let item7 = GalleryData(title: "Kitchen", displayImg: UIImage(named: "KitchenP")!, imgNames: item7Assets, imageDescription: "Kitchen/Dining Area")
      
      let item8 = GalleryData(title: "None", displayImg: UIImage(named: "Grey Logo for Gallery")!, imgNames: ["None"], imageDescription: "None")
      
      return [item1, item2, item3, item4, item5, item6, item7, item8]
   }()
}
