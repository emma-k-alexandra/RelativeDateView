import SwiftUI
import DateHelper

public struct RelativeDateView: View {
    @State private var formattedDate: String = ""
    @ObservedObject var viewModel: RelativeDateViewModel
    
    @Binding var isFuture: Bool
    @Binding var isNow: Bool
    @Binding var isPast: Bool
    
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
                print(self.isFuture, self.isNow, self.isPast)

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
