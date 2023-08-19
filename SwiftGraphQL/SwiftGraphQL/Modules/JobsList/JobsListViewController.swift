//
//  JobsListViewController.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit

class JobsListViewController: BaseViewController {
    private var viewModel: JobsListViewControllerViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
        fetchJobs()
    }
    
    func setupViews() {
        self.title = "Active Jobs"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JobTableViewCell.nib, forCellReuseIdentifier: JobTableViewCell.identifier)
        /// Add pull to refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.viewModel?.reloadData()
        refreshControl.endRefreshing()
    }
    
    func bind() {
        guard let viewModel = viewModel else { return }
        
        /// Show/Hide loading indicator
        viewModel.$isLoading.sink {[weak self] isLoading in
            self?.loadingIndicator.isHidden =  !isLoading
            self?.tableView.isHidden = isLoading
        }.store(in: &cancellables)
        
        /// Reload tableview everytime jobs updates
        viewModel.$jobs.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    func fetchJobs() {
        viewModel?.fetchJobs()
    }
}

extension JobsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.jobs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.identifier, for: indexPath) as? JobTableViewCell else { fatalError("xib does not exists") }
        
        if let job = viewModel?.jobs[indexPath.row] {
            let jobCellViewModel = JobCellViewModel(job: job)
            cell.viewModel = jobCellViewModel
        }
        
        // Check if we reached last table view cell, then load more data
        if let isLoading = viewModel?.isLoading,
           !isLoading,
           let totalJobs = viewModel?.jobs.count,
           indexPath.row == totalJobs - 1 {
            self.fetchJobs()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        self.navigateToJobDetails(jobIndex: indexPath.row)
    }
    
    func navigateToJobDetails(jobIndex: Int) {
        if let vm = self.viewModel?.getJobDetailsVM(for: jobIndex) {
            let jobDetailsViewController = JobDetailsViewController.build(viewModel: vm)
            jobDetailsViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(jobDetailsViewController, animated: true)
        }
    }
}


// MARK: - Buildable
extension JobsListViewController {
    public class func build(viewModel: JobsListViewControllerViewModel) -> JobsListViewController {
        let controller = JobsListViewController(nibName: "JobsListViewController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
}
