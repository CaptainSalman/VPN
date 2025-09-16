
import SwiftUI

struct CustomTab: View {
    @Binding var selectedTab: Tab
       
    enum Tab: String {
       case home, identity, spyDefense, settings, eye
    }
    var body: some View {
        ZStack {
            // Background with custom notch
            TabBarShape()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 80)
                .shadow(radius: 4)
            
            HStack {
                tabButton(tab: .home, icon: "house.fill", title: "Home")
                tabButton(tab: .identity, icon: "person.crop.circle", title: "Identity")
                
                Spacer(minLength: 0) // leave space for center button
                
                tabButton(tab: .spyDefense, icon: "shield.fill", title: "Spy Defense")
                tabButton(tab: .settings, icon: "gearshape.fill", title: "Settings")
            }
            .padding(.horizontal, 25)
            .frame(height: 70)
            
            // Center Button
            Button(action: {
                selectedTab = .eye
            }) {
                Image(systemName: "eye")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 70, height: 70)
                    .background(Color.purple)
                    .clipShape(Circle())
                    .shadow(radius: 6)
            }
            .offset(y: -40) // pull up inside cutout
        }
    }
    @ViewBuilder
    private func tabButton(tab: Tab, icon: String, title: String) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 22))
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(selectedTab == tab ? .purple : .gray)
        }
    }
}

#Preview {
    CustomTab(selectedTab: .constant(.home))
}



// MARK: - Custom Shape with notch
struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let centerX = rect.midX
        let circleRadius: CGFloat = 42
        let circleY: CGFloat = 0
        let cornerRadius: CGFloat = 20
        
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centerX - circleRadius - cornerRadius, y: 0))
        
        path.addQuadCurve(
            to: CGPoint(x: centerX - circleRadius + 5, y: -cornerRadius),
            control: CGPoint(x: centerX - circleRadius, y: 0)
        )
        
        // Draw circular arc cutout
        path.addArc(
            center: CGPoint(x: centerX, y: circleY),
            radius: circleRadius,
            startAngle: .degrees(200),
            endAngle: .degrees(-20),
            clockwise: false
        )
        
        path.addQuadCurve(
            to: CGPoint(x: centerX + circleRadius + cornerRadius, y: 0),
            control: CGPoint(x: centerX + circleRadius, y: 0)
        )
        
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}
