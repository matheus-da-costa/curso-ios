import SwiftUI
import SwiftData

struct ListaEventosView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var mostrarCadastro = false
    @State private var viewModel: EventoViewModel?
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Meus Eventos")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    mostrarCadastro = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(Circle())
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            List {
                ForEach(viewModel?.eventos ?? []) { evento in
                    VStack(alignment: .leading){
                        Text(evento.titulo)
                            .font(.headline)
                        
                        Text(evento.descricao)
                        
                        Text(evento.local)
                            .foregroundStyle(.secondary)
                        
                        Text(evento.data, style: .date)
                            .font(.caption)
                    }
                }
                .onDelete{ indexSet in
                    for index in indexSet {
                        if let evento = viewModel?.eventos[index] {
                            viewModel?.excluirEvento(evento: evento)
                        }
                    }
                }
            }
        }
        .task {
            viewModel = EventoViewModel(modelContext: modelContext)
            viewModel?.buscarEventos()
        }
        .sheet(isPresented: $mostrarCadastro, onDismiss: {
            viewModel?.buscarEventos()
        }){
            CadastroEventoView()
        }
        
    }
}
