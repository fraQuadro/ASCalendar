//
//  ASDayV.swift
//  Example
//
//  Created by alberto.scampini on 19/05/2016.
//  Copyright © 2016 Alberto Scampini. All rights reserved.
//

import UIKit

class ASDayV : UIView {
    
    var numberLabel : UILabel!
    var selectionV : UIView!
    
    var viewModel : ASDayVM! {
        didSet {
            self.viewModel.dayM.bindAndFire {
                [unowned self] in
                self.hidden = !$0.dayEnabled
                if ($0.dayEnabled == true) {
                    self.numberLabel.text = String($0.dayNumber)
                    self.selectionV.hidden = !$0.daySelected
                    if ($0.daySelectable == true) {
                        self.numberLabel.textColor = UIColor.blackColor()
                    } else {
                        self.numberLabel.textColor = UIColor.grayColor()
                    }
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //add selectionView
        selectionV = UIView.init(frame: self.bounds)
        selectionV.layer.cornerRadius = self.selectionV.frame.size.height/2
        self.addSubview(selectionV)
        //add numberLabel
        numberLabel = UILabel.init(frame: self.bounds)
        numberLabel.textAlignment = .Center
        self.addSubview(numberLabel)
        //gesture
        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.addGestureRecognizer(tapGesture)
        self.userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: user interaction
    
    func handleTap () {
        if (self.viewModel.dayM.value.daySelectable == true) {
            self.viewModel.selected()
        }
    }
    
}