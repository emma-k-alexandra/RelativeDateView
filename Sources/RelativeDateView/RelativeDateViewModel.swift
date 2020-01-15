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
            self.isFutureNowOrPast()
            
            self.formattedDate = self.formatDate(self.date)
            
        }
        
    }
    var format: [RelativeTimeStringType: String]?
    
    init(date: Date, format: [RelativeTimeStringType: String]?) {
        self.date = date
        self.format = format
        
        self.assignCancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { _ in
                self.isFutureNowOrPast()
                
                return self.formatDate(self.date)
            
            }
            .assign(to: \RelativeDateViewModel.formattedDate, on: self)
        
        self.isFutureNowOrPast()
        
    }
    
    func formatDate(_ date: Date) -> String {
        return self.date.toStringWithRelativeTime(strings: self.format)
        
    }
    
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
    
    @Published var formattedDate: String = ""
    @Published var isFuture: Bool = false
    @Published var isNow: Bool = false
    @Published var isPast: Bool = false
    
}
