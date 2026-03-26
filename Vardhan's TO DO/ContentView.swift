import SwiftUI
import UserNotifications

struct ContentView: View {

    @StateObject private var manager = TaskManager()

    @State private var newTask = ""
    @State private var reminderInterval: TimeInterval = 3600

    var body: some View {

        NavigationSplitView {

            List {

                NavigationLink("Dashboard", destination: DashboardView(manager: manager))

                    NavigationLink("Today's Tasks", destination: TodayTasksView(manager: manager))

                    NavigationLink("Completed Tasks", destination: CompletedTasksView(manager: manager))

                    NavigationLink("History", destination: HistoryView(manager: manager))

                    NavigationLink("Progress Analytics", destination: ProgressView(manager: manager))
            }
            .navigationTitle("☰ Menu")

        } detail: {

            TodayTasksView(manager: manager)

        }

    }
}
