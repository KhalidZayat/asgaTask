//
//  Date+EXT.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Foundation

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    func toUrlDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
