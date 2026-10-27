import SwiftUI

struct Aluno: Identifiable {
    
    let id = UUID()
    
    var nome: String  = ""
    var nota1: String = ""
    var nota2: String = ""
    
    var media: Double {
        let n1 = Double(nota1) ?? 0
        let n2 = Double(nota2) ?? 0
        return (n1 + n2) / 2
    }
    
    var situacao: String {
        if media >= 7.0 {
            return "Aprovado(a)"
        } else {
            return "Reprovado(a)"
        }
    }
    
    var cor: Color {
        if media >= 7.0 {
            return .green
        } else {
            return .red
        }
    }
}
