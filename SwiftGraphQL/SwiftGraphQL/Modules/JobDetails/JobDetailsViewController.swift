//
//  JobDetailsViewController.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit

class JobDetailsViewController: BaseViewController {
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var jobSalaryLabel: UILabel!
    @IBOutlet weak var appliedView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    
    private var viewModel: JobDetailsViewControllerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    func setupViews() {
        self.title = "Details"
    }
    
    func bind() {
        guard let viewModel = viewModel else { return }
        
        viewModel.$jobTitle
            .receive(on: DispatchQueue.main)
            .assign(to: \.text!, on: self.jobTitleLabel)
            .store(in: &cancellables)
        
        viewModel.$jobDescription
            .receive(on: DispatchQueue.main)
            .assign(to: \.text!, on: self.jobDescriptionLabel)
            .store(in: &cancellables)
        
        viewModel.$alreadyApplied.sink { [weak self] alreadyApplied in
            self?.appliedView.isHidden = !alreadyApplied
            self?.applyButton.isHidden = alreadyApplied
        }.store(in: &cancellables)
        
        viewModel.$jobSalary
            .receive(on: DispatchQueue.main)
            .assign(to: \.text!, on: self.jobSalaryLabel)
            .store(in: &cancellables)
    }
    
    @IBAction func applyButtonTapped() {
        viewModel?.apply()
    }
}

// MARK: - Buildable
extension JobDetailsViewController {
    public class func build(viewModel: JobDetailsViewControllerViewModel) -> JobDetailsViewController {
        let controller = JobDetailsViewController(nibName: "JobDetailsViewController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
}
