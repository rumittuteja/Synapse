//
//  SurveyTask.swift
//  ARKit
//
//  Created by Rumit Singh Tuteja on 11/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import ResearchKit
class SurveyTask: NSObject {
    var dictSurvey:[String:Any]!
    func prepareSurvey() -> ORKNavigableOrderedTask{
        var steps = [ORKStep]()
        dictSurvey = Commons.dictSurvey
        let surveyTitle:String = String(describing:dictSurvey["title"]!)
        let studyId:String = String(describing:dictSurvey["studyId"]!)
        let surveyId:String = String(describing:dictSurvey["_id"]!)
        
        //TODO: add instructions step
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = surveyTitle
        instructionStep.text = " Welcome! We need to collect just a little health information from you. Select the correct answer."
        steps += [instructionStep]
        
        let quesObj = dictSurvey["questions"] as! NSArray
        var quesArray = [Questions]()
        for obj in quesObj {
            let dict = obj as! [String:Any]
            let choicesArray = dict["choices"] as! NSArray
            var choices = [Choices]()
            for choiceObj in choicesArray{
                var name:String!
                var nextQuest:String! = ""
                var id:String!
                let dictionary = choiceObj as! [String:Any]
                if let nextQuestion = dictionary["nextQuestion"] as? NSNumber{
                    nextQuest = nextQuestion.stringValue
                }
                name = String(describing:dictionary["name"]!)
                id = String(describing:dictionary["id"]!)
                let options = Choices(name:name, nextQuestionId:nextQuest, id:id)
                choices.append(options)
            }
            var low:String! = ""
            if let lowValue = dict["low"] as? NSNumber{
                low = lowValue.stringValue
            }
            var high:String! = ""
            if let highValue = dict["high"] as? NSNumber{
                high = highValue.stringValue
            }
            var step:String! = ""
            if let stepValue = dict["step"] as? NSNumber{
                step = stepValue.stringValue
            }
            let question = Questions(name:String(describing:dict["name"]!) , questionType:String(describing:dict["qtype"]!), choices:choices , id:String(describing:dict["id"]!), low:low, high:high, step:step)
            quesArray.append(question)
        }
        
        for questions in quesArray{
            
            
            if questions.questionType == "Multiple choice"{
                var textChoices = [ORKTextChoice]()
                for choices in questions.choices{
                    let ch = ORKTextChoice(text: choices.name, value: 1 as NSCoding & NSCopying & NSObjectProtocol)
                    textChoices.append(ch)
                }
                let nameAnswerFormat : ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
                let nameQuestionStepTitle = questions.name
                let nameQuestionStep = ORKQuestionStep(identifier: questions.id, title: nameQuestionStepTitle, answer: nameAnswerFormat)
                steps += [nameQuestionStep]
                
            } else if questions.questionType == "Open text"{
                let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
                nameAnswerFormat.multipleLines = false
                let nameQuestionStepTitle = questions.name
                let nameQuestionStep = ORKQuestionStep(identifier: questions.id, title: nameQuestionStepTitle, answer: nameAnswerFormat)
                steps += [nameQuestionStep]
            } else{
                let nameAnswerFormat = ORKAnswerFormat.continuousScale(withMaximumValue: Double(questions.high)!, minimumValue: Double(questions.low)!, defaultValue: 0, maximumFractionDigits: 0, vertical: false, maximumValueDescription: "All days", minimumValueDescription: "I am allergic")
                let nameQuestionStepTitle = questions.name
                let nameQuestionStep = ORKQuestionStep(identifier: questions.id, title: nameQuestionStepTitle, answer: nameAnswerFormat)
                steps += [nameQuestionStep]
                
            }
            
        }

        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Right. Off you go!"
        summaryStep.text = "That was easy!"
        steps += [summaryStep]
        
        let task = ORKNavigableOrderedTask(identifier: "task", steps: steps)
        
        for questions in quesArray{
            
            
            if questions.questionType == "Multiple choice"{
                
                var rulesArray = [ORKPredicateStepNavigationRule]()
                
                
                for choices in questions.choices{
                    if let nextStep = choices.nextQuestionId{
                        var rule : ORKPredicateStepNavigationRule
                        let resultSelector: ORKResultSelector
                        
                        resultSelector = ORKResultSelector(resultIdentifier: questions.id)
                        let predicate = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: choices.name! as NSCoding & NSCopying & NSObjectProtocol)
                        
                        rule = ORKPredicateStepNavigationRule(resultPredicates: [predicate],
                                                                       destinationStepIdentifiers: [questions.id],
                                                                       defaultStepIdentifier: nextStep,
                                                                       validateArrays: true)
                      rulesArray.append(rule)
                    }
                    
                }
                for rule in rulesArray {
                     task.setNavigationRule(rule, forTriggerStepIdentifier: questions.id)
                }
        }
    }
        return task
    }
    
    public var surveyTask:ORKNavigableOrderedTask{
        return prepareSurvey()
    }
    
}
