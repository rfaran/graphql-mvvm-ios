//
//  ApolloClientNetworkService.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation
import Apollo
import SwiftGraphQLAPI

class ApolloClientNetworkService: NetworkService {
    static let shared = ApolloClientNetworkService()
    private init() {}
    
    /// Server URL
    /// TODO: Change this to production URL
    /// TODO: Move this to a config file
    private let serverUrl = URL(string: "http://localhost:3002/")!
    
    /// InMemoryNormalizedCache is used to cache the data in memory
    /// We can avoid it to reflect instant changes
    private let store = ApolloStore(cache: InMemoryNormalizedCache())
    private let client = URLSessionClient()
    
    /// ApolloClient instance for unauthenticated requests
    private lazy var apolloClient: ApolloClient = {
        let provider = DefaultInterceptorProvider(client: client, store: store)
        let requestChainTransport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: serverUrl
        )
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }()
    
    /// ApolloClient instance for authenticated requests
    private lazy var apolloAuthClient = {
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let requestChainTransport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: serverUrl
        )
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }()}

extension ApolloClientNetworkService {
    func login(username: String, password: String, completion: @escaping (Result<String, NetworkError>) -> ()) {
        let mutationQuery = AuthenticateUserMutation(username: username, password: password)
        apolloClient.perform(mutation: mutationQuery) { result in
            switch result {
            case .success(let value):
                if let authToken = value.data?.auth {
                    completion(.success(authToken))
                } else {
                    completion(.failure(.customError("Incorrect Username/Password")))
                }
                
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func fetchJobs(page: Int, completion: @escaping (Result<([Job], Bool), NetworkError>) -> ()) {
        let query = ActiveJobsQuery(page: GraphQLNullable<Int>(integerLiteral: page))
        apolloAuthClient.fetch(query: query) { result in
            switch result {
            case .success(let value):
                if let jobs = value.data?.active?.jobs?.compactMap(Job.init) {
                    let hasNextPage = value.data?.active?.hasNext ?? false
                    completion(.success((jobs, hasNextPage)))
                } else {
                    completion(.failure(.serverError))
                }
                
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func fetchJobDetails(jobId: String, completion: @escaping (Result<Job, NetworkError>) -> ()) {
        let query = JobDetailsQuery(jobId: jobId)
        apolloAuthClient.fetch(query: query) { result in
            switch result {
            case .success(let value):
                if let job = Job.init(job: value.data?.job) {
                    completion(.success(job))
                } else {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func applyToJob(jobId: String, completion: @escaping (Result<Bool, NetworkError>) -> ()) {
        let mutationQuery = ApplyJobMutation(jobId: jobId)
        apolloAuthClient.perform(mutation: mutationQuery)  { result in
            switch result {
            case .success(let value):
                if let apply = value.data?.apply {
                    completion(.success(apply))
                } else {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func fetchMyApplications(page: Int, completion: @escaping (Result<([Job], Bool), NetworkError>) -> ()) {
        /// TODO: Integrate once query is ready
        completion(.failure(.serverError))
    }
}
