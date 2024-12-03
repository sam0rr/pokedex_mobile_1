import SwiftUI

struct ProgressBarView: View {
    var value: CGFloat // A value between 0.0 and 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background Bar
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 10)
                    .foregroundColor(Color.gray.opacity(0.2))

                // Filled Bar
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: value * geometry.size.width, height: 10)
                    .foregroundColor(.blue)
            }
        }
        .frame(height: 10) // Set the height explicitly
    }
}
