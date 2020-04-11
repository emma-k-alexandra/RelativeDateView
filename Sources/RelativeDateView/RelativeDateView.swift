//
//  RelativeDateViewModel.swift
//
//
//  Created by Emma K Alexandra on 1/12/20.
//

import SwiftUI
import DateHelper

public struct RelativeDateView<DateView>: View where DateView: View {
    @State private var formattedDate: String
    @ObservedObject var viewModel: RelativeDateViewModel
    
    /// If the current date is in the future
    @Binding var isFuture: Bool
    
    /// If the current date is right now, plus or minus 10 seconds or so
    @Binding var isNow: Bool
    
    /// If the current date is in the past
    @Binding var isPast: Bool
    
    let content: (Text) -> DateView
    
    /// Creates a RelativeDateView
    ///
    /// - parameter date: Date to display a relative time to
    /// - parameter format: Optional. Strings to display when a date is certain amounts of time away
    /// - parameter placeholder: Optional. String to display before the actual value is computed
    /// - parameter isFuture: Optional. If the current date is in the future
    /// - parameter isNow: Optional. If the current date is right now, plus or minus 10 seconds or so
    /// - parameter isPast: Optional. If the current date is in the past
    public init(
        date: Date,
        format: [RelativeTimeStringType: String]? = nil,
        placeholder: String = "",
        isFuture: Binding<Bool>? = nil,
        isNow: Binding<Bool>? = nil,
        isPast: Binding<Bool>? = nil,
        @ViewBuilder content: @escaping (Text) -> DateView
    ) {
        
        self.viewModel = RelativeDateViewModel(date: date, format: format)
        self.content = content
        self._formattedDate = State(wrappedValue: placeholder)
        
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
        self.content(Text(self.viewModel.formattedDate))
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
        RelativeDateView(date: Date()) { text in
            text
            .bold()
        }
        
    }
    
}
#endif
