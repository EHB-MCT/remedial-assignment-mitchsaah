import SwiftUI

struct AuthView: View {
    @StateObject private var vm = AuthViewModel()

    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()

            VStack(spacing: 24) {
                // Logo
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 140, height: 140)
                        .shadow(color: .black.opacity(0.08), radius: 12, y: 6)
                    
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                }
                .padding(.top, 40)
                
                // Title
                Text(vm.isLogin ? "Login" : "Register")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
        }
    }
}
