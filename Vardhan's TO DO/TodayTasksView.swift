import SwiftUI
import UserNotifications

struct TodayTasksView: View {

    @ObservedObject var manager: TaskManager

    @State private var newTask = ""
    @State private var reminderInterval: TimeInterval = 3600
    @State private var selectedDate = Date()

    var body: some View {

        VStack {

            // DATE
            Text(todayDate())
                .font(.headline)
                .padding(.top)

            // INPUT FIELD
            HStack {

                TextField("Enter Task", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Add") {

                    if !newTask.isEmpty {

                        manager.addTask(
                            title: newTask,
                            interval: reminderInterval
                        )

                        // 🔔 Exact time notification
                        scheduleExactNotification(
                            task: newTask,
                            date: selectedDate
                        )

                        newTask = ""

                    }

                }

            }
            .padding()

            // DATE PICKER (EXACT TIME)
            DatePicker(
                "Select Time",
                selection: $selectedDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .padding()

            // REMINDER PICKER (INTERVAL)
            Picker("Reminder", selection: $reminderInterval) {

                Text("20 min").tag(1200.0)
                Text("1 hr").tag(3600.0)
                Text("2 hr").tag(7200.0)
                Text("3 hr").tag(10800.0)

            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // TASK LIST
            List {

                ForEach(manager.tasks) { task in

                    HStack {

                        Button(action: {
                            manager.toggleTask(task)
                        }) {

                            Image(systemName:
                                  task.isCompleted ?
                                  "checkmark.circle.fill" :
                                  "circle")
                                .foregroundColor(.blue)
                        }

                        Text(task.title)

                    }

                }
                .onDelete(perform: manager.deleteTask)

            }

        }
        .navigationTitle("Today's Tasks")

        // REQUEST PERMISSION
        .onAppear {

            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge]) { success, error in

                    if success {
                        print("Permission granted")
                    } else {
                        print("Permission denied")
                    }

                }

        }

    }

    // DATE FUNCTION
    func todayDate() -> String {

        let formatter = DateFormatter()
        formatter.dateStyle = .full

        return formatter.string(from: Date())

    }

    // 🔔 EXACT TIME NOTIFICATION
    func scheduleExactNotification(task: String, date: Date) {

        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = task

        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)

    }

}
