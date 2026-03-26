
import SwiftUI

struct ProgressCircleView: View {

    @ObservedObject var manager: TaskManager

    var progress: Double {
        let total = manager.tasks.count
        let completed = manager.tasks.filter { $0.isCompleted }.count
        return total == 0 ? 0 : Double(completed) / Double(total)
    }

    var body: some View {

        ZStack {

            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 15)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.green,
                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)

            Text("\(Int(progress * 100))%")
                .font(.title)
                .fontWeight(.bold)

        }
        .frame(width: 150, height: 150)
    }
}
