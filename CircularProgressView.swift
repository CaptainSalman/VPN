import SwiftUI

struct CircularProgressView: View {
    var progress: CGFloat // value between 0.0 and 1.0
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.white.opacity(0.3), lineWidth: 20)
            
            // Progress circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.white,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)
                )
                .rotationEffect(.degrees(180)) // start from top
                .animation(.easeInOut(duration: 0.6), value: progress) // animate smoothly
            
            // Text in center
            Text("\(Int(round(progress * 100)))%")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
    }
}

// Example usage
struct contentView: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        VStack(spacing: 40) {
            CircularProgressView(progress: progress)
            
            Button("Increase Progress") {
                withAnimation {
                    if progress <= 1.0 {
                        progress += 0.1
                    }
                }
            }
            .padding()
            .background(Color.white)
            .foregroundColor(.purple)
            .cornerRadius(12)
        }
        .padding()
        .background(Color.purple.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    contentView()
}
