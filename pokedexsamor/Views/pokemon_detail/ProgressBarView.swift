import SwiftUI

struct ProgressBarView: View {
    var value: CGFloat
    var typeColor: Color
    var width: CGFloat

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: width, height: 6)
                .foregroundColor(Color.gray.opacity(0.2))

            RoundedRectangle(cornerRadius: 3)
                .frame(width: min(value, 1) * width, height: 6)
                .foregroundColor(typeColor)
        }
        .frame(height: 6)
    }
}
