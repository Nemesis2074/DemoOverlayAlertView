//
//  UIColor+Styles.swift
//  DemoAlerts
//
//  Created by Adair de Jesús Castillo Meza on 4/10/19.
//  Copyright © 2019 Adair Castillo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    func lighter(by percentage:CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage:CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage:CGFloat=30.0) -> UIColor? {
        
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
    
    class func colorWith(R red:CGFloat, G green:CGFloat, B blue:CGFloat) -> UIColor{
        return UIColor.colorWith(R: red, G: green, B: blue, A: 1);
    }
    
    class func colorWith(R red:CGFloat, G green:CGFloat, B blue:CGFloat, A alpha:CGFloat) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha);
    }
    
    class func colorWith(hexadecimal:String) -> UIColor{
        var cString:String = hexadecimal.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[index...])
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func parseColorToHexadecimal(color:UIColor) -> String{
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
    func isDark() -> Bool{
        let brightness = calculateBrightness()
        if(brightness < 0.6){
            return true
        }else{
            return false
        }
    }
    
    func isLight() -> Bool{
        let brightness = calculateBrightness()
        if(brightness < 0.6){
            return false
        }else{
            return true
        }
    }
    
    func calculateBrightness() -> CGFloat{
        let components = self.cgColor.components
        let red = components![0] * CGFloat(299)
        let green = components![1] * CGFloat(587)
        let blue = components![2] * CGFloat(114)
        let brightness = (red + green + blue) / CGFloat(1000)
        return brightness
    }
}
