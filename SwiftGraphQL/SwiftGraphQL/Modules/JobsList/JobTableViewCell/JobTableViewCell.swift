//
//  JobTableViewCell.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit

class JobTableViewCell: BaseTableViewCell {
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var appliedView: UIView!
    
    var viewModel: JobCellViewModel? {
        didSet {
            jobTitleLabel.text = viewModel?.jobTitle
            jobDescriptionLabel.text = viewModel?.jobDescription
            
            if let isApplied = viewModel?.alreadyApplied, isApplied {
                self.appliedView.isHidden = false
            } else {
                self.appliedView.isHidden = true
            }
        }
    }
}

