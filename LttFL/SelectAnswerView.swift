//
//  SelectAnswerView.swift
//  LttFL
//
//  Created by ken morobayashi on 2015/02/28.
//  Copyright (c) 2015年 ken morobayashi. All rights reserved.
//

import UIKit

class SelectAnswerView {
    var baseView:UIView!
    var sizeAdjuster:SizeAdjuster!
    let RESULT_COLOR = "ff8800"
    let RESULT_ALPHA = CGFloat(1.0)
    
    init(view:UIView){
        self.baseView = view
        self.sizeAdjuster = SizeAdjuster(view:view)
    }
    
    func hiddenAnswer(flag:Bool){
        for(var i = 0; i < UINoStruct.ANSWER.count; i++){
            self.baseView.viewWithTag(UINoStruct.ANSWER[i])?.hidden = flag
        }
        self.baseView.viewWithTag(UINoStruct.QUESTION_REPLAY)?.hidden = flag
    }
    func hiddenNext(flag:Bool){
        self.baseView.viewWithTag(UINoStruct.QUESTION_RESULT)?.hidden = flag
        self.baseView.viewWithTag(UINoStruct.QUESTION_NEXT)?.hidden = flag
        self.baseView.viewWithTag(UINoStruct.QUESTION_HOME)?.hidden = flag
    }
    
    func close(){
        for(var i = 0; i < UINoStruct.ANSWER.count; i++){
            ViewHelper.viewHelperInstance.removeFromSuperview(self.baseView, no: UINoStruct.ANSWER[i])
        }
        ViewHelper.viewHelperInstance.removeFromSuperview(self.baseView, no: UINoStruct.QUESTION_REPLAY)
        ViewHelper.viewHelperInstance.removeFromSuperview(self.baseView, no: UINoStruct.QUESTION_RESULT)
        ViewHelper.viewHelperInstance.removeFromSuperview(self.baseView, no: UINoStruct.QUESTION_NEXT)
        ViewHelper.viewHelperInstance.removeFromSuperview(self.baseView, no: UINoStruct.QUESTION_HOME)
    }
    
    func createAnswerButton(numbers:[Int],language:String,genre:String)->[UIButton] {
        
        var buttons:[UIButton]! = []
        for(var i = 0; i < UINoStruct.ANSWER.count; i++){
            var x = 8;
            var y = 8;
            if(i >= 3 && i < 6){
                x *= 2
            }else if(i >= 6){
                x *= 3
            }
            if(i % 3 == 1){
                y *= 2
            }else if(i % 3 == 2){
                y *= 3
            }
            
            // UIボタンを作成
            let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[3]!,self.sizeAdjuster.sizeDicHeight[3]!))
            button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[x]!, y:self.sizeAdjuster.sizeDicHeight[y]!)
            var filename = ""
            switch language {
            case "ja-JP":
                switch genre {
                case "number":
                    button.accessibilityHint = WordStruct.NUMBER[numbers[i]]
                    filename = WordStruct.NUMBER[numbers[i]] + ".png"
                    break
                case "fruit":
                    button.accessibilityHint = WordStruct.FRUIT_JP[numbers[i]]
                    filename = WordStruct.FRUIT_EN[numbers[i]] + ".png"
                    break
                case "vegetable":
                    button.accessibilityHint = WordStruct.VEGETABLE_JP[numbers[i]]
                    filename = WordStruct.VEGETABLE_EN[numbers[i]] + ".gif"
                    break
                default:
                    break
                }
                break
            case "en-GB":
                switch genre {
                case "number":
                    button.accessibilityHint = WordStruct.NUMBER[numbers[i]]
                    filename = WordStruct.NUMBER[numbers[i]] + ".png"
                    break
                case "fruit":
                    button.accessibilityHint = WordStruct.FRUIT_EN[numbers[i]]
                    filename = WordStruct.FRUIT_EN[numbers[i]] + ".png"
                    break
                case "vegetable":
                    button.accessibilityHint = WordStruct.VEGETABLE_EN[numbers[i]]
                    filename = WordStruct.VEGETABLE_EN[numbers[i]] + ".gif"
                    break
                default:
                    break
                }
                break
            case "es-ES":
                switch genre {
                case "number":
                    button.accessibilityHint = WordStruct.NUMBER[numbers[i]]
                    filename = WordStruct.NUMBER[numbers[i]] + ".png"
                    break
                case "fruit":
                    button.accessibilityHint = WordStruct.FRUIT_ES[numbers[i]]
                    filename = WordStruct.FRUIT_EN[numbers[i]] + ".png"
                    break
                case "vegetable":
                    button.accessibilityHint = WordStruct.VEGETABLE_ES[numbers[i]]
                    filename = WordStruct.VEGETABLE_EN[numbers[i]] + ".gif"
                    break
                default:
                    break
                }
                break
            default:
                break
            }
        
            let image = UIImage(named: filename)
            button.setImage(image, forState: .Normal)
            
            ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.ANSWER[i])
            buttons.append(button)
        }
        
        return buttons
    }
    
    func createNextButton(text:String)->UIButton {
        
        // Labelを作成.
        let labelResult = UILabel(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[24]!,self.sizeAdjuster.sizeDicHeight[4]!))
        labelResult.text = text
        labelResult.textColor = UIColor.getColor(self.RESULT_COLOR, alpha: self.RESULT_ALPHA)
        labelResult.textAlignment = NSTextAlignment.Center
        labelResult.font = UIFont(name: "Futura", size: 64)
        labelResult.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[12]!)
        ViewHelper.viewHelperInstance.addSubview(self.baseView,label:labelResult,no:UINoStruct.QUESTION_RESULT)
        
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[3]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[18]!)
        
        let image = UIImage(named: "next.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.QUESTION_NEXT)
        
        return button
    }
    
    func createHomeButton()->UIButton {
        
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[3]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[16]!, y:self.sizeAdjuster.sizeDicHeight[26]!)
        
        let image = UIImage(named: "home.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.QUESTION_HOME)
        
        return button
    }
    
    func createReplayButton()->UIButton {
        
        // UIボタンを作成
        let button = UIButton(frame: CGRectMake(0,0,self.sizeAdjuster.sizeDicWidth[3]!,self.sizeAdjuster.sizeDicHeight[3]!))
        button.layer.position = CGPoint(x: self.sizeAdjuster.sizeDicWidth[4]!, y:self.sizeAdjuster.sizeDicHeight[4]!)
        
        let image = UIImage(named: "play.png")
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.baseView , button:button , no:UINoStruct.QUESTION_REPLAY)
        
        return button
    }
}
