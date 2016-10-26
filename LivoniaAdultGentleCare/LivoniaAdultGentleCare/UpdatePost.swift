//
//  UpdatePost.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/10/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import Foundation

class UpdatePost {
   
   let author: String?
   let publishTime: String?
   let title: String?
   let body: String?
   
   let timeAgo: String?
   let index: Int?
   
   init(author: String?, publishTime: String?, title: String?, body: String?, index: Int?) {
      self.author = author
      self.publishTime = publishTime
      self.title = title
      self.body = body
      self.index = index
      
      self.timeAgo = DateFormatter().timeAgo(from: publishTime!)
      
   }
   
   
   func toDictionary() -> [String: Any] {
      let dict: [String: Any] = [DictKeys.author:         author,
                                 DictKeys.publishTime:    publishTime,
                                 DictKeys.body:           body,
                                 DictKeys.index:          index]
      return dict
   }
}
