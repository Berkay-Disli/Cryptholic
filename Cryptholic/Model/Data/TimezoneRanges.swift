//
//  TimezoneRanges.swift
//  Cryptholic
//
//  Created by Berkay Disli on 4.08.2022.
//

import Foundation

enum TimezoneRanges: String, CaseIterable {
    case hour, day, week
    
    var shortTitle: String {
        switch self {
        case .hour:
            return "1H"
        case .day:
            return "1D"
        case .week:
            return "1W"
        }
    }
}
