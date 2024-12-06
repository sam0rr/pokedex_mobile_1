import SwiftUI

struct ProgressBarView: View {
    var value: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 10)
                    .foregroundColor(Color.gray.opacity(0.2))


                RoundedRectangle(cornerRadius: 5)
                    .frame(width: value * geometry.size.width, height: 10)
                    .foregroundColor(.blue)
            }
        }
        .frame(height: 10)
    }
}
