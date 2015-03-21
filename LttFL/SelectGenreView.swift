//
//  SelectGenreView.swift
//  LttFL
//
//  Created by ken morobayashi on 2015/02/22.
//  Copyright (c) 2015年 ken morobayashi. All rights reserved.
//

import UIKit

class SelectGenreView {
    var baseView:UIView!
    var sizeAdjuster:SizeAdjuster!
    let LABEL_COLOR = "ff8800"
    let LABEL_ALPHA = CGFloat(1.0)
    
    init(view:UIView){
        self.baseView = view
        self.sizeAdjuster = SizeAdjuster(view:view)
        
        // Labelを作成.
        let label = UILabel(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[24]!,self.sizeAdjuster.sizeDicHeight[4]!))
        label.text = "select genre"
        label.textColor = UIColor.getColor(self.LABEL_COLOR, alpha: self.LABEL_ALPHA)
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "Futura", size: 32)
        label.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[4]!)
        ViewHelper.viewHelperInstance.addSubview(self.baseView,label:label,no:UINoStruct.GENRE_LABEL)
    }
    
    func hidden(flag:Bool){
        self.baseView.viewWithTag(UINoStruct.GENRE_LABEL)?.hidden = flag
        self.baseView.viewWithTag(UINoStruct.GENRE_NUMBER)?.hidden = flag
        self.baseView.viewWithTag(UINoStruct.GENRE_FRUIT)?.hidden = flag
        self.baseView.viewWithTag(UINoStruct.GENRE_VEGETABLE)?.hidden = flag
    }
    
    func close(){
        
        if(self.baseView.viewWithTag(UINoStruct.GENRE_LABEL) != nil){
            var old: UILabel = self.baseView.viewWithTag(UINoStruct.GENRE_LABEL) as UILabel
            old.removeFromSuperview()
        }
        if(self.baseView.viewWithTag(UINoStruct.GENRE_NUMBER) != nil){
            var old: UIButton = self.baseView.viewWithTag(UINoStruct.GENRE_NUMBER) as UIButton
            old.removeFromSuperview()
        }
        if(self.baseView.viewWithTag(UINoStruct.GENRE_FRUIT) != nil){
            var old: UIButton = self.baseView.viewWithTag(UINoStruct.GENRE_FRUIT) as UIButton
            old.removeFromSuperview()
        }
        if(self.baseView.viewWithTag(UINoStruct.GENRE_VEGETABLE) != nil){
            var old: UIButton = self.baseView.viewWithTag(UINoStruct.GENRE_VEGETABLE) as UIButton
            old.removeFromSuperview()
        }
    }
    
    func createNumberButton()->UIButton {
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[3]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[8]!)
        
        let image = UIImage(named: "10.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.GENRE_NUMBER)
        
        return button
    }
    
    func createFruitButton()->UIButton {
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[3]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[16]!)
        
        let image = UIImage(named: "apple.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.GENRE_FRUIT)
        
        return button
    }
    
    func createVegetableButton()->UIButton {
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[3]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[24]!)
        
        let image = UIImage(named: "cabbage.gif")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.GENRE_VEGETABLE)
        
        return button
    }
}