import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    func addTask(title: String) {
        let task = Task(title: title, isCompleted: false)
        tasks.append(task)
    }
    
    func toggleTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
