//
//  JobTableViewCellViewModel.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation

class JobCellViewModel {
    var jobTitle: String
    var jobDescription: String
    var alreadyApplied: Bool
    
    init(job: Job) {
        self.jobTitle = job.jobTitle
        self.jobDescription = job.jobDescription
        self.alreadyApplied = job.alreadyApplied
    }
}
