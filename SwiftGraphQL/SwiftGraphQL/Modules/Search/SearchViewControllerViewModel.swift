//
//  SearchViewControllerViewModel.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation

class SearchViewControllerViewModel: BaseViewModel {
    
    private let apiService: NetworkService
    
    init(apiService: NetworkService) {
        self.apiService = apiService
    }
}
