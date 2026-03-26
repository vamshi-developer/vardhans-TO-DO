import SwiftUI

struct CompletedTasksView: View {

    @ObservedObject var manager: TaskManager

    var body: some View {

        List {

            ForEach(manager.tasks.filter{$0.isCompleted}) { task in
                Text(task.title)
            }

        }
        .navigationTitle("Completed Tasks")

    }

}
