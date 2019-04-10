//
//  OverlayAlertsController.swift
//  DemoAlerts
//
//  Created by Adair de Jesús Castillo Meza on 4/10/19.
//  Copyright © 2019 Adair Castillo. All rights reserved.
//

import UIKit

class OverlayAlertsController: NSObject {

    private var alertView:OverlayAlertView?
    private var insideView:UIView!
    private var belowView:UIView?
    private var style:OverlayAlertView.AlertStyle = .Default
    private var margin:CGFloat = 0
    
    init(insideView:UIView, belowView:UIView?, direction:OverlayAlertView.AlertDirection, style:OverlayAlertView.AlertStyle = .Default, margin:CGFloat = 0){
        self.insideView = insideView
        self.belowView = belowView
        self.style = style
        self.margin = margin
        
        self.alertView = OverlayAlertView.alertView(inside: insideView, below: belowView, direction: direction, style: style, margin: margin)
        if  let below = belowView{
            insideView.insertSubview(self.alertView!, belowSubview: below)
        }else{
            insideView.addSubview(self.alertView!)
        }
    }
    
    public func changeDirection(to direction:OverlayAlertView.AlertDirection){
        
        if let alertView = self.alertView{
            alertView.removeFromSuperview()
        }
        
        self.alertView = OverlayAlertView.alertView(inside: insideView, below: belowView, direction: direction, style: style, margin: margin)
        if  let below = belowView{
            insideView.insertSubview(self.alertView!, belowSubview: below)
        }else{
            insideView.addSubview(self.alertView!)
        }
    }
    
    public func showAlert(_ message:String, ofType type:OverlayAlertView.AlertType, alwaysVisible:Bool){
        self.alertView!.showAlert(message, ofType: type, alwaysVisible: alwaysVisible)
    }
    
    public func showAlert(_ message:String, ofType type:OverlayAlertView.AlertType, alwaysVisible:Bool, onTouch touchBlock:@escaping OverlayAlertView.OnTouchAlert){
        self.alertView!.showAlert(message, ofType: type, alwaysVisible: alwaysVisible, onTouch: touchBlock)
    }
    
    public func hideAlert(){
        self.alertView!.hideAlert()
    }
    
}
