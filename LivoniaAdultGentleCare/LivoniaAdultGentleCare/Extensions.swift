//
//  Extensions.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/24/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

extension DateFormatter {
   
   func timeAgo(from time: String) -> String? {
      
      // Set the format of the given date
      dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
      
      // Get date object from the given date
      if let timeAgoDate = date(from: time) {
         
         let calendar = Calendar.current
         
         let components = calendar.dateComponents([.day, .weekOfMonth, .month, .year, .hour, .minute, .second],
                                                  from: timeAgoDate, to: Date())
         var time: String?
         
         // Safely unwarp variables
         guard let year = components.year,
            let month = components.month,
            let week = components.weekOfMonth,
            let day = components.day,
            let hour = components.hour,
            let minute = components.minute,
            let second = components.second
            else {
               print("companent is nil")
               return nil
         }
         
         if year > 1 {
            time = "\(year) years ago"
         }
         else if year > 0 {
            time = "\(year) year ago"
         }
         else if month > 0 {
            let months = shortMonthSymbols
            let monthSymbol = months![month - 1]
            
            time = monthSymbol + " \(day)"
         }
         else if week > 1 {
            time = "\(week) weeks ago"
         }
         else if week > 0 {
            time = "\(week) week ago"
         }
         else if day > 1 {
            time = "\(day) days ago"
         }
         else if day > 0 {
            time = "\(day) day ago"
         }
         else if hour > 1 {
            time = "\(hour) hours ago"
         }
         else if hour > 0 {
            time = "\(hour) hour ago"
         }
         else if minute > 1 {
            time = "\(minute) minutes ago"
         }
         else if minute > 0 {
            time = "\(minute) minute ago"
         }
         else if second > 1 {
            time = "\(second) seconds ago"
         }
         else if second > 0 {
            time = "\(second) second ago"
         }
         
         print("THIS IS THE TIME: \(time)")
         return time
      }
      else {
         print("Date could not be created from: \(time)")
         return nil
      }
   }
}

extension Optional {
   
   func zz(_ path: String = #file, _ function: String = #function, _ line: Int = #line) -> Optional {
      
      if self == nil {
         print("IM Nil!")
         let file = String(String(path.characters.reversed()).components(separatedBy: "/").first!.characters.reversed())
         print("returning nil instead of \(type(of: self)), file: \(file), func: \(function), line: \(line)")
         return .none
      }
      
      return self
   }
}

// returns nil along with a message describing where the return occures
func nilMessage<T>(_ path: String = #file, _ function: String = #function, _ line: Int = #line) -> T? {
   /*
    Reverse the string and trim it to the first occurance of "/"
    then reverse the string back to normal
    */
   let file = String(String(path.characters.reversed()).components(separatedBy: "/").first!.characters.reversed())
   
   print("returning nil instead of \(T.self), file: \(file), func: \(function), line: \(line)")
   
   return nil
}

// returns nil along with a message describing where the return occures
func nilMessage<T>(_ type: T, _ path: String = #file, _ function: String = #function, _ line: Int = #line) -> () {
   /*
    Reverse the string and trim it to the first occurance of "/"
    then reverse the string back to normal
    */
   print("ITS ME")
   let file = String(String(path.characters.reversed()).components(separatedBy: "/").first!.characters.reversed())
   
   print("returning nil instead of \(type(of: type)), file: \(file), func: \(function), line: \(line)")
   return ()
}

func checkNil<T>(_ type: T?, _ path: String = #file, _ function: String = #function, _ line: Int = #line) -> T? {
   /*
    Reverse the string and trim it to the first occurance of "/"
    then reverse the string back to normal
    */
   if type == nil {
      print("ITS ME")
      let file = String(String(path.characters.reversed()).components(separatedBy: "/").first!.characters.reversed())
      
      print("returning nil instead of \(T.self), file: \(file), func: \(function), line: \(line)")
      
      return nil
   }
   
   return type
}




extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
      assert(red >= 0 && red <= 255, "Invalid red component")
      assert(green >= 0 && green <= 255, "Invalid green component")
      assert(blue >= 0 && blue <= 255, "Invalid blue component")
      
      self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
   
   convenience init(netHex:Int) {
      self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
   }
}

