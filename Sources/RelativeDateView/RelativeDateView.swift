import SwiftUI
import DateHelper

public struct RelativeDateView: View {
    @State private var formattedDate: String = ""
    @ObservedObject var viewModel: RelativeDateViewModel
    
    public init(date: Date, format: [RelativeTimeStringType: String]? = nil) {
        self.viewModel = RelativeDateViewModel(date: date, format: format)
        
    }
    
    public var body: some View {
        Text(self.viewModel.formattedDate)
            .onReceive(Timer.publish(every: 1, on: .main, in: .default).autoconnect()) {
                self.formattedDate = String(describing: $0)
        }
        
    }
    
}

#if DEBUG
struct RelativeDateView_Previews: PreviewProvider {
    static var previews: some View {
        RelativeDateView(date: Date())
        
    }
    
}
#endif
