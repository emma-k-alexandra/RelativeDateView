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
            self.formattedDate = self.formatter.localizedString(for: self.date, relativeTo: Date())
            
        }
        
    }
    let formatter = RelativeDateTimeFormatter()
    
    init(date: Date) {
        self.date = date
        
        self.formatter.unitsStyle = .full
        
    }
    
    @Published var formattedDate: String = ""
}
