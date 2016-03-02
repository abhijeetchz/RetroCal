//
//  ViewController.swift
//  RetroCal
//
//  Created by Abhijeet Chaudhary on 17/01/16.
//  Copyright © 2016 Abhijeet Chaudhary. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    @IBOutlet weak var lblOutput: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblOutput.text = "0"
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
           try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(btn: UIButton!) {
        buttonSound.play()
        
        runningNumber += "\(btn.tag)"
        lblOutput.text = runningNumber
    }

    @IBAction func onDividePressedACTION(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    
    @IBAction func onMultiplyPressesACTION(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    
    @IBAction func onSubtractPressedACTION(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    
    @IBAction func onAddPressedACTION(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    
    @IBAction func onEqualPressedACTION(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
    func processOperation(op: Operation){
        playSound()
        if currentOperation != Operation.Empty{
            // do some math
            
            if runningNumber != ""{
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply{
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            }
            
            else if currentOperation == Operation.Divide{
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            }
            
            else if currentOperation == Operation.Subtract{
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            }
            
            else if currentOperation == Operation.Add{
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            
            leftValStr = result
            lblOutput.text = result
            }
            currentOperation = op
        }
        else {
            // when the operator is pressed
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound(){
        if buttonSound.playing{
            buttonSound.stop()
    }
        buttonSound.play()
    }
    
    @IBAction func btnClearACTION(sender: AnyObject) {
        buttonSound.play()
        lblOutput.text = "0"
        runningNumber = ""
        leftValStr = "0"
        rightValStr = "0"
        currentOperation = Operation.Empty
        
    }
    
}

