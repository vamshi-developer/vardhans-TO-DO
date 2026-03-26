import SwiftUI

struct ProgressView: View {

    @ObservedObject var manager: TaskManager

    var body: some View {

        let completed = manager.tasks.filter { $0.isCompleted }.count
        let total = manager.tasks.count

        VStack {

            Text("Tasks Completed")
                .font(.title)

            Text("\(completed) / \(total)")
                .font(.largeTitle)

        }
        .navigationTitle("Progress")

    }
}
