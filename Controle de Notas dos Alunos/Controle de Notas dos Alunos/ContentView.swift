import SwiftUI

struct ContentView: View {
    
    @State private var aluno = Aluno()
    @State private var mostrarResultado: Bool = false
    @State private var alunos: [Aluno] = []
    @State private var mensagemErro = ""
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 40) {
                VStack(spacing: 12) {
                    Image(systemName: "graduationcap.fill")
                        .foregroundStyle(.orange)
                        .font(.system(size: 50))
                    
                    Text("Minha Turma")
                        .font(.system(size: 28, weight: .bold))
                    
                    Text("Cadastre alunos e acompanhe os resultados.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 8) {
                        Image(systemName: "person.badge.plus")
                        Text("Cadastrar aluno")
                            .font(.title3)
                            .bold()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nome do aluno")
                            .fontWeight(.semibold)
                        
                        TextField("Digite o nome completo", text: $aluno.nome)
                            .padding()
                            .background(Color(.systemGray6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4))
                            )
                            .cornerRadius(8)
                    }
                    
                    HStack(spacing: 12) {
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("Nota 1")
                                .fontWeight(.semibold)
                            
                            TextField("0 a 10", text: $aluno.nota1)
                                .padding()
                                .background(Color(.systemGray6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4))
                                )
                                .cornerRadius(8)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Nota 2")
                                .fontWeight(.semibold)
                            
                            TextField("0 a 10", text: $aluno.nota2)
                                .padding()
                                .background(Color(.systemGray6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4))
                                )
                                .cornerRadius(8)
                        }
                    }
                    
                    Button {
                        
                        if aluno.nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                mensagemErro = "Informe o nome do aluno."
                                return
                            }
                        
                        guard let nota1 = Double(aluno.nota1),
                              let nota2 = Double(aluno.nota2) else {
                                mensagemErro = "Informe notas válidas."
                                return
                              }
                        
                        if nota1 < 0 || nota1 > 10 || nota2 < 0 || nota2 > 10 {
                            mensagemErro = "As notas devem estar entre 0 e 10."
                            return
                        }
                        
                        alunos.append(aluno)
                        
                        mensagemErro = ""
                        
                        aluno = Aluno()
                    } label: {
                        
                        HStack {
                            
                            Spacer()
                            
                            Image(systemName: "plus.circle.fill")
                            
                            Text("Cadastrar Aluno")
                                .bold()
                            
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(15)
                    }
                    
                    if !mensagemErro.isEmpty {
                        Text(mensagemErro)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 24){
                    
                    Text("Resumo da Turma")
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack(spacing: 12) {
                            Image(systemName: "person.3.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                            
                            Text("\(alunos.count)")
                                .font(.system(size: 32, weight: .bold))
                            
                            Text("Alunos")
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.green)
                            
                            Text("\(alunos.filter { $0.media >= 7 }.count)")
                                .font(.system(size: 32, weight: .bold))
                            
                            Text("Aprovados")
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 12) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                            
                            Text("\(alunos.filter { $0.media < 7 }.count)")
                                .font(.system(size: 32, weight: .bold))
                            
                            Text("Reprovados")
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading, spacing: 24){
                    
                    HStack {
                        Text("Alunos cadastrados")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Text("\(alunos.count) registros")
                            .foregroundStyle(.secondary)
                    }
                    
                    if alunos.isEmpty {
                        
                        VStack(spacing: 8) {
                            Image(systemName: "person.text.rectangle")
                                .font(.system(size: 40))
                                .foregroundStyle(.gray)
                            
                            Text("Nenhum aluno cadastrado")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                    } else {
                        ForEach(alunos) { aluno in
                            
                            VStack(alignment: .leading, spacing: 12) {
                                
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundStyle(.orange)
                                
                                    Text(aluno.nome)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                                
                                Button {
                                    
                                    alunos.removeAll { $0.id == aluno.id }
                                } label: {
                                    
                                    Image(systemName: "trash.fill")
                                        .foregroundStyle(.red)
                                }
                                
                                Text("Nota 1: \(aluno.nota1)")
                                Text("Nota 2: \(aluno.nota2)")
                                
                                Text("Média: \(String(format: "%.1f", aluno.media))")
                                    .fontWeight(.semibold)
                                
                                HStack {
                                    Image(systemName: aluno.media >= 7 ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    
                                    Text(aluno.situacao)
                                        .fontWeight(.semibold)
                                }
                                .foregroundStyle(aluno.cor)

                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ContentView()
}
