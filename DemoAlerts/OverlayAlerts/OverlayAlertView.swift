//
//  OverlayAlertView.swift
//  DemoAlerts
//
//  Created by Adair de Jesús Castillo Meza on 4/10/19.
//  Copyright © 2019 Adair Castillo. All rights reserved.
//

import UIKit

class OverlayAlertView: UIView {
    
    public enum AlertDirection:Int{
        case GoDown = 0
        case GoUp = 1
    }
    
    public enum AlertType:Int{
        case Info = 0
        case Warning = 1
        case Error = 2
        case Done = 3
        case Loading = 4
        case Progress = 5
        
        public static func allAsArray() -> [AlertType]{
            return [.Info, .Warning, .Error, .Done, .Loading, .Progress]
        }
    }
    
    public enum AlertStyle:Int{
        case Default = 0
        case Notification = 1
        
        public func asHeight() -> CGFloat{
            switch(self){
            case .Default:
                return 60
            case .Notification:
                return 80
            }
        }
        
        public func asIconSize() -> CGFloat{
            switch(self){
            case .Default:
                return 20
            case .Notification:
                return 30
            }
        }
        
        public func asDelay() -> Double{
            switch(self){
            case .Default:
                return 2.0
            case .Notification:
                return 6.0
            }
        }
    }
    
    public typealias OnTouchAlert = () -> Void
    
    private static let kAnimation = 0.5
    private static let kProgressHeight:CGFloat = 2
    
    private var insideView:UIView!
    private var belowView:UIView?
    
    private var type:AlertType = .Info{
        didSet{
            switch(self.type){
            case .Info:
                self.backgroundColor = Styles.Color.alertInfo
                self.icon.image = Styles.Icon.alertInfo
                self.indicator.stopAnimating()
                self.progress.isHidden = true
                
            case .Warning:
                self.backgroundColor = Styles.Color.alertWarning
                self.icon.image = Styles.Icon.alertWarning
                self.indicator.stopAnimating()
                self.progress.isHidden = true
                
            case .Error:
                self.backgroundColor = Styles.Color.alertError
                self.icon.image = Styles.Icon.alertError
                self.indicator.stopAnimating()
                self.progress.isHidden = true
                
            case .Done:
                self.backgroundColor = Styles.Color.alertDone
                self.icon.image = Styles.Icon.alertDone
                self.indicator.stopAnimating()
                self.progress.isHidden = true
                
            case .Loading:
                self.backgroundColor = Styles.Color.alertInfo
                self.icon.image = nil
                self.indicator.startAnimating()
                self.progress.isHidden = true
                
            case .Progress:
                self.backgroundColor = Styles.Color.alertInfo
                self.icon.image = nil
                self.indicator.stopAnimating()
                self.progress.progress = 0
                self.progress.isHidden = false
            }
        }
    }
    
    private var direction:AlertDirection = .GoDown
    private var touchBlock:OnTouchAlert?
    private var style:AlertStyle = .Default
    private var margin:CGFloat = 0
    
    private var icon:UIImageView!
    private var indicator:UIActivityIndicatorView!
    private var label:UILabel!
    private var progress:UIProgressView!
    
    public var currentProgress:Float{
        get{
            return self.progress.progress
        }
        set{
            self.progress.setProgress(newValue, animated: true)
        }
    }
    
    /*+++++++++++++++++++++++++ CONSTRUCTOR +++++++++++++++++++++++++*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initComponents()
    }
    
    init(frame: CGRect, inside insideView:UIView, below belowView:UIView?, direction:AlertDirection, style:AlertStyle = .Default, margin:CGFloat = 0) {
        super.init(frame: frame)
        
        self.insideView = insideView
        self.belowView = belowView
        self.direction = direction
        self.style = style
        self.margin = margin
        
        initComponents()
    }
    
    func initComponents() {
        self.autoresizesSubviews = true
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = Styles.Constants.ShadowOffset
        self.layer.shadowOpacity = Styles.Constants.ShadowOpacity
        self.layer.shadowRadius = Styles.Constants.ShadowRadius
        
        let icon = UIImageView()
        icon.tintColor = UIColor.white
        icon.contentMode = .scaleAspectFit
        icon.autoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin]
        self.icon = icon
        self.addSubview(icon)
        
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.frame = CGRect(x: 0, y: 0, width: style.asHeight(), height: style.asHeight())
        indicator.hidesWhenStopped = true
        self.indicator = indicator
        self.addSubview(indicator)
        
        let label = UILabel()
        label.font = Styles.Font.normalBold
        label.textColor = UIColor.white
        label.numberOfLines = self.style == .Notification ? 3 : 2
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.label = label
        self.addSubview(label)
        
        let progress = UIProgressView()
        progress.isHidden = true
        progress.progressTintColor = UIColor.clear
        progress.trackTintColor = Styles.Color.alertInfo
        progress.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        self.progress = progress
        self.addSubview(progress)
    }
    
    /*++++++++++++++++++++ METODOS ++++++++++++++++++++*/
    
    public class func alertView(inside:UIView, below:UIView?, direction:AlertDirection, style:AlertStyle = .Default, margin:CGFloat = 0) -> OverlayAlertView{
        
