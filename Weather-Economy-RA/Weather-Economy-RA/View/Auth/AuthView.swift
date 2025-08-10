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
                
                // Form
                VStack(spacing: 16) {
                    
                    // Email
                    ZStack(alignment: .leading) {
                        if vm.email.isEmpty {
                            Text("E-mail")
                                .foregroundColor(.gray)
                                .padding(.leading, 16)
                        }
                        TextField("", text: $vm.email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .foregroundColor(.black)
                            .padding(12)
                    }
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    // Password
                    ZStack(alignment: .leading) {
                        if vm.password.isEmpty {
                            Text("Password")
                                .foregroundColor(.gray)
                                .padding(.leading, 16)
                        }
                        SecureField("", text: $vm.password)
                            .foregroundColor(.black)
                            .padding(12)
                    }
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                        // Confirm password (register only)
                        if !vm.isLogin {
                            ZStack(alignment: .leading) {
                                if vm.confirmPassword.isEmpty {
                                    Text("Confirm password")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 16)
                                }
                                SecureField("", text: $vm.confirmPassword)
                                    .foregroundColor(.black)
                                    .padding(12)
                            }
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }
                    
                        // Error
                        if let msg = vm.errorMessage {
                            Text(msg)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }

                        // Submit
                        Button(action: vm.submit) {
                            Text(vm.isLogin ? "Log in" : "Maak account")
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                }
            }
        }
    }
}
