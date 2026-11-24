import SwiftUI
import SwiftData

struct CadastroEventoView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: EventoViewModel?
    @State private var titulo = ""
    @State private var descricao = ""
    @State private var data = Date()
    @State private var local = ""
    @State private var mostrarAlerta = false
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Título do evento", text: $titulo)
                .textFieldStyle(.roundedBorder)
            
            TextField("Descrição do evento", text: $descricao)
                .textFieldStyle(.roundedBorder)
            
            DatePicker("Data e horário", selection: $data)
            
            TextField("Local do evento", text: $local)
                .textFieldStyle(.roundedBorder)
            
            Button {
                if let viewModel = viewModel {
                    let cadastrado = viewModel.validarCadastrar(
                        titulo: titulo,
                        descricao: descricao,
                        data: data,
                        local: local
                    )
                    
                    if cadastrado {
                        dismiss()
                    } else {
                        mostrarAlerta = true
                    }
                }
            
            } label: {
                Text("Cadastrar")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .task {
            viewModel = EventoViewModel(modelContext: modelContext)
        }
        .alert("Campos obrigatórios", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Preencha o título e o local do evento.")
        }
    }
}
