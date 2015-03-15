//  List To The Foreign Language
//
//  ViewController.swift
//  LttFL
//
//  Created by ken morobayashi on 2015/02/21.
//  Copyright (c) 2015年 ken morobayashi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {

    var talker = AVSpeechSynthesizer()
    
    var language = "ja-JP" //言語
    var rate:Float = 0.1 //速度
    let pitchMultiplier:Float = 1.8 //高さ
    var preUtteranceDelay:NSTimeInterval = 0.1 //インターバル秒
    
    var selectLanguageView:SelectLanguageView!
    var selectGenreView:SelectGenreView!
    var selectAnswerView:SelectAnswerView!
    
    var words:[String]!
    var questionNumbers:[Int]!
    var correctNumber:Int!
    var score:[Bool]! = []
    var continueCorrect:Int = 0
    
    //タイマー
    var timer : NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.talker.delegate = self
        createView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance!){
        /*
        let word = (utterance.speechString as NSString).substringWithRange(characterRange)
        let button = UIButton(frame: CGRectMake(0,0,100,100))
        button.layer.position = CGPoint(x: 100, y:100)
        
        var iconname = word + ".png"
        let image = UIImage(named: iconname)
        button.setImage(image, forState: .Normal)
        
        ViewHelper.viewHelperInstance.addSubview(self.view , button:button , no:9999)
        */
    }
    
    func createView(){
        
        // 言語選択
        self.selectLanguageView = SelectLanguageView(view:self.view)
        let jpButton = selectLanguageView.createJpButton()
        let enButton = selectLanguageView.createEnButton()
        let esButton = selectLanguageView.createEsButton()
        
        //イベント追加
        jpButton.addTarget(self, action: "onClickJpButton:", forControlEvents: .TouchUpInside)
        enButton.addTarget(self, action: "onClickEnButton:", forControlEvents: .TouchUpInside)
        esButton.addTarget(self, action: "onClickEsButton:", forControlEvents: .TouchUpInside)
        
        // ジャンル選択
        self.selectGenreView = SelectGenreView(view:self.view)
        let numberButton = selectGenreView.createNumberButton()
        let fruitButton = selectGenreView.createFruitButton()
        let vegetableButton = selectGenreView.createVegetableButton()
        self.selectGenreView.hidden(true)
        //イベント追加
        numberButton.addTarget(self, action: "onClickNumberButton:", forControlEvents: .TouchUpInside)
        fruitButton.addTarget(self, action: "onClickFruitButton:", forControlEvents: .TouchUpInside)
        vegetableButton.addTarget(self, action: "onClickVegetableButton:", forControlEvents: .TouchUpInside)
        
        // 解答
        self.selectAnswerView = SelectAnswerView(view:self.view)
    }
    
    // ボタンイベント
    func onClickJpButton(sender: UIButton){
        
        self.language = "ja-JP"
        // ジャンル選択
        self.selectLanguageView.hidden(true)
        self.selectGenreView.hidden(false)
    }
    // ボタンイベント
    func onClickEnButton(sender: UIButton){
        
        self.language = "en-US"
        // ジャンル選択
        self.selectLanguageView.hidden(true)
        self.selectGenreView.hidden(false)
    }
    // ボタンイベント
    func onClickEsButton(sender: UIButton){
        
        self.language = "es-ES"
        // ジャンル選択
        self.selectLanguageView.hidden(true)
        self.selectGenreView.hidden(false)
    }
    // ボタンイベント
    func onClickNumberButton(sender: UIButton){
        words = WordStruct.NUMBER
        self.selectGenreView.hidden(true)
        self.speech(self.getQuestion())
        let answerButtons = selectAnswerView.createAnswerButton(self.questionNumbers)
        for(var i = 0; i < answerButtons.count; i++){
            answerButtons[i].addTarget(self, action: "onClickAnswerButton:", forControlEvents: .TouchUpInside)
        }
        
    }
    // ボタンイベント
    func onClickFruitButton(sender: UIButton){
        switch self.language {
        case "ja-JP":
            words = WordStruct.FRUIT_JP
            break
        case "en-US":
            words = WordStruct.FRUIT_EN
            break
        case "es-ES":
            words = WordStruct.FRUIT_ES
            break
        default:
            words = WordStruct.FRUIT_JP
            break
        }
        self.selectGenreView.hidden(true)
        self.speech(self.getQuestion())
        let answerButtons = selectAnswerView.createAnswerButton(self.questionNumbers)
        for(var i = 0; i < answerButtons.count; i++){
            answerButtons[i].addTarget(self, action: "onClickAnswerButton:", forControlEvents: .TouchUpInside)
        }
    }
    // ボタンイベント
    func onClickVegetableButton(sender: UIButton){
        switch self.language {
        case "ja-JP":
            words = WordStruct.VEGETABLE_JP
            break
        case "en-US":
            words = WordStruct.VEGETABLE_EN
            break
        case "es-ES":
            words = WordStruct.VEGETABLE_ES
            break
        default:
            words = WordStruct.VEGETABLE_JP
            break
        }
        self.selectGenreView.hidden(true)
        self.speech(self.getQuestion())
    }
    // ボタンイベント
    func onClickAnswerButton(sender: UIButton){
        
        self.selectAnswerView.hiddenNext(false)
        self.selectAnswerView.hiddenAnswer(true)
        var result = ""
        if(sender.accessibilityHint == self.words![self.correctNumber]){
            //正解
            self.score.append(true)
            self.continueCorrect++
            result = self.getAnswerGood()
            self.speech(result)
        }else{
            //不正解
            score.append(false)
            self.continueCorrect = 0
            result = self.getAnswerBad()
            self.speech(result)
            
        }
        let nextButton = self.selectAnswerView.createNextButton(result)
        //イベント追加
        nextButton.addTarget(self, action: "onClickNextButton:", forControlEvents: .TouchUpInside)
        
        //self.timer(true)
    }
    // ボタンイベント
    func onClickNextButton(sender: UIButton){
        
        self.speech(self.getQuestion())
        let answerButtons = selectAnswerView.createAnswerButton(self.questionNumbers)
        for(var i = 0; i < answerButtons.count; i++){
            answerButtons[i].addTarget(self, action: "onClickAnswerButton:", forControlEvents: .TouchUpInside)
        }
        self.selectAnswerView.hiddenNext(true)
        self.selectAnswerView.hiddenAnswer(false)
        
    }
    func getQuestion()->NSString{
        var text = ""
        self.questionNumbers = []
        self.correctNumber = 0
        var choice = Int(arc4random() % 9)
        for(var i = 0; i < UINoStruct.ANSWER.count; i++){
            var ok = false;
            var number = Int(arc4random() % 20)
            while(!ok){
                ok = true
                number = Int(arc4random() % 20)
                if(number >= self.words!.count){
                    ok = false
                }
                if(ok){
                    for(var j = 0; j < self.questionNumbers.count; j++){
                        if(self.questionNumbers[j] == number){
                            ok = false
                            break
                        }
                    }
                }
            }
            questionNumbers.append(number)
            if(i == choice){
                self.correctNumber = number
            }
        }
        println(questionNumbers)
        return self.words![self.correctNumber]
    }
    
    func getAnswerGood()->NSString{
        var praise = ""
        var random = Int(arc4random() % 2)
        if(self.continueCorrect < 5){
            praise = WordStruct.PRAISE_1_EN[random]
        }else if(self.continueCorrect >= 5 && self.continueCorrect < 10){
            praise = WordStruct.PRAISE_2_EN[random]
        }else{
            praise = WordStruct.PRAISE_3_EN[random]
        }
        return praise
    }
    
    func getAnswerBad()->NSString{
        return "bad"
    }
    
    func speech(text:NSString){
        
        // 話す内容をセット
        var utterance = AVSpeechUtterance(string:text)
        // 言語を設定
        utterance.voice = AVSpeechSynthesisVoice(language: self.language)
        utterance.rate = self.rate
        utterance.pitchMultiplier = self.pitchMultiplier
        // 実行
        self.talker.speakUtterance(utterance)
    }
    
}

