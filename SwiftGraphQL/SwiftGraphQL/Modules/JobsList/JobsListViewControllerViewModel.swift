//
//  JobsListViewControllerViewModel.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation

class JobsListViewControllerViewModel: BaseViewModel {
    
    /// Jobs array to be displayed in the list
    @Published var jobs: [Job] = []
    
    /// Page number to load from NetworkService
    private var page: Int = 1
    
    /// Boolean to check if we can load more data *to support pagination *
    private var canFetchMoreJobs = true

    private let apiService: NetworkService
    
    init(apiService: NetworkService) {
        self.apiService = apiService
    }
    
    /// Method to fetch jobs from NetworkService
    func fetchJobs() {
        guard canFetchMoreJobs else { return }
        
        /// Show loading indicator if page is 1
        if page == 1 {
            isLoading.toggle()
        }
        
        self.apiService.fetchJobs(page: page) {[weak self] (result) in
            if self?.page == 1 {
                self?.isLoading.toggle()
            }

            switch result {
            case .success((let jobs, let hasNext)):
                self?.page += 1
                self?.canFetchMoreJobs = hasNext
                self?.jobs.append(contentsOf: jobs)
                
            case .failure(_):
                self?.jobs = []
            }
        }
    }
    
    func getJobDetailsVM(for index: Int) -> JobDetailsViewControllerViewModel {
        JobDetailsViewControllerViewModel(apiService: self.apiService, jobId: jobs[index].jobId)
    }
    
    /// Method to full refresh the data
    func reloadData() {
        self.page = 1
        self.canFetchMoreJobs = true
        self.jobs = []
        self.fetchJobs()
    }
}
