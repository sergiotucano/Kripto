
import SwiftUI
import UIKit

struct GenerateView: View {
    @EnvironmentObject var store: PasswordStore
    @EnvironmentObject var settings: AppSettings
    @State private var showSaveDialog = false
    @State private var descriptionText = ""
    @State private var copiedAlert = false
    @State private var showToast = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Kripto 🔐")
                .font(.largeTitle.bold())
                .padding(.top)

            if let password = store.lastGeneratedPassword {
                Text(password)
                    .font(.title2.monospaced())
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 6)
                    .padding(.horizontal)

                Button("Salvar Senha") {
                    showSaveDialog = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 4)
                .padding(.horizontal)
            }

            Button("Gerar Senha") {
                store.generatePassword(settings: settings)
                if let pwd = store.lastGeneratedPassword {
                    UIPasteboard.general.string = pwd
                    withAnimation { showToast = true } // toast disparado aqui
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 4)
            .padding(.horizontal)

            Spacer()
        }
        .toast(isShowing: $showToast, message: "Senha copiada!", duration: 1)
        .alert("Descrição da Senha", isPresented: $showSaveDialog) {
            TextField("Descrição", text: $descriptionText)
            Button("Salvar") {
                store.savePassword(description: descriptionText)
                descriptionText = ""
            }
            Button("Cancelar", role: .cancel) {}
        }
    }
    
}

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let duration: Double

    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    Text(message)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation { isShowing = false }
                            }
                        }
                }
                .animation(.easeInOut, value: isShowing)
            }
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: String, duration: Double = 2) -> some View {
        self.modifier(ToastModifier(isShowing: isShowing, message: message, duration: duration))
    }
}
