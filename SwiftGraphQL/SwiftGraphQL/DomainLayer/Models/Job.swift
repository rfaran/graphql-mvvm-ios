//
//  Job.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation
import SwiftGraphQLAPI

/// Job Model
/// This is a domain specific model, we do not rely on the model from the API (We can use RestAPI or Apollo Client to generate models from API)
/// We can also use Codable to decode the JSON response from the API

struct Job {
    let jobId: String
    let jobTitle: String
    let jobDescription: String
    let alreadyApplied: Bool
    let salaryRange: SalaryRange?
    
    init(jobId: String, jobTitle: String, jobDescription: String, alreadyApplied: Bool, salaryRange: SalaryRange?) {
        self.jobId = jobId
        self.jobTitle = jobTitle
        self.jobDescription = jobDescription
        self.alreadyApplied = alreadyApplied
        self.salaryRange = salaryRange
    }
    
    init?(job: ActiveJobsQuery.Data.Active.Job?) {
        guard let job = job,
              let jobId = job._id,
              let jobTitle = job.positionTitle,
              let jobDescription = job.description,
              let alreadyApplied = job.haveIApplied else { return nil }
        self.jobId = jobId
        self.jobTitle = jobTitle
        self.jobDescription = jobDescription
        self.alreadyApplied = alreadyApplied
        self.salaryRange = nil
    }
    
    init?(job: JobDetailsQuery.Data.Job?) {
        guard let job = job,
              let jobId = job._id,
              let jobTitle = job.positionTitle,
              let jobDescription = job.description,
              let alreadyApplied = job.haveIApplied,
              let salaryRange = job.salaryRange else { return nil }
        
        self.jobId = jobId
        self.jobTitle = jobTitle
        self.jobDescription = jobDescription
        self.alreadyApplied = alreadyApplied
        self.salaryRange = SalaryRange(salaryRange: salaryRange)
    }    
}
