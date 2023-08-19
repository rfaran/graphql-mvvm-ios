//
//  SalaryRange.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation
import SwiftGraphQLAPI

struct SalaryRange {
    let min: Int
    let max: Int
    
    init?(salaryRange: JobDetailsQuery.Data.Job.SalaryRange?) {
        guard let salaryRange = salaryRange,
              let min = salaryRange.min,
              let max = salaryRange.max else { return nil }
        self.min = min
        self.max = max
    }
}
