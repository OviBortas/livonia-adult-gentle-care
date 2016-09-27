//
//  HomeDisplayModel.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/25/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

struct HomeDisplayData {
    let imageName: String
    let title: String
    let body: String
    let vcIndex: Int
}

class HomeDisplayModel {
    
    let data: [HomeDisplayData] = {
        let d1 = HomeDisplayData(imageName: "Island", title: "Title 1", body: "Body 1", vcIndex: 0)
        let d2 = HomeDisplayData(imageName: "Pinapples", title: "Title 2", body: "Body 2", vcIndex: 1)
        let d3 = HomeDisplayData(imageName: "img1", title: "Title 3", body: "Body 3", vcIndex: 2)
        let d4 = HomeDisplayData(imageName: "Island", title: "Title 4", body: "Body 4", vcIndex: 3)
        let d5 = HomeDisplayData(imageName: "img1", title: "Title 5", body: "Body 5", vcIndex: 4)
        
        return [d1, d2, d3, d4, d5]
    }()
    
}
