//
//  File.swift
//  
//
//  Created by Emma K Alexandra on 1/12/20.
//

import SwiftUI
import Combine

class RelativeDateViewModel: ObservableObject {
    private var assignCancellable: AnyCancellable? = nil
    
    var date: Date {
        didSet {
            self.formattedDate = self.format(self.date)
            
        }
        
    }
    let formatter = RelativeDateTimeFormatter()
    var timer = Timer()
    
    init(date: Date) {
        self.date = date
        
        self.assignCancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { _ in self.format(self.date) }
            .assign(to: \RelativeDateViewModel.formattedDate, on: self)
        
    }
    
    func format(_ date: Date) -> String {
        self.formatter.localizedString(for: date, relativeTo: Date())
        
    }
    
    @Published var formattedDate: String = ""
}
