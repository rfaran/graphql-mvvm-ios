//
//  BaseViewController.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var cancellables: [AnyCancellable] = []
    
    deinit {
        cancellables.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColors.backgroundSecondary
    }
}
