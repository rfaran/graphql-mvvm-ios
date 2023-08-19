//
//  MockNetworkService.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation

/// This class implements NetworkService protocol
/// MockNetworkService for mocking data, can be used for unit tests
class MockNetworkService: NetworkService {
    static let shared = MockNetworkService()
}

extension MockNetworkService {
    func login(username: String, password: String, completion: @escaping (Result<String, NetworkError>) -> ()) {
        
        //completion(.failure(.serverError))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            completion(.success("dummy-auth-token"))
        }
    }
    
    func fetchJobs(page: Int, completion: @escaping (Result<([Job], Bool), NetworkError>) -> ()) {
        /// For now, lets return dummy jobs list
        
        var jobs: [Job] = []
        for i in 1...10 {
            jobs.append(
                Job(jobId: "\(i)",
                    jobTitle: "Job \(i)",
                    jobDescription: "Description for Job \(i)",
                    alreadyApplied: i % 2 == 0 ? true : false,
                   salaryRange: nil)
            )
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            completion(.success((jobs, false)))
        }
    }
    
    func fetchJobDetails(jobId: String, completion: @escaping (Result<Job, NetworkError>) -> ()) {
        let intJobId = Int(jobId) ?? 0
        let job = Job(jobId: jobId,
                      jobTitle: "Job \(jobId)",
                      jobDescription: "Description for Job \(jobId)",
                      alreadyApplied: intJobId % 2 == 0 ? true : false,
                      salaryRange: nil)
        completion(.success(job))
    }
    
    func applyToJob(jobId: String, completion: @escaping (Result<Bool, NetworkError>) -> ()) {
        completion(.success(true))
    }
    
    func fetchMyApplications(page: Int, completion: @escaping (Result<([Job], Bool), NetworkError>) -> ()) {
        /// For now, lets return dummy jobs list
        
        var jobs: [Job] = []
        for i in 1...10 {
            jobs.append(
                Job(jobId: "\(i)",
                    jobTitle: "Job \(i)",
                    jobDescription: "Description for Job \(i)",
                    alreadyApplied: true,
                   salaryRange: nil)
            )
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            completion(.success((jobs, false)))
        }
    }
}
