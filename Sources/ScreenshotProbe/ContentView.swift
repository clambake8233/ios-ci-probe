import SwiftUI

struct ContentView: View {
    @State private var taps = 0

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.indigo, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundStyle(.white)
                    .shadow(radius: 8)

                Text("Screenshot CI Probe")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Text("Rendered on the iOS Simulator")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.85))

                // A colored card so layout + fills are visually verifiable.
                VStack(spacing: 12) {
                    Text("Taps: \(taps)")
                        .font(.title2.monospacedDigit().bold())
                    Button {
                        taps += 1
                    } label: {
                        Label("Tap me", systemImage: "hand.tap.fill")
                            .font(.headline)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    .foregroundStyle(.purple)
                }
                .padding(24)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))

                Text(buildStamp)
                    .font(.caption.monospaced())
                    .foregroundStyle(.white.opacity(0.7))
                    .accessibilityIdentifier("buildStamp")
            }
            .padding()
        }
    }

    // A compile-time-ish marker so each screenshot is traceable to a build.
    private var buildStamp: String {
        "probe • \(Bundle.main.bundleIdentifier ?? "?")"
    }
}
