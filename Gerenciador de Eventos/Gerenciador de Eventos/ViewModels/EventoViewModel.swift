import Foundation
import SwiftData
import Observation

@Observable
class EventoViewModel {
    
    var modelContext: ModelContext
    var eventos: [Evento] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func cadastrarEvento(evento: Evento) {
        modelContext.insert(evento)
    }
    
    func validarCadastrar(titulo: String, descricao: String, data: Date, local: String) -> Bool {
        let tituloValidado = titulo.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let localValidado = local.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !tituloValidado.isEmpty,
              !localValidado.isEmpty else {
            return false
        }
        
        let evento = Evento(
            titulo: tituloValidado,
            descricao: descricao,
            data: data,
            local: localValidado
        )
        
        cadastrarEvento(evento: evento)
        
        return true
    }
    
    func buscarEventos() {
        let descriptor = FetchDescriptor<Evento>()
        
        let resultado = try? modelContext.fetch(descriptor)
        
        eventos = resultado ?? []
    }
    
    func excluirEvento(evento: Evento) {
        modelContext.delete(evento)
    }
    
}
