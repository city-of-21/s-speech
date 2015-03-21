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
    
    var rate:Float = 0.1 //速度
    let pitchMultiplier:Float = 1.8 //高さ
    var preUtteranceDelay:NSTimeInterval = 0.1 //インターバル秒
    
    var language = "ja-JP" //言語
    var genre = "fruit" //ジャンル
    
    var selectLanguageView:SelectLanguageView!
    var selectGenreView:SelectGenreView!
    var selectAnswerView:SelectAnswerView!
    
    var words:[String]!
    var questionNumbers:[Int]!
    var correctNumber:Int! = 0
    var score:[Bool]! = []
    var continueCorrect:Int = 0
    
    var result = ""
    
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
    func createAnswerView(){
        let answerButtons = selectAnswerView.createAnswerButton(self.questionNumbers,language: self.language,genre: self.genre)
        for(var i = 0; i < answerButtons.count; i++){
            answerButtons[i].addTarget(self, action: "onClickAnswerButton:", forControlEvents: .TouchUpInside)
        }
        let replayButton = selectAnswerView.createReplayButton()
        replayButton.addTarget(self, action: "onClickReplayButton:", forControlEvents: .TouchUpInside)
    }
    func createNextView(){
        let nextButton = self.selectAnswerView.createNextButton(self.result)
        let homeButton = self.selectAnswerView.createHomeButton()
        //イベント追加
        nextButton.addTarget(self, action: "onClickNextButton:", forControlEvents: .TouchUpInside)
        homeButton.addTarget(self, action: "onClickHomeButton:", forControlEvents: .TouchUpInside)
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
        
        self.language = "en-GB"
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
        self.genre = "number"
        words = WordStruct.NUMBER
        self.selectGenreView.hidden(true)
        self.speech(self.getQuestion())
        self.createAnswerView()
    }
    // ボタンイベント
    func onClickFruitButton(sender: UIButton){
        self.genre = "fruit"
        switch self.language {
        case "ja-JP":
            self.words = WordStruct.FRUIT_JP
            break
        case "en-GB":
            self.words = WordStruct.FRUIT_EN
            break
        case "es-ES":
            self.words = WordStruct.FRUIT_ES
            break
        default:
            self.words = WordStruct.FRUIT_JP
            break
        }
        self.selectGenreView.hidden(true)
        self.speech(self.getQuestion())
        self.createAnswerView()
    }
    // ボタンイベント
    func onClickVegetableButton(sender: UIButton){
        self.genre = "vegetable"
        switch self.language {
        case "ja-JP":
            self.words = WordStruct.VEGETABLE_JP
            break
        case "en-GB":
            self.words = WordStruct.VEGETABLE_EN
            break
        case "es-ES":
            self.words = WordStruct.VEGETABLE_ES
            break
        default:
            self.words = WordStruct.VEGETABLE_JP
            break
        }
        self.selectGenreView.hidden(true)
        self.speech(self.getQuestion())
        self.createAnswerView()
    }
    // ボタンイベント
    func onClickAnswerButton(sender: UIButton){
        
        var selectLanguage = self.language
        self.language = "en-US"
        
        self.selectAnswerView.hiddenNext(false)
        self.selectAnswerView.hiddenAnswer(true)
        self.result = ""
        if(sender.accessibilityHint == self.words![self.correctNumber]){
            //正解
            self.score.append(true)
            self.continueCorrect++
            self.result = self.getAnswerGood()
            self.speech(result)
        }else{
            //不正解
            score.append(false)
            self.continueCorrect = 0
            self.result = self.getAnswerBad()
            self.speech(result)
            
        }
        
        self.language = selectLanguage
        
        self.createNextView()
    }
    // ボタンイベント
    func onClickNextButton(sender: UIButton){
        
        self.speech(self.getQuestion())
        self.createAnswerView()
        
        self.selectAnswerView.hiddenNext(true)
        self.selectAnswerView.hiddenAnswer(false)
        
    }
    // ボタンイベント
    func onClickHomeButton(sender: UIButton){
        self.selectAnswerView.hiddenNext(true)
        self.selectAnswerView.hiddenAnswer(true)
        self.createView()
    }
    // ボタンイベント
    func onClickReplayButton(sender: UIButton){
        self.speech(self.words![self.correctNumber])
    }
    
    func getQuestion()->NSString{
        var text = ""
        self.questionNumbers = []
        var choice = Int(arc4random() % 9)
        for(var i = 0; i < UINoStruct.ANSWER.count; i++){
            var ok = false;
            var number = Int(arc4random() % 20)
            while(!ok){
                ok = true
                number = Int(arc4random() % 20)
                //出題数より多いNG
                if(number >= self.words!.count){
                    ok = false
                }
                //前回の正解NG
                if(number == self.correctNumber){
                    ok = false
                }
                if(ok){
                    //すでに選択済みNG
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
    
    // 回転イベント
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        if(self.view.viewWithTag(UINoStruct.LANGUAGE_LABEL) != nil && !self.view.viewWithTag(UINoStruct.LANGUAGE_LABEL)!.hidden){
            self.createView()
            self.selectGenreView.hidden(true)
            self.selectLanguageView.hidden(false)
        }else if(self.view.viewWithTag(UINoStruct.GENRE_LABEL) != nil && !self.view.viewWithTag(UINoStruct.GENRE_LABEL)!.hidden){
            self.createView()
            self.selectLanguageView.hidden(true)
            self.selectGenreView.hidden(false)
        }else if(self.view.viewWithTag(UINoStruct.QUESTION_REPLAY) != nil && !self.view.viewWithTag(UINoStruct.QUESTION_REPLAY)!.hidden){
            self.selectAnswerView = SelectAnswerView(view:self.view)
            self.createAnswerView()
            self.selectAnswerView.hiddenNext(true)
            self.selectAnswerView.hiddenAnswer(false)
        }else if(self.view.viewWithTag(UINoStruct.QUESTION_RESULT) != nil && !self.view.viewWithTag(UINoStruct.QUESTION_RESULT)!.hidden){
            self.selectAnswerView = SelectAnswerView(view:self.view)
            self.createNextView()
            self.selectAnswerView.hiddenAnswer(true)
            self.selectAnswerView.hiddenNext(false)
        }
    }
    
}

