import SwiftData
import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ListaEventosView()
                .modelContainer(for: Evento.self)
        }
    }
}
