//
//  SelectLanguage.swift
//  LttFL
//
//  Created by ken morobayashi on 2015/02/22.
//  Copyright (c) 2015年 ken morobayashi. All rights reserved.
//

import UIKit

class SelectLanguageView {
    var baseView:UIView!
    var sizeAdjuster:SizeAdjuster!
    let LABEL_COLOR = "ff8800"
    let LABEL_ALPHA = CGFloat(1.0)
    let BORDER_COLOR = "888888"
    let BORDER_ALPHA = CGFloat(0.5)
    
    init(view:UIView){
        self.baseView = view
        self.sizeAdjuster = SizeAdjuster(view:view)
        
        // Labelを作成.
        let label = UILabel(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[24]!,self.sizeAdjuster.sizeDicHeight[4]!))
        label.text = "select language"
        label.textColor = UIColor.getColor(self.LABEL_COLOR, alpha: self.LABEL_ALPHA)
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "Futura", size: 32)
        label.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[4]!)
        ViewHelper.viewHelperInstance.addSubview(self.baseView,label:label,no:UINoStruct.LANGUAGE_LABEL)
    }
    
    func hidden(flag:Bool){
        self.baseView.viewWithTag(UINoStruct.LANGUAGE_LABEL)?.hidden = flag
        self.baseView.viewWithTag(UINoStruct.LANGUAGE_JP)?.hidden = flag
        self.baseView.viewWithTag(UINoStruct.LANGUAGE_EN)?.hidden = flag
        self.baseView.viewWithTag(UINoStruct.LANGUAGE_ES)?.hidden = flag
    }
    
    func close(){
        
        if(self.baseView.viewWithTag(UINoStruct.LANGUAGE_LABEL) != nil){
            var old: UILabel = self.baseView.viewWithTag(UINoStruct.LANGUAGE_LABEL) as UILabel
            old.removeFromSuperview()
        }
        if(self.baseView.viewWithTag(UINoStruct.LANGUAGE_JP) != nil){
            var old: UIButton = self.baseView.viewWithTag(UINoStruct.LANGUAGE_JP) as UIButton
            old.removeFromSuperview()
        }
        if(self.baseView.viewWithTag(UINoStruct.LANGUAGE_EN) != nil){
            var old: UIButton = self.baseView.viewWithTag(UINoStruct.LANGUAGE_EN) as UIButton
            old.removeFromSuperview()
        }
        if(self.baseView.viewWithTag(UINoStruct.LANGUAGE_ES) != nil){
            var old: UIButton = self.baseView.viewWithTag(UINoStruct.LANGUAGE_ES) as UIButton
            old.removeFromSuperview()
        }
    }
    
    func createJpButton()->UIButton {
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[4]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[24]!)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.getColor(self.BORDER_COLOR, alpha: self.BORDER_ALPHA).CGColor
        
        let image = UIImage(named: "Japan.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.LANGUAGE_JP)
        
        return button
    }
    
    func createEnButton()->UIButton {
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[4]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[8]!)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.getColor(self.BORDER_COLOR, alpha: self.BORDER_ALPHA).CGColor
        
        let image = UIImage(named: "United-Kingdom.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.LANGUAGE_EN)
        
        return button
    }
    
    func createEsButton()->UIButton {
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[4]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[16]!)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.getColor(self.BORDER_COLOR, alpha: self.BORDER_ALPHA).CGColor
        
        let image = UIImage(named: "Spain.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.LANGUAGE_ES)
        
        return button
    }
    
}