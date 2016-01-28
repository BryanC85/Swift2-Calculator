//
//  ViewController.swift
//  Calculator
//
//  Created by Bryan Carvalho on 1/28/16.
//  Copyright © 2016 Quakly. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum operation: String {
        case divide = "/"
        case multiply = "*"
        case subtract = "-"
        case add = "+"
        case empty = "empty"
    }
    @IBOutlet weak var outPutLbl: UILabel!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentoperation: operation = operation.empty
    var result = ""
    
    
    var buttonSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let path = NSBundle.mainBundle().pathForResource("Ka-Ching", ofType: ".wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
       try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton){
        playSound()
        runningNumber += "\(btn.tag)"
        outPutLbl.text = runningNumber
    }
 
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation.divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation.multiply)
        
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation.subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation.add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentoperation)
    }
    func processOperation(op: operation){
        playSound()
        
        if currentoperation != operation.empty{
          
            if runningNumber != ""{
                rightValString = runningNumber
                runningNumber = ""
                
                if currentoperation == operation.multiply{
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                }else if currentoperation == operation.divide{
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                }else if currentoperation == operation.subtract{
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }else if currentoperation == operation.add{
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outPutLbl.text = result
            }
        
            currentoperation = op
            
            
        }else{
            leftValString = runningNumber
            runningNumber = ""
            currentoperation = op
            
        }
    }
    
    @IBAction func clear(sender: AnyObject) {
        result = "0"
        runningNumber = ""
        leftValString = "0"
        outPutLbl.text = "0"
        
    }
    func playSound(){
        if buttonSound.playing{
            buttonSound.stop()
        }
        buttonSound.play()
    }
}

