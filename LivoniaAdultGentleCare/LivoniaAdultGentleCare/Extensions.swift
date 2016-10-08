//
//  Extensions.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/24/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

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

