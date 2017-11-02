//
//  Dealer.swift
//  Rulete
//
//  Created by Carlos De la mora on 10/30/17.
//  Copyright © 2017 carlosdelamora. All rights reserved.
//

import Foundation


class Rulet{
    
    var iDRuleta:String
    var tipoDeBola:String
    var leftOrRight:String
    
    init(id:String, tipoDeBola:String, leftOrRight: String){
        self.iDRuleta = id
        self.tipoDeBola = tipoDeBola
        self.leftOrRight = leftOrRight
    }
}
