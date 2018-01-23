//
//  Choices.swift
//  ARKit
//
//  Created by Sakshi Shrivastava on 12/12/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class Choices: NSObject {
    
    var nextQuestionId : String!
    var name : String!
    var id : String!
    
    init(name:String, nextQuestionId:String, id:String){
        self.name = name
        self.nextQuestionId = nextQuestionId
        self.id = id
    }
}
