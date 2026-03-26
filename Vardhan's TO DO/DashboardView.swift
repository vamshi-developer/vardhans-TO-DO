import SwiftUI

struct DashboardView: View {

    @ObservedObject var manager: TaskManager
    @State private var animate = false

    var body: some View {

        VStack(spacing: 30) {

            // Animated Title
            Text("Vardhan's TO DO")
                .font(.largeTitle)
                .fontWeight(.bold)
                .scaleEffect(animate ? 1.1 : 1)
                .animation(
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true),
                    value: animate
                )
                .onAppear { animate = true }

            // Stats Card
            VStack {
                Text("Today's Progress")
                    .font(.headline)

                ProgressCircleView(manager: manager)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)

        }
        .padding()
    }
}
