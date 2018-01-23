//
//  ConsentTask.swift
//  ARKit
//
//  Created by Rumit Singh Tuteja on 10/31/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import ResearchKit

class ConsentTask: NSObject {
    public var consentTask: ORKOrderedTask {
        
        var steps = [ORKStep]()
        
        var consentDocument = ConsentDocument()
        let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument.consentDocument)
        steps += [visualConsentStep]
        
        let signature = consentDocument.consentDocument.signatures!.first! as ORKConsentSignature
        
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument.consentDocument)
        
        reviewConsentStep.text = "Review Consent!"
        reviewConsentStep.reasonForConsent = "Consent to join study"
        
        steps += [reviewConsentStep]
        return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
    }
}
