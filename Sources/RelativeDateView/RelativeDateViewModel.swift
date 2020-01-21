//
//  RelativeDateViewModel.swift
//  
//
//  Created by Emma K Alexandra on 1/12/20.
//

import SwiftUI
import Combine
import DateHelper

class RelativeDateViewModel: ObservableObject {
    /// Cancellable for timer publisher
    private var assignCancellable: AnyCancellable? = nil
    
    /// Date to display relative time to
    var date: Date {
        didSet {
            self.isFutureNowOrPast()
            
            self.formattedDate = self.formatDate(self.date)
            
        }
        
    }
    
    /// What Strings to display for certain RelativeTimeStringTypes
    var format: [RelativeTimeStringType: String]?
    
    /// Creates RelativeDateViewModel.
    ///
    /// - parameter date: Date to display relative time to
    /// - parameter format: Date formats to display
    init(date: Date, format: [RelativeTimeStringType: String]?) {
        self.date = date
        self.format = format
        
        // Start timer
        self.assignCancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { _ in
                self.isFutureNowOrPast()
                
                return self.formatDate(self.date)
            
            }
            .assign(to: \RelativeDateViewModel.formattedDate, on: self)
        
        self.isFutureNowOrPast()
        
    }
    
    /// Format given date to a relative time string
    /// - parameter date: Date to convert to a relative time string
    /// - returns: Relative time stirng
    func formatDate(_ date: Date) -> String {
        return self.date.toStringWithRelativeTime(strings: self.format)
        
    }
    
    /// Sets isFuture/isNow/isPast based on the date's RelativeTimeStringType
    func isFutureNowOrPast() {
        switch self.date.toRelativeTime() {
        case .nowPast:
            self.isFuture = false
            self.isNow = true
            self.isPast = true
        case .nowFuture:
            self.isFuture = true
            self.isNow = true
            self.isPast = false
        case .secondsPast, .oneMinutePast, .minutesPast, .oneHourPast, .hoursPast, .oneDayPast, .daysPast, .oneWeekPast, .weeksPast, .oneMonthPast, .monthsPast, .oneYearPast, .yearsPast:
            self.isPast = true
            self.isNow = false
            self.isFuture = false
        case .secondsFuture, .oneMinuteFuture, .minutesFuture, .oneHourFuture, .hoursFuture, .oneDayFuture, .daysFuture, .oneWeekFuture, .weeksFuture, .oneMonthFuture, .monthsFuture, .oneYearFuture, .yearsFuture:
            self.isPast = false
            self.isNow = false
            self.isFuture = true
        }
        
    }
    
    /// The date formatted in relative time
    @Published var formattedDate: String = ""
    
    /// If the current date is in the future
    @Published var isFuture: Bool = false
    
    /// If the current date is now, plus or minus 10 seconds or so
    @Published var isNow: Bool = false
    
    /// If the current date is in the past
    @Published var isPast: Bool = false
    
}
