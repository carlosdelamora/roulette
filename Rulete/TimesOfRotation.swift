//
//  TimesOfRotation.swift
//  Rulete
//
//  Created by Carlos De la mora on 11/2/17.
//  Copyright © 2017 carlosdelamora. All rights reserved.
//

import Foundation

class TimesOfRotation{
    
    var ballFirstTime: Double?
    var ballSecondTime: Double?
    var diskFirstTime: Double?
    var diskSecondTime: Double?
    var diskThirdTime: Double?
 
    let displacementByNumber:[String:Double] = [ "00":0.0, "1": 1/38, "13":2/28, "36": 3/38, "24": 4/38, "3": 5/38, "15":6/38,"34":7/38, "22":8/38,"5":9/38,"17":10/38,"32":11/38,"20":12/38,"7":13/38,"11":14/38,"30":15/38,"26":16/38,"9":17/38,"28":18/38,"0":19/38,"2":20/38,"14":21/38,"35":22/38,"23":23/38,"4":24/38,"16":25/38,"33":26/38,"21":27/38,"6":28/38,"18":29/38,"31":30/38,"19":31/38,"8":32/38,"12":33/38,"29":34/38,"25":35/38,"10":36/38,"27":37/38]
    /*guard let ballFirstTime = ballFirstTime, let ballSecondTime = ballSecondTime, let diskFirstTime = diskFirstTime, diskSecondTime = diskSecondTime, let diskThirdTime = diskThirdTime else {
    return nil
     }*/
    
    func acelerationForTwoTimes(time1:Double, time2:Double)-> Double{
        let aceleration = 2*(2*time1-time2)/(pow(time2, 2.0)*time1 - pow(time1,2.0)*time2)
        return aceleration
    }
    
    func velocityForTwoTimes(time1:Double, time2:Double)-> Double{
        let velocity = (2*pow(time1, 2) - pow(time2, 2))/(time2*pow(time1, 2.0) - time1*pow(time2, 2.0))
        return velocity
    }
    
    func ballAceleration()-> Double?{
        guard let ballFirstTime = ballFirstTime, let ballSecondTime = ballSecondTime else {
            return nil
        }
        
        let aceletarion = acelerationForTwoTimes(time1: ballFirstTime, time2: ballSecondTime)
        
        return aceletarion
    }
    
    func initalBallVelocity() -> Double? {
        guard let ballFirstTime = ballFirstTime, let ballSecondTime = ballSecondTime else {
            return nil
        }
        
        let velocity = velocityForTwoTimes(time1: ballFirstTime, time2: ballSecondTime)
        return velocity
    }
    
    func referenceTime() -> Double?{
        guard let aceletarion = self.ballAceleration(), let velocity = self.initalBallVelocity() else{
            return nil
        }
        let referenceVelocity = 0.25
        let referenceTime = (referenceVelocity - velocity)/aceletarion
        return referenceTime
    }
    
    //total distance should is given in revolutions
    func totalDistanceBall()-> Double?{
        guard let aceletarion = self.ballAceleration(), let velocity = self.initalBallVelocity(), let referenceTime = referenceTime() else{
            return nil
        }
        
        let distance = aceletarion*referenceTime*referenceTime/2 + velocity*referenceTime
        return distance
    }
    
    //we return an angle with the positon of the ball
    func ballPosition()-> Double?{
        guard let totalDistanceBall = self.totalDistanceBall() else {
            return nil
        }
        let positionReference = totalDistanceBall - floor(totalDistanceBall)
        return positionReference
    }
    
    func diskAceleration() -> Double? {
        guard let diskFirstTime = diskFirstTime, let diskSecondTime = diskSecondTime, let diskThirdTime = diskThirdTime else{
            return nil
        }
        
        let delta1 = diskSecondTime - diskFirstTime
        let delta2 = diskThirdTime - diskFirstTime
        //aceleration is given by revolutions per second^2
        let aceleration = acelerationForTwoTimes(time1: delta1, time2: delta2)
        return aceleration
    }
    
    //at what time is this velocity calculated at diskFirstTime?
    func diskVelocity() -> Double? {
        guard let diskFirstTime = diskFirstTime, let diskSecondTime = diskSecondTime, let diskThirdTime = diskThirdTime else{
            return nil
        }
        
        let delta1 = diskSecondTime - diskFirstTime
        let delta2 = diskThirdTime - diskFirstTime
        //aceleration is given by revolutions per second
        let velocity = velocityForTwoTimes(time1: delta1, time2: delta2)
        return velocity
    }
    
    func totalDistanceDisk()-> Double?{
        guard let aceleration = diskAceleration(), let velocity = diskVelocity(), let referenceTime = referenceTime(), let diskFirstTime = diskFirstTime else{
            return nil
        }
        
        let distance = aceleration/2*pow((referenceTime - diskFirstTime),2) + velocity*(referenceTime - diskFirstTime)
        return distance
    }
    
    //disk position in revolutions
    func diskPosition()-> Double?{
        guard let distance = totalDistanceDisk() else{
            return nil
        }
        
        let position = distance - floor(distance)
        return position
    }
    
    func referenceVelocityOfDisk()-> Double?{
        guard let aceleration = diskAceleration(), let referenceTime = referenceTime(), let diskFirstTime = diskFirstTime, let diskVelocity = diskVelocity() else{
            return nil
        }
        
        let referenceVelocity = aceleration*(referenceTime - diskFirstTime) + diskVelocity
        return referenceVelocity
    }
    
   
    
    func clearData(){
        ballFirstTime = nil
        ballSecondTime = nil
        diskFirstTime = nil
        diskSecondTime = nil
        diskThirdTime = nil
    }
    
    
    func realDisplacement(number: String)->Double?{
        let number = displacementByNumber[number]
        return number
    }
}
