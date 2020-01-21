//
//  RelativeDateViewModel.swift
//
//
//  Created by Emma K Alexandra on 1/12/20.
//

import SwiftUI
import DateHelper

public struct RelativeDateView: View {
    @State private var formattedDate: String = ""
    @ObservedObject var viewModel: RelativeDateViewModel
    
    /// If the current date is in the future
    @Binding var isFuture: Bool
    
    /// If the current date is right now, plus or minus 10 seconds or so
    @Binding var isNow: Bool
    
    /// If the current date is in the past
    @Binding var isPast: Bool
    
    /// Creates a RelativeDateView
    ///
    /// - parameter date: Date to display a relative time to
    /// - parameter format: Optional. Strings to display when a date is certain amounts of time away.
    /// - parameter isFuture: If the current date is in the future
    /// - parameter isNow: If the current date is right now, plus or minus 10 seconds or so
    /// - parameter isPast: If the current date is in the past
    public init(date: Binding<Date>, format: [RelativeTimeStringType: String]? = nil, isFuture: Binding<Bool>? = nil, isNow: Binding<Bool>? = nil, isPast: Binding<Bool>? = nil) {
        self.viewModel = RelativeDateViewModel(date: date.wrappedValue, format: format)
        
        if let isFuture = isFuture {
            self._isFuture = isFuture
            
        } else {
            self._isFuture = Binding(get: {
                false
            }, set: { _ in })
            
        }
        
        if let isNow = isNow {
            self._isNow = isNow
            
        } else {
            self._isNow = Binding(get: {
                false
            }, set: { _ in })
            
        }
        
        if let isPast = isPast {
            self._isPast = isPast
            
        } else {
            self._isPast = Binding(get: {
                false
            }, set: { _ in })
            
        }
        
    }
    
    public var body: some View {
        Text(self.viewModel.formattedDate)
            .onReceive(Timer.publish(every: 1, on: .main, in: .default).autoconnect()) {
                self.formattedDate = String(describing: $0)
                self.isFuture = self.viewModel.isFuture
                self.isNow = self.viewModel.isNow
                self.isPast = self.viewModel.isPast

        }
        
    }
    
}

#if DEBUG
struct RelativeDateView_Previews: PreviewProvider {
    static var previews: some View {
        RelativeDateView(date: .constant(Date()))
        
    }
    
}
#endif
