//
//  Date+ext.swift
//  Faces
//
//  Created by Brandon Rodriguez on 4/20/22.
//

import Foundation

extension Date {
    
    func isSameDayAndMonth(as date: Date) -> Bool {
        
        let cal = Calendar.current
        let compare = cal.dateComponents([.year, .month, .day], from: self, to: date)

        return compare.month == 0 && compare.day == 0
        
    }
    
}
