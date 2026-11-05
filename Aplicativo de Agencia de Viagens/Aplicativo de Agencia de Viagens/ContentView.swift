import SwiftUI
import Foundation

struct Viagem: Identifiable {
    let id = UUID()
    let nome: String
    let local: String
    let diarias: Int
    let preco: Double
    let imagem: String
    
    let partida: String
    let retorno: String
    let hospedagem: String
    
    var favorita: Bool = false
}


struct ViagemRow: View {
    
    @Binding var viagem: Viagem
    
    var body: some View {
        
        HStack(spacing: 16){
            
            Image(viagem.imagem)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipped()
                .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 8){
                
                Text(viagem.nome)
                    .font(.title3)
                
                Text(viagem.local)
                    .foregroundColor(.gray)
                
                Text("\(viagem.diarias) diárias • R$ \(viagem.preco, specifier: "%.2f")")
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            VStack(spacing: 20) {
                Button {
                    viagem.favorita.toggle()
                } label: {
                    Image(systemName: viagem.favorita ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(
                            viagem.favorita ? .red : .gray
                        )
                }
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
        }
        .padding(.vertical)
    }
}

struct HomeView: View {
    
    @State private var viagens: [Viagem] = [
        Viagem(
            nome: "Magia em Paris",
            local: "Paris, França",
            diarias: 7,
            preco: 5499.00,
            imagem: "paris",
            partida: "10/05/2027",
            retorno: "17/05/2027",
            hospedagem: "Hotel Louvre Elegance - 4 estrelas com café da manhã incluso."
        ),
        
        Viagem(
            nome: "Verão em Londres",
            local: "Londres, Inglaterra",
            diarias: 10,
            preco: 7800.00,
            imagem: "londres",
            partida: "05/06/2027",
            retorno: "15/06/2027",
            hospedagem: "Royal Thames Hotel - 5 estrelas, próximo ao Big Ben e com café da manhã incluso."
        ),
        
        Viagem(
            nome: "Aventura em Kyoto",
            local: "Kyoto, Japão",
            diarias: 8,
            preco: 6200.00,
            imagem: "kyoto",
            partida: "12/07/2027",
            retorno: "20/07/2027",
            hospedagem: "Kyoto Sakura Inn - hospedagem tradicional japonesa com café da manhã e vista para os jardins."
        ),
        
        Viagem(
            nome: "Luzes de Nova York",
            local: "Nova York, EUA",
            diarias: 6,
            preco: 6850.00,
            imagem: "novayork",
            partida: "03/08/2027",
            retorno: "08/08/2027",
            hospedagem: "Manhattan Central Hotel - 4 estrelas, localizado próximo à Times Square."
        ),
        
        Viagem(
            nome: "Sol em Roma",
            local: "Roma, Itália",
            diarias: 7,
            preco: 4800.00,
            imagem: "roma",
            partida: "18/05/2027",
            retorno: "25/09/2027",
            hospedagem: "Roma Imperial Resort - 4 estrelas, a poucos minutos do Coliseu e com café da manhã incluso."
        )
    ]
    
    var quantidadeFavoritas: Int {
        viagens.filter { $0.favorita }.count
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink {
                            
                            FavoritosView(viagens: $viagens)
                        } label: {
                            
                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                
                                Text("\(quantidadeFavoritas)")
                                    .foregroundColor(.red)
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                        }
                    }
                    
                    .padding(.horizontal)
                    
                    Text("Explorar Viagens")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 0){
                            
                            ForEach($viagens) { $viagem in
                                
                                NavigationLink {
                                    DetalhesView(viagem: viagem)
                                } label: {
                                    ViagemRow(viagem: $viagem)
                                }
                                
                                Divider()
                            }
                            
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding()
                }
            }
        }
    }
}

struct DetalhesView: View {
    
    let viagem: Viagem
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20){
                
                Image(viagem.imagem)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
                
                Text(viagem.local)
                    .foregroundColor(.blue)
                    .font(.title3)
                
                Text(viagem.nome)
                    .font(.largeTitle)
                    .bold()
                
                Divider()
                
                HStack {
                    
                    VStack(alignment: .leading){
                        Text("Partida")
                            .foregroundColor(.gray)
                        
                        Text(viagem.partida)
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text("Duração")
                            .foregroundColor(.gray)
                        
                        Text("\(viagem.diarias) dias")
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text("Retorno")
                            .foregroundColor(.gray)
                        
                        Text(viagem.retorno)
                            .bold()
                    }
                }
                
                Divider()
                
                Text("Hospedagem")
                    .font(.title2)
                    .bold()
                
                Text(viagem.hospedagem)
                    .foregroundColor(.gray)
                
                Button {
                    
                } label: {
                    
                    Text("Reservar por R$ \(viagem.preco, specifier: "%.2f")")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .padding(.top)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FavoritosView: View {
    
    @Binding var viagens: [Viagem]
    
    var favoritas: [Viagem] {
        viagens.filter { $0.favorita }
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                Text("Meus Favoritos")
                    .font(.largeTitle)
                    .bold()
                
                VStack(spacing: 0){
                    
                    if favoritas.isEmpty {
                        
                        VStack(spacing: 20){
                            
                            Image(systemName: "heart.slash")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            
                            Text("Nenhum favorito ainda")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 60)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        
                    } else {
                        ForEach(favoritas) { viagem in
                            
                            HStack(spacing: 16){
                                
                                Image(viagem.imagem)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 110, height: 110)
                                    .clipped()
                                    .cornerRadius(16)
                                
                                VStack(alignment: .leading, spacing: 8){
                                    
                                    Text(viagem.nome)
                                        .font(.title3)
                                        .bold()
                                    
                                    Text(viagem.local)
                                        .foregroundColor(.gray)
                                    
                                    Text("\(viagem.diarias) diarias • R$ \(viagem.preco, specifier: "%.2f")")
                                        .foregroundColor(.blue)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                        
                        Divider()
                    }
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            .padding()
        }
        .background(Color(.systemGray6))
    }
}

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

#Preview {
    ContentView()
}
