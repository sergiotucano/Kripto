import SwiftUI
import UIKit // necessário para clipboard

struct SavedListView: View {
    @EnvironmentObject var store: PasswordStore
    @State private var unlocked = false
    @State private var showToast = false // usa o toast existente

    var body: some View {
        VStack {
            if unlocked {
                List {
                    ForEach(store.passwords) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.description)
                                    .font(.headline)
                                Text(item.value)
                                    .font(.body.monospaced())
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            // Botão copiar
                            Button(action: {
                                UIPasteboard.general.string = item.value
                                withAnimation { showToast = true }
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 3)
                    }
                    .onDelete { indexSet in
                        if let idx = indexSet.first {
                            let item = store.passwords[idx]
                            store.authenticate { success in
                                if success { store.deletePassword(item) }
                            }
                        }
                    }
                }
                .toast(isShowing: $showToast, message: "Senha copiada!", duration: 2) // usa toast existente
            } else {
                Button("Desbloquear") {
                    store.authenticate { success in
                        unlocked = success
                    }
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 4)
            }
        }
    }
}
