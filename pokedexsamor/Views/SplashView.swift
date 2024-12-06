import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            PokemonListView()
        } else if isActive {
            LoginView(isLoggedIn: $isLoggedIn)
        } else {
            ZStack {
                Color.red.ignoresSafeArea()
                VStack {
                    Image("pokemon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 300)
                    Spacer()
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
