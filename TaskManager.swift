import Foundation
import Combine

class TaskManager: ObservableObject {

    @Published var tasks: [Task] = []

    private let storageKey = "vardhan_tasks"
    private let resetKey = "lastResetDate"

    init() {
        loadTasks()
        resetTasksIfNeeded()
    }

    func addTask(title: String, interval: TimeInterval) {

        let task = Task(
            title: title,
            date: Date(),
            isCompleted: false,
            reminderInterval: interval
        )

        tasks.append(task)
        saveTasks()
    }

    func deleteTask(at offsets: IndexSet) {

        for index in offsets {
            tasks.remove(at: index)
        }

        saveTasks()
    }

    func toggleTask(_ task: Task) {

        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }

        saveTasks()
    }

    func saveTasks() {

        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }

    }

    func loadTasks() {

        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {

            tasks = decoded
        }

    }

    func resetTasksIfNeeded() {

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let lastReset = UserDefaults.standard.object(forKey: resetKey) as? Date {

            if !calendar.isDate(today, inSameDayAs: lastReset) {

                tasks.removeAll()
                saveTasks()

                UserDefaults.standard.set(today, forKey: resetKey)

            }

        } else {

            UserDefaults.standard.set(today, forKey: resetKey)

        }

    }

}
