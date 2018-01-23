//
//  ConsentDocument.swift
//  ARKit
//
//  Created by Rumit Singh Tuteja on 10/31/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import ResearchKit

class ConsentDocument: NSObject {
    
    public var consentDocument:ORKConsentDocument{
        let consentDocument = ORKConsentDocument()
        consentDocument.title = "Example Consent"
        let consentSectionTypes: [ORKConsentSectionType] = [
            .overview,
            .dataGathering,
            .privacy,
            .dataUse,
            .timeCommitment,
            .studySurvey,
            .studyTasks,
            .withdrawing
        ]
        var consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
            let consentSection = ORKConsentSection(type: contentSectionType)
            consentSection.summary = "Please accept the terms and conditions for before starting the study"
            consentSection.content = "Please accept the terms and conditions for before starting the study"
            return consentSection
        }
        consentDocument.sections = consentSections
        consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
        return consentDocument
    }
    
    

    
}
