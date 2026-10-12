import Foundation

protocol Cadastravel {
    func exibirDados(index: Int) -> String
}

class Livro: Cadastravel {
    var nome: String = ""
    
    init(nome: String) {
        self.nome = nome
    }
    
    func exibirDados(index: Int) -> String {
        return "📙 Identificador: \(index) | Nome: \(nome)"
    }
}

class GerenciarLivros {
    
    private var vetor: [Livro] = []
    
    func cadastrar(){
        print("Informe o nome do livro:")
        if let nomeLivro = readLine(),
           !nomeLivro.isEmpty {

                let livro = Livro(nome: nomeLivro)
            
                vetor.append(livro)
                print("___________________________")
                print("Livro adcionado com sucesso!")

        } else {
            print("________________")
            print("Nome inválido!")

        }
        print("________________________")
    }
    
    func listar(){
        if vetor.isEmpty {
            print("Lista vazia!")
            print("___________________________________")
            return
        }

        for (index, item) in vetor.enumerated() {
            print(item.exibirDados(index: index + 1))
        }

        print("________________________________________")
    }
    
    func listarPorId() {
        print("Informe o id:")
        if let indexString = readLine(),
        let indexNumero = Int(indexString) {
            if indexNumero >= 1 && indexNumero <= vetor.count {
                print("_________________________")
                let item = vetor[indexNumero - 1]
                print(item.exibirDados(index: indexNumero))

            } else {
                print("_________________________")
                print("Livro não encontrado!")

            }
        }

        print("_______________________________")
    }
    
    func editar(){
        print("Informe o id do Livro:")
        if let indexString = readLine(),
        let indexNumero = Int(indexString) {
            if indexNumero >= 1 && indexNumero <= vetor.count {
                print("_________________________")
                let item = vetor[indexNumero - 1]

                print("Livro atual:")
                print(item.exibirDados(index: indexNumero))
                print("_________________________")
                print("Informe o novo nome:")

                if let novoNome = readLine(),
                !novoNome.isEmpty {

                    item.nome = novoNome
                    print("_________________________")
                    print("Livro atualizado com sucesso!")

                } else {
                    print("_________________________")
                    print("Nome inválido!")

                }

            } else {
                print("_________________________")
                print("Livro não encontrado!")

            }
        }

        print("______________________________________")
    }

    func remover() {
        print("Informe o id do Livro:")
        if let indexString = readLine(),
        let indexNumero = Int(indexString) {
            if indexNumero >= 1 && indexNumero <= vetor.count {
                vetor.remove(at: indexNumero - 1)
                print("____________________________________")
                print("Livro removido com sucesso!")
                print("_____________________________________")

            } else {
                print("______________________________________")
                print("Livro não encontrado!")

            }
        }
        
        print("__________________________________")
    }
}

let vetorLivros = GerenciarLivros()

var indice = 0

while indice != 6 {
    
    print("GERENCIADOR DE BIBLIOTECA")
    print("_________________________")
    print("Informe o número do que voce deseja fazer!")
    print("1- Cadastrar Livro")
    print("2- Listar Livro")
    print("3- Listar Livro por Id")
    print("4- Editar Livro")
    print("5- Remover Livro")
    print("6- Sair")
    print("_________________________")
    
    if let entrada = readLine(),
    let opcao = Int(entrada) {
        indice = opcao
        print("_________________________")
        switch indice {
            case 1:
            vetorLivros.cadastrar()
            
            case 2:
            vetorLivros.listar()
            
            case 3:
            vetorLivros.listarPorId()
            
            case 4:
            vetorLivros.editar()
            
            case 5:
            vetorLivros.remover()
            
            case 6:
            print("Encerrando sistema...")
            
            default:
            print("Este número não é aceito, escolha um disponivel!")
            print("_________________________________________________")
        }
    } else {
        print("Digite um número válido!")
    }
    
}
