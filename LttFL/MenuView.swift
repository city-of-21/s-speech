//
//  MenuView.swift
//  LttFL
//
//  Created by ken morobayashi on 2015/02/21.
//  Copyright (c) 2015年 ken morobayashi. All rights reserved.
//

import UIKit

class MenuView {
    var baseView:UIView!
    var sizeAdjuster:SizeAdjuster!
    
    init(view:UIView){
        self.baseView = view
        self.sizeAdjuster = SizeAdjuster(view:view)
    }
    
    func close(){
        
        if(self.baseView.viewWithTag(UINoStruct.MENU_BASE) != nil){
            var old: UIVisualEffectView = self.baseView.viewWithTag(UINoStruct.MENU_BASE) as UIVisualEffectView
            old.removeFromSuperview()
        }
        if(self.baseView.viewWithTag(UINoStruct.BUTTON_CAMERA) != nil){
            var old: UIButton = self.baseView.viewWithTag(UINoStruct.BUTTON_CAMERA) as UIButton
            old.removeFromSuperview()
        }
        if(self.baseView.viewWithTag(UINoStruct.BUTTON_CAMERA_CHANGE) != nil){
            var old: UIButton = self.baseView.viewWithTag(UINoStruct.BUTTON_CAMERA_CHANGE) as UIButton
            old.removeFromSuperview()
        }
        if(self.baseView.viewWithTag(UINoStruct.BUTTON_GRID) != nil){
            var old: UIButton = self.baseView.viewWithTag(UINoStruct.BUTTON_GRID) as UIButton
            old.removeFromSuperview()
        }
    }
    
    func createViewEffectBlur() {
        // Blurエフェクトを適用するEffectViewを作成
        var effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var effectView : UIVisualEffectView!
        if effectView != nil {
            effectView.removeFromSuperview()
        }
        effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRectMake(0, 0, self.baseView.bounds.width, self.sizeAdjuster.sizeDicHeight[3]!)
        effectView.layer.position = CGPoint(x: self.sizeAdjuster.getRateWidth(0.5), y:self.sizeAdjuster.sizeDicHeight[30]!)
        effectView.layer.masksToBounds = true
        effectView.layer.cornerRadius = 20.0
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , effectView:effectView , no:UINoStruct.MENU_BASE)
    }
    
    func createCameraButton()->UIButton {
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[6]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.getRateWidth(0.5), y:self.sizeAdjuster.sizeDicHeight[30]!)
        
        let image = UIImage(named: "cam.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.BUTTON_CAMERA)
        
        return button
    }
    
    func createCameraChangeButton()->UIButton {
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[6]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.getRateWidth(0.25), y:self.sizeAdjuster.sizeDicHeight[30]!)
        
        let image = UIImage(named: "camc.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.BUTTON_CAMERA_CHANGE)
        return button
    }
    
    func createGridButton()->UIButton {
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[6]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.getRateWidth(0.75), y:self.sizeAdjuster.sizeDicHeight[30]!)
        let image = UIImage(named: "camg.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.BUTTON_GRID)
        return button
    }
    
}
