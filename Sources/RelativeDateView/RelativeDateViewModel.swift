//
//  File.swift
//  
//
//  Created by Emma K Alexandra on 1/12/20.
//

import SwiftUI
import Combine
import DateHelper

class RelativeDateViewModel: ObservableObject {
    private var assignCancellable: AnyCancellable? = nil
    
    var date: Date {
        didSet {
            self.formattedDate = self.format(self.date)
            
        }
        
    }
    var format: [RelativeTimeStringType: String]?
    
    init(date: Date, format: [RelativeTimeStringType: String]?) {
        self.date = date
        self.format = format
        
        self.assignCancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { _ in self.format(self.date) }
            .assign(to: \RelativeDateViewModel.formattedDate, on: self)
        
    }
    
    func format(_ date: Date) -> String {
        self.date.toStringWithRelativeTime(strings: self.format)
        
    }
    
    func updateFrequency() -> TimeInterval {
        switch self.date.toRelativeTime() {
        case .nowPast, .nowFuture, .secondsPast, .secondsFuture:
            return 1
        case .oneMinutePast, .oneMinuteFuture, .minutesPast, .minutesFuture:
            return 60
        case .oneHourPast, .oneHourFuture, .hoursPast, .hoursFuture:
            return 60 * 60
        case .oneDayPast, .oneDayFuture, .daysPast, .daysFuture:
            return 60 * 60 * 24
        case .oneWeekPast, .oneWeekFuture, .weeksPast, .weeksFuture:
            return 60 * 60 * 24 * 7
        case .oneMonthPast, .oneMonthFuture, .monthsPast, .monthsFuture:
            return 60 * 60 * 24 * 30
        case .oneYearPast, .oneYearFuture, .yearsPast, .yearsFuture:
            return 60 * 60 * 24 * 365
        }
        
    }
    
    @Published var formattedDate: String = ""
    
}
