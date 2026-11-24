import Foundation
import SwiftData

@Model
class Evento {
    
    var titulo: String
    var descricao: String
    var data: Date
    var local: String
    
    init(titulo: String, descricao: String, data: Date, local: String) {
        self.titulo = titulo
        self.descricao = descricao
        self.data = data
        self.local = local
    }
}
