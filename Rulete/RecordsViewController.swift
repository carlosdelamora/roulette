//
//  RecordsViewController.swift
//  Rulete
//
//  Created by Carlos De la mora on 10/30/17.
//  Copyright © 2017 carlosdelamora. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {

    
    var rulet: Roulette!
    var timer: Timer?
    var ballTimer: Timer?
    var countDoubleZeroButtonPressed: Int = 0
    var countBallButtonPressed: Int = 0
    var count = 0.0
    var timesOfRotation = TimesOfRotation()
    var areWeDoneWithBall:Bool = false
    var areWeDoneWithDisk:Bool = false
    //outlets
    @IBOutlet weak var segmentForSizeOfBall: UISegmentedControl!
    @IBOutlet weak var leftRightSwitch: UISwitch!
    @IBOutlet weak var doubleZeroButton: UIButton!
    @IBOutlet weak var ballButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var firstBallLabel: UILabel!
    @IBOutlet weak var secondBallLabel: UILabel!
    
    
    @IBOutlet weak var firstDoubleZeroLabel: UILabel!
    @IBOutlet weak var secondDoubleZeroLabel: UILabel!
    @IBOutlet weak var thirdDoubleZeroLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var resultTextField: UITextField!
    
    
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var betIntervalTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doubleZeroButton.layer.cornerRadius = doubleZeroButton.frame.width/2
        ballButton.layer.cornerRadius = ballButton.frame.width/2
        title = rulet.iDRuleta
        saveButton.layer.cornerRadius = 5
        clearButton.layer.cornerRadius = 5
        resultTextField.delegate = self
        resultTextField.keyboardType = .numberPad
        timeTextField.delegate = self
        timeTextField.keyboardType = .decimalPad
        betIntervalTextField.delegate = self
        betIntervalTextField.keyboardType = .numberPad
        
        //return the keyboard when somone touches the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doubleZeroWasPressed(_ sender: Any) {
        print("print double zero was pressed ")
        countDoubleZeroButtonPressed += 1
        
        let timeInterval = 0.01
        switch countDoubleZeroButtonPressed{
        case 1:
            //second click we record the
            firstDoubleZeroLabel.text = stringFromTimeInterval(interval: count*timeInterval)
            timesOfRotation.diskFirstTime = timeInterval*count
        case 2:
            //second click we record and stop the label
            secondDoubleZeroLabel.text = stringFromTimeInterval(interval: count*timeInterval)
            timesOfRotation.diskSecondTime = timeInterval*count
        case 3:
            //third click we record and
            thirdDoubleZeroLabel.text = stringFromTimeInterval(interval: count*timeInterval)
            timesOfRotation.diskThirdTime = timeInterval*count
            doubleZeroButton.alpha = 0.25
            areWeDoneWithDisk = false
            if areWeDoneWithBall{
                timer?.invalidate()
            }
        default:
            break
        }
    }
    
    @IBAction func ballButtonWasPressed(_ sender: Any) {
        
        print("ball was pressed")
        countBallButtonPressed += 1
        
        let timeInterval = 0.01
        switch countBallButtonPressed{
          
        case 1:
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block:{ _ in
                self.count += 1.0
                let timeIntervalElapsed = self.count*timeInterval
                DispatchQueue.main.async {
                    self.timerLabel.text = self.stringFromTimeInterval(interval: timeIntervalElapsed)
                }
                
            } )
        case 2:
            
           
            //second click we record the
            firstBallLabel.text = stringFromTimeInterval(interval: count*timeInterval)
            timesOfRotation.ballFirstTime = timeInterval*count
        case 3:
            //second click we record and stop the label
            secondBallLabel.text = stringFromTimeInterval(interval: count*timeInterval)
            ballButton.alpha = 0.25
            timesOfRotation.ballSecondTime = timeInterval*count
            areWeDoneWithBall = true
            if areWeDoneWithDisk{
                timer?.invalidate()
            }
        default:
            break
        }
        
        
        
    }
    
    @IBAction func save(_ sender: Any) {
        clearValues()
    }
    
    @IBAction func clear(_ sender: Any) {
        clearValues()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let ti = Int(interval)
        
        let ms = Int((interval.truncatingRemainder(dividingBy: 1))*100)
        let seconds = ti % 60
        
        return String(format: "%0.2d.%.2d",seconds,ms)
    }
    
    func clearValues(){
        doubleZeroButton.alpha = 1
        firstDoubleZeroLabel.text = ""
        secondDoubleZeroLabel.text = ""
        thirdDoubleZeroLabel.text = ""
        
        ballButton.alpha = 1
        firstBallLabel.text = ""
        secondBallLabel.text = ""
        timer?.invalidate()
        countDoubleZeroButtonPressed = 0
        countBallButtonPressed = 0
        count = 0
        
        resultTextField.text = ""
        timerLabel.text = ""
        
        areWeDoneWithDisk = false
        areWeDoneWithBall = false
    }

}

extension RecordsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        //location is 2 means two characters
        if range.location == 1{
            if let _ = textField.text{
                textField.text! += string
                textField.resignFirstResponder()
            }
        }
     
        return true
    }*/
    
}
