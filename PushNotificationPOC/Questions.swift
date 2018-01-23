//
//  Questions.swift
//  ARKit
//
//  Created by Sakshi Shrivastava on 12/12/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class Questions: NSObject {

    var name : String!
    var questionType : String!
    var choices: [Choices] = []
    var id : String!
    var low : String!
    var high : String!
    var step : String!
    
    
    init(name:String, questionType:String, choices:[Choices], id:String, low:String, high:String, step:String){
        self.name = name
        self.questionType = questionType
        self.choices = choices
        self.id = id
        self.low = low
        self.high = high
        self.step = step
    }
    
}
