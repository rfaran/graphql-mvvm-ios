//
//  NetworkService.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation

/// NetwokService, that defines the contract for network calls, e.g. login, fetchingJobs, applyingJobs etc.
/// This protocol can be implemented by different classes, e.g. NetworkServiceDefault, MockNetworkService etc.
/// This protocol can be used for dependency injection, e.g. in unit tests, we can inject MockNetworkService instead of NetworkServiceDefault

protocol NetworkService {
    /// Login user with username and password
    func login(username: String, password: String, completion: @escaping (Result<String, NetworkError>) -> ())
    
    /// Fetch active jobs from server
    func fetchJobs(page: Int, completion: @escaping (Result<([Job], Bool), NetworkError>) -> ())
    
    /// Fetch job details from server
    func fetchJobDetails(jobId: String, completion: @escaping (Result<Job, NetworkError>) -> ())
    
    /// Apply to a job
    func applyToJob(jobId: String, completion: @escaping (Result<Bool, NetworkError>) -> ())
    
    /// Fetch my applications
    func fetchMyApplications(page: Int, completion: @escaping (Result<([Job], Bool), NetworkError>) -> ())
}
