//
//  File.swift
//  
//
//  Created by Emma K Alexandra on 1/12/20.
//

import SwiftUI
import Combine

class RelativeDateViewModel: ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    var date: Date {
        didSet {
            self.formattedDate = self.formatter.localizedString(for: self.date, relativeTo: Date())
            
        }
        
    }
    let formatter = RelativeDateTimeFormatter()
    
    init(date: Date) {
        self.formatter.unitsStyle = .full
        self.date = date
        
        
        
    }
    
    @Published var formattedDate: String = ""
}
