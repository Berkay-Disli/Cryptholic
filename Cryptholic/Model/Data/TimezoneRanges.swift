//
//  TimezoneRanges.swift
//  Cryptholic
//
//  Created by Berkay Disli on 4.08.2022.
//

import Foundation

enum TimezoneRanges: String, CaseIterable {
    case day, week, month, threeMonts, sixMonths, year
    
    var urlValue: String {
        switch self {
            // 24h | 1w | 1m | 3m | 6m | 1y |all
        case .day:
            return "24h"
        case .week:
            return "1w"
        case .month:
            return "1m"
        case .threeMonts:
            return "3m"
        case .sixMonths:
            return "6m"
        case .year:
            return "1y"
        }
    }
}
