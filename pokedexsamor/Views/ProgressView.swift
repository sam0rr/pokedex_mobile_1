import SwiftUI

struct CustomProgressView: View {
    let message: String

    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
                .background(Color.white)
            Text(message)
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    CustomProgressView(message: "Chargement...")
}
