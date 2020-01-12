import SwiftUI

public struct RelativeDateView: View {
    @ObservedObject var viewModel: RelativeDateViewModel
    
    public init(date: Date) {
        self.viewModel = RelativeDateViewModel(date: date)
        
    }
    
    public var body: some View {
        print("-- \(self.viewModel.formattedDate)")
        return Text(self.viewModel.formattedDate)
        
    }
    
}

#if DEBUG
struct RelativeDateView_Previews: PreviewProvider {
    static var previews: some View {
        RelativeDateView(date: Date())
        
    }
    
}
#endif
