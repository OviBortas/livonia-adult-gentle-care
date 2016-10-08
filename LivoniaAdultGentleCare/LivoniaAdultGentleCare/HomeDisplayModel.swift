//
//  HomeDisplayModel.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/25/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

struct HomeDisplayData {
    static var count = 0
    
    let imageName: String
    let title: String
    let body: String
    let vcIndex: Int
    
    init(category: HomeDisplayCategory) {
        imageName = category.image
        title = category.title
        body = category.body
        vcIndex = HomeDisplayData.count
        
        HomeDisplayData.count += 1
    }
}

class HomeDisplayModel {
    
    let data: [HomeDisplayData] = {
        let d1 = HomeDisplayData(category: .aboutUs)
        let d2 = HomeDisplayData(category: .service)
        let d3 = HomeDisplayData(category: .saftey)
        let d4 = HomeDisplayData(category: .amenities)
        
        return [d1, d2, d3, d4]
    }()
    
}

enum HomeDisplayCategory: String {
    
    case aboutUs = "About Us"
    case service = "Services"
    case saftey = "Saftey"
    case amenities = "Amenities"
    
    var image: String {
        switch self {
        case .aboutUs:
            return "AboutUs"
        case .service:
            return "img1"
        case .saftey:
            return "Saftey"
        case .amenities:
            return "Amenities"
        }
        
    }
    
    var title: String {
        switch self {
        case .aboutUs:
            return "About Us"
        case .service:
            return "Services"
        case .saftey:
            return "Saftey"
        case .amenities:
            return "Amenities"
        }
        
    }
    
    var body: String {
        switch self {
        case .aboutUs:
            return "Livonia Adult Gentle Care is a live-in senior home care facility that is dedicated to providing quality, safe, and loving care in a warm environment. We provide our services to residents that need assistance with activities of daily living who cannot otherwise care for themselves. We offer round-the-clock supervision and assistance to both male and female individuals with a wide range of physical and medical conditions. Our ultimate goal is to ensure that our residents are happy and well cared for and to provide their families with the comfort of knowing that their loved one is in good hands."
        case .service:
            return "The services that we provide are specific to the individual needs of each of our residents. We are happy to care for those with physical limitations, Alzheimer's, dementia, diabetes, stroke, and other conditions that necessitate daily assistance. We provide assistance with mostly non-medical activities of daily living such as meal preparation, grooming, bathing, dressing, toileting, and medication administration. However, we do also accommodate for certain medical conditions that require maintenance of catheters, PEG tubes, O2 delivery systems, and more. We also work closely with doctors and nurses who do home visits for our residents."
        case .saftey:
            return "We understand that safety is a major concern for the elderly population, in particular for those who have lost the ability to reason logically. Therefore, we offer round-the-clock care and supervision for the sake of your loved one. We have years of experience in working with the aged and have grown to understand their limitations and needs. We pledge to advocate for our resident’s needs and to provide care that is in their best interest."
        case .amenities:
            return "Our facility is situated in a quiet neighborhood next to a small wooded area. We have a spacious open deck adjoining the house which overlooks our fenced backyard. Our residents can enjoy a variety of pastimes from group activities to cable TV to quiet reading. We offer both, private and shared rooms with their own designated baths depending on the room. All meals will be prepared fresh daily and housekeeping tasks will be completed by our staff during the course of the day. We strive to maintain a pleasant and caring environment for our residents because we want them to feel at home."
        }
    }
    
}
