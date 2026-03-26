import SwiftUI

struct HistoryView: View {

    @ObservedObject var manager: TaskManager

    var body: some View {

        List {

            ForEach(manager.tasks) { task in

                VStack(alignment: .leading) {

                    Text(task.title)

                    Text(task.date.formatted())
                        .font(.caption)
                        .foregroundColor(.gray)

                }

            }

        }
        .navigationTitle("History")

    }

}
