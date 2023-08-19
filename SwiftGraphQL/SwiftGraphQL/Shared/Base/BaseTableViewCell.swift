//
//  File.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
}
