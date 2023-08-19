//
//  SearchViewController.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit

class SearchViewController: BaseViewController {
    private var viewModel: SearchViewControllerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    func setupViews() {
        self.title = "Search"
    }
    
    func bind() {
    }
}

// MARK: - Buildable
extension SearchViewController {
    public class func build(viewModel: SearchViewControllerViewModel) -> SearchViewController {
        let controller = SearchViewController(nibName: "SearchViewController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
}
