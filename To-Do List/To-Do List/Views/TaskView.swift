import SwiftUI

struct TaskView: View {
    
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTask = ""
    
    
    var body: some View {
        VStack {
            HStack {
                TextField("Nova tarefa", text: $newTask)
                
                Button("Adicionar") {
                    
                    if !newTask.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.addTask(title: newTask)
                        newTask = ""
                    }
                }
            }
            .padding()
            
            List {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        
                        Text(task.title)
                            .strikethrough(task.isCompleted)
                            .foregroundStyle(task.isCompleted ? .gray : .primary)
                    }
                    .onTapGesture {
                        viewModel.toggleTask(task)
                    }
                }
                .onDelete(perform: viewModel.deleteTask)
            }
        }
    }
}

#Preview {
    TaskView()
}
