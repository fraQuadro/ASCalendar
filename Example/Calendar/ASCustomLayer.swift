//
//  ASCustomLayer.swift
//  Example
//
//  Created by alberto.scampini on 18/05/2016.
//  Copyright © 2016 Alberto Scampini. All rights reserved.
//


import UIKit

class ASCustomLayer: UIView {
    
    var calendar : UIView!
    var blackLayer : UIView!
    
    //MARK: initialisations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit () {
        self.backgroundColor = UIColor.clear
    }
    
    //MARK: public methods
    
    func showCalendar () {
        self.createLayer()
        self.presentationAnimations()
    }
    
    //MARK: user interaction 
    
    @objc func handleTap() {
        self.closingAnimations()
    }
    
    //MARK: private methods
    
    internal func createLayer () {
        //create self
        let mainWindow : UIWindow = UIApplication.shared.keyWindow!
        self.translatesAutoresizingMaskIntoConstraints = false
        mainWindow.addSubview(self)
        //set self layout
        let topConstraint = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: mainWindow,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        let bottomConstraint = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: mainWindow,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let leftConstraint = NSLayoutConstraint(
            item: self,
            attribute: .left,
            relatedBy: .equal,
            toItem: mainWindow,
            attribute: .left,
            multiplier: 1,
            constant: 0
        )
        let rightConstraint = NSLayoutConstraint(
            item: self,
            attribute: .right,
            relatedBy: .equal,
            toItem: mainWindow,
            attribute: .right,
            multiplier: 1,
            constant: 0
        )
        mainWindow.addConstraints([topConstraint,bottomConstraint,leftConstraint,rightConstraint])
        //create black layer
        self.blackLayer = UIView()
        self.blackLayer.alpha = 0 
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blackLayer = UIVisualEffectView(effect: darkBlur)
        self.addSubview(blackLayer)
        self.blackLayer.translatesAutoresizingMaskIntoConstraints = false
        //set black layer layout
        let topLayerConstraint = NSLayoutConstraint(
            item: self.blackLayer,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        let bottomLayerConstraint = NSLayoutConstraint(
            item: self.blackLayer,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let leftLayerConstraint = NSLayoutConstraint(
            item: self.blackLayer,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .left,
            multiplier: 1,
            constant: 0
        )
        let rightLayerConstraint = NSLayoutConstraint(
            item: self.blackLayer,
            attribute: .right,
            relatedBy: .equal,
            toItem: self,
            attribute: .right,
            multiplier: 1,
            constant: 0
        )
        self.addConstraints([topLayerConstraint,bottomLayerConstraint,leftLayerConstraint,rightLayerConstraint])
        //add tap gesture to layer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.blackLayer.addGestureRecognizer(tapGesture)
        //load calendar view
        self.calendar = ASCalendarV.init(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        self.calendar.alpha = 0
        self.calendar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.calendar)
        //set calendar view layout
        let centerXConstraint = NSLayoutConstraint(
            item: self.calendar,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        self.centerYConstraint = NSLayoutConstraint(
            item: self.calendar,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 100)
        let widthConstraint = NSLayoutConstraint(
            item: self.calendar,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 250)
        
        let heightConstraint = NSLayoutConstraint(
            item: self.calendar,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 250)

        self.addConstraints([
            centerXConstraint,
            self.centerYConstraint,
            widthConstraint,
            heightConstraint]
        )
        //apply layout
        self.layoutIfNeeded()
    }
    
    var centerYConstraint : NSLayoutConstraint!
    
    internal func presentationAnimations() {
        self.centerYConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.blackLayer.alpha = 1
            self.calendar.alpha = 1
            self.layoutIfNeeded()
        }) 
    }
    
    func closingAnimations() {
        UIView.animate(withDuration: 0.2, animations: {
            self.blackLayer.alpha = 0
            self.calendar.alpha = 0
            self.centerYConstraint.constant = 100
            self.layoutIfNeeded()
            }, completion: {[unowned self] (flag)  in
                self.removeFromSuperview()
        })
    }
    
}

