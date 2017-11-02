//
//  RecordsViewController.swift
//  Rulete
//
//  Created by Carlos De la mora on 10/30/17.
//  Copyright © 2017 carlosdelamora. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {

    
    var rulet: Rulet!
    var timer: Timer?
    var ballTimer: Timer?
    var countDoubleZeroButtonPressed: Int = 0
    var countBallButtonPressed: Int = 0
    var count = 0.0
    //outlets
    @IBOutlet weak var segmentForSizeOfBall: UISegmentedControl!
    @IBOutlet weak var leftRightSwitch: UISwitch!
    @IBOutlet weak var doubleZeroButton: UIButton!
    @IBOutlet weak var ballButton: UIButton!
    @IBOutlet weak var doubleZeroTimerLabel: UILabel!
    @IBOutlet weak var ballTimerLabel: UILabel!
    
    @IBOutlet weak var firstBallLabel: UILabel!
    @IBOutlet weak var secondBallLabel: UILabel!
    
    
    @IBOutlet weak var firstDoubleZeroLabel: UILabel!
    @IBOutlet weak var secondDoubleZeroLabel: UILabel!
    @IBOutlet weak var thirdDoubleZeroButton: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doubleZeroButton.layer.cornerRadius = doubleZeroButton.frame.width/2
        ballButton.layer.cornerRadius = ballButton.frame.width/2
        title = rulet.iDRuleta
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doubleZeroWasPressed(_ sender: Any) {
        print("print double zero was pressed ")
    }
    
    @IBAction func ballButtonWasPressed(_ sender: Any) {
        
        print("ball was pressed")
        countBallButtonPressed += 1
        
        let timeInterval = 0.01
        switch countBallButtonPressed{
        case 1:
            //first time we run the clock
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block:{ _ in
                self.count += 1.0
                let timeIntervalElapsed = self.count*timeInterval
                DispatchQueue.main.async {
                    self.ballTimerLabel.text = self.stringFromTimeInterval(interval: timeIntervalElapsed)
                }
                
            } )
        case 2:
            //second click we record the
            firstBallLabel.text = stringFromTimeInterval(interval: count*timeInterval)
        case 3:
            //second click we record and stop the label
            secondBallLabel.text = stringFromTimeInterval(interval: count*timeInterval)
            timer?.invalidate()
        default:
            break
        }
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let ti = Int(interval)
        
        let ms = Int((interval.truncatingRemainder(dividingBy: 1))*100)
        let seconds = ti % 60
        
        return String(format: "%0.2d.%.2d",seconds,ms)
    }

}