        var alertFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        switch (direction) {
        case .GoUp:
            if let belowView = below{
                alertFrame = CGRect(x: belowView.frame.origin.x,
                                    y: belowView.frame.origin.y,
                                    width: belowView.frame.size.width,
                                    height: style.asHeight())
            }else{
                alertFrame = CGRect(x: 0,
                                    y: inside.frame.size.height,
                                    width: inside.frame.size.width,
                                    height: style.asHeight())
            }
        case .GoDown:
            if let belowView = below{
                alertFrame = CGRect(x: belowView.frame.origin.x,
                                    y: (belowView.frame.origin.y + belowView.frame.size.height) - style.asHeight(),
                                    width: belowView.frame.size.width,
                                    height: style.asHeight())
            }else{
                alertFrame = CGRect(x: 0,
                                    y: -style.asHeight(),
                                    width: inside.frame.size.width,
                                    height: style.asHeight())
            }
        }
        
        return OverlayAlertView(frame: alertFrame, inside: inside, below: below, direction: direction, style: style, margin: margin)
    }
    
    public func showAlert(_ text:String, ofType type:AlertType, alwaysVisible:Bool, onTouch touchBlock:OnTouchAlert? = nil){
        self.label.text = text
        self.type = type
        self.touchBlock = touchBlock
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(executeBlock))
        self.addGestureRecognizer(tapGesture)
        
        if(alwaysVisible){
            
            UIView.animate(withDuration: Styles.Constants.AnimationTime, delay: 0,
                           options: [ .curveEaseInOut, .allowUserInteraction ],
                           animations: {
                            self.showView()
            }, completion: nil)
            
        }else{
            
            UIView.animate(withDuration: Styles.Constants.AnimationTime, delay: 0,
                           options: [ .curveEaseInOut, .allowUserInteraction ],
                           animations: {
                            self.showView()
            }, completion: { (finished) in
                Timer.scheduledTimer(timeInterval: self.style.asDelay(),
                                     target: self,
                                     selector: #selector(self.hideAlert),
                                     userInfo: nil,
                                     repeats: false)
            })
        }
    }
    
    @objc public func hideAlert(){
        UIView.animate(withDuration: Styles.Constants.AnimationTime, delay: style.asDelay() / 2,
                       options: [.curveEaseInOut],
                       animations: {
                        self.hideView()
        }, completion: nil)
    }
    
    private func showView(){
        self.layer.opacity = 1
        
        switch (self.direction) {
        case .GoUp:
            if let below = self.belowView{
                self.frame = CGRect(x: below.frame.origin.x,
                                    y: below.frame.origin.y - style.asHeight(),
                                    width: below.frame.size.width,
                                    height: style.asHeight())
            }else{
                self.frame = CGRect(x: 0,
                                    y: self.insideView.frame.size.height - style.asHeight(),
                                    width: self.insideView.frame.size.width,
                                    height: style.asHeight())
            }
        case .GoDown:
            if let below = self.belowView{
                self.frame = CGRect(x: below.frame.origin.x,
                                    y: below.frame.origin.y + below.frame.size.height,
                                    width: below.frame.size.width,
                                    height: style.asHeight())
            }else{
                self.frame = CGRect(x: 0,
                                    y: margin,
                                    width: self.insideView.frame.size.width,
                                    height: style.asHeight())
            }
        }
    }
    
    private func hideView(){
        self.layer.opacity = 0
        
        switch (self.direction) {
        case .GoUp:
            if let below = self.belowView{
                self.frame = CGRect(x: below.frame.origin.x,
                                    y: below.frame.origin.y,
                                    width: below.frame.size.height,
                                    height: style.asIconSize())
            }else{
                self.frame = CGRect(x: 0,
                                    y: self.insideView.frame.size.height,
                                    width: self.insideView.frame.size.width,
                                    height: style.asHeight())
            }
        case .GoDown:
            if let below = self.belowView{
                self.frame = CGRect(x: below.frame.origin.x,
                                    y: (below.frame.origin.y + below.frame.size.height) - style.asHeight(),
                                    width: below.frame.size.width,
                                    height: style.asHeight())
            }else{
                self.frame = CGRect(x: 0,
                                    y: -style.asHeight(),
                                    width: self.insideView.frame.size.width,
                                    height: style.asHeight())
            }
        }
    }
    
    @IBAction func executeBlock(){
        if let block = self.touchBlock{
            block()
        }
    }
    
    /*++++++++++++++++++++ EVENTOS ++++++++++++++++++++*/
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        icon.frame = CGRect(x: Styles.Margin.Margin1x,
                            y: (self.frame.size.height / 2) - (self.style.asIconSize() / 2),
                            width: self.style.asIconSize(),
                            height: self.style.asIconSize())
        
        indicator.frame = icon.frame
        
        label.frame = CGRect(x: icon.frame.origin.x + icon.frame.size.width + Styles.Margin.Margin1x,
                             y: 0,
                             width: self.frame.size.width - (icon.frame.origin.x + icon.frame.size.width + Styles.Margin.Margin2x),
                             height: self.frame.size.height)
        
        progress.frame = CGRect(x: icon.frame.origin.x + icon.frame.size.width + Styles.Margin.Margin1x,
                                y: self.frame.size.height - OverlayAlertView.kProgressHeight,
                                width: self.frame.size.width - (icon.frame.origin.x + icon.frame.size.width + Styles.Margin.Margin2x),
                                height: OverlayAlertView.kProgressHeight)
    }
}
