//
//  JobDetailsViewControllerViewModel.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation
class JobDetailsViewControllerViewModel: BaseViewModel {
    
    @Published var jobTitle: String = ""
    @Published var jobDescription: String = ""
    @Published var alreadyApplied: Bool = false
    @Published var jobSalary: String = ""

    /// TODO: Add a PublishSubject to observe the changes in the job details, so once status is updated, we can update the JobList UI
    
    private var jobId: String
    private let apiService: NetworkService
    
    init(apiService: NetworkService, jobId: String) {
        self.apiService = apiService
        self.jobId = jobId
        super.init()
        self.fetchJobDetails()
    }
    
    func fetchJobDetails() {
        self.apiService.fetchJobDetails(jobId: self.jobId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let job):
                self.jobTitle = job.jobTitle
                self.jobDescription = job.jobDescription
                self.alreadyApplied = job.alreadyApplied
                
                if let minSalary = job.salaryRange?.min,
                   let maxSalary = job.salaryRange?.max {
                    self.jobSalary = "Salary range: \(minSalary) - \(maxSalary)"
                }
                
            case .failure(let error):
                Utilities.displayAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func apply() {
        guard !alreadyApplied else { return }
        
        self.apiService.applyToJob(jobId: self.jobId) { [weak self] result in
            switch result {
            case .success(let status):
                self?.alreadyApplied = status
                if status {
                    Utilities.displayAlert(title: "Great!", message: "Successfully applied the job")
                } else {
                    Utilities.displayAlert(title: "Something went wrong!", message: "Unable to apply for this job.")
                }
                
            case .failure(let error):
                Utilities.displayAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
