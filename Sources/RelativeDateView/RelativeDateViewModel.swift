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
    var timer = Timer()
    
    init(date: Date) {
        self.date = date
        
        self.timer = Timer(timeInterval: 1, repeats: true) { (timer) in
            self.formattedDate = self.format(self.date)
            print("tick")
        }
        
    }
    
    func format(_ date: Date) -> String {
        self.formatter.localizedString(for: date, relativeTo: Date())
        
    }
    
    @Published var formattedDate: String = ""
}
