import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            LoginView()
        } else {
            ZStack {
                Color.red.ignoresSafeArea()
                VStack {
                    Image("pokemon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    Spacer() // Pushes the image to the top
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
