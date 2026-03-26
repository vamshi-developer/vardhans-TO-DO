import SwiftUI

struct AnimatedLogoView: View {

    @State private var animate = false

    var body: some View {

        Text("Vardhan's TO DO")
            .font(.largeTitle)
            .fontWeight(.bold)
            .scaleEffect(animate ? 1.1 : 1)
            .animation(
                Animation.easeInOut(duration: 2)
                .repeatForever(autoreverses: true),
                value: animate
            )
            .onAppear {
                animate = true
            }

    }
}
