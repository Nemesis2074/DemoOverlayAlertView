//
//  Styles.swift
//  DemoAlerts
//
//  Created by Adair de Jesús Castillo Meza on 4/10/19.
//  Copyright © 2019 Adair Castillo. All rights reserved.
//

import Foundation
import UIKit

class Styles{
    
    /*MARK: ++++++++++++++++++++ MARGENES Y TAMAÑOS ++++++++++++++++++++*/
    
    private struct AppFont {
        static let AppFontNormal = "Avenir-Light"
        static let AppFontItalic = "Avenir-LightOblique"
        static let AppFontBold = "Avenir-Medium"
    }
    
    public struct Margin{
        static let MarginMin:CGFloat = 4.0
        static let Margin1x:CGFloat = 8.0
        static let Margin2x:CGFloat = 16.0
        static let Margin3x:CGFloat = 24.0
        static let Margin4x:CGFloat = 32.0
    }
    
    public struct SizeConstants{
        static let StatusBarSize:CGFloat = 20.0
        static let ActionBarSize:CGFloat = 50.0
        static let ActionBarFullSize:CGFloat = 70.0
        static let iPadScreenMinWidth:CGFloat = 700.0
        static let iPadContentInset:CGFloat = 100.0
        static let ActionButton:CGFloat = 60.0
        static let ScreenHeaderSize:CGFloat = 240.0
        static let FilterSize:CGFloat = 180.0
        static let FilterSmallSize:CGFloat = 40
    }
    
    public struct Constants{
        static let AnimationTime = 0.5
        static let CornerRadius:CGFloat = 4.0
        static let ShadowOffset:CGSize = CGSize(width: 1.0, height: 1.0)
        static let ShadowOpacity:Float = 0.5
        static let ShadowRadius:CGFloat = 1.5
    }
    
    public class Color{
        
        /*++++++++++++++++++++ ALERTS ++++++++++++++++++++*/
        
        class var alertDone:UIColor{
            return UIColor.colorWith(R: 102, G: 153, B: 51)
        }
        
        class var alertInfo:UIColor{
            return UIColor.colorWith(R: 51, G: 153, B: 204)
        }
        
        class var alertWarning:UIColor{
            return UIColor.colorWith(R: 255, G: 136, B: 0)
        }
        
        class var alertError:UIColor{
            return UIColor.colorWith(R: 204, G: 0, B: 0)
        }
    }
    
    /*MARK: ++++++++++++++++++++ FUENTES ++++++++++++++++++++*/
    
    public class Font{
        
        class var small:UIFont{
            return UIFont(name: AppFont.AppFontNormal, size: 13.0)!
        }
        
        class var smallBold:UIFont{
            return UIFont(name: AppFont.AppFontBold, size: 13.0)!
        }
        
        class var normal:UIFont{
            return UIFont(name: AppFont.AppFontNormal, size: 16.0)!
        }
        
        class var normalBold:UIFont{
            return UIFont(name: AppFont.AppFontBold, size: 16.0)!
        }
        
        class var normalItalic:UIFont{
            return UIFont(name: AppFont.AppFontItalic, size: 16.0)!
        }
        
        class var medium:UIFont{
            return UIFont(name: AppFont.AppFontNormal, size: 19.0)!
        }
        
        class var mediumBold:UIFont{
            return UIFont(name: AppFont.AppFontBold, size: 19.0)!
        }
        
        class var large:UIFont{
            return UIFont(name: AppFont.AppFontNormal, size: 22.0)!
        }
        
        class var largeBold:UIFont{
            return UIFont(name: AppFont.AppFontBold, size: 22.0)!
        }
        
        class var big:UIFont{
            return UIFont(name: AppFont.AppFontNormal, size: 25.0)!
        }
        
        class var bigBold:UIFont{
            return UIFont(name: AppFont.AppFontBold, size: 25.0)!
        }
        
        class var bigger:UIFont{
            return UIFont(name: AppFont.AppFontBold, size: 32.0)!
        }
        
    }
    
    /*MARK: ++++++++++++++++++++ ICONOS ++++++++++++++++++++*/
    
    public class Icon{
        
        /*++++++++++++++++++++ ICONOS DE ALERTAS ++++++++++++++++++++*/
        
        class var alertDone: UIImage?{
            return UIImage(named: "ic_alert_done")?.withRenderingMode(.alwaysTemplate)
        }
        
        class var alertInfo:UIImage?{
            return UIImage(named: "ic_alert_info")?.withRenderingMode(.alwaysTemplate)
        }
        
        class var alertWarning:UIImage?{
            return UIImage(named: "ic_alert_warning")?.withRenderingMode(.alwaysTemplate)
        }
        
        class var alertError:UIImage?{
            return UIImage(named: "ic_alert_error")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
}
