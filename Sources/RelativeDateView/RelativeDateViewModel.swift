//
//  File.swift
//  
//
//  Created by Emma K Alexandra on 1/12/20.
//

import SwiftUI
import Combine

class RelativeDateViewModel: ObservableObject {
    var date: Date {
        didSet {
            self.formattedDate = self.format(self.date)
            
        }
        
    }
    let formatter = RelativeDateTimeFormatter()
    
    init(date: Date) {
        self.formatter.unitsStyle = .full
        self.date = date
        
        self.formattedDate = self.format(date)
        
    }
    
    func format(_ date: Date) -> String {
        self.formatter.localizedString(for: date, relativeTo: Date())
        
    }
    
    @Published var formattedDate: String = ""
}
