//
//  String+EXT.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Foundation

extension String {
    func ToDate(withFormat format: String = "yyyy-MM-dd HH:mm a")-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date ?? Date())
    }
}
