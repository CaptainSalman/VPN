
import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Image("MainBackGround")
                .resizable()
                .ignoresSafeArea()

            VStack {
                HStack (spacing: 0){
                    ButtonComponent(imageName: "setting")
                        .padding(.trailing, 9)
                    ButtonComponent(imageName: "speedoMeter")
                    Spacer()
                    UpGradeButton()
                }
                // asdfasdfsdfasdf
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ServerComponent()
                    .padding(.top, 22)
                
                Image("VPN Button")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 222)
                    .padding(.top, 20)
                
                HStack{
                    Image("Tick")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20)
                    Text("Tap to Connect")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(Color(#colorLiteral(red: 0.2980392277, green: 0.3098039329, blue: 0.3294117749, alpha: 1)))
                }
                .padding(.top, 20)
                
                GridOfTimeAndLocation()
                
                Spacer()
            }
            .safeAreaPadding()
        }
    }
}

#Preview {
    MainView()
}


// MARK: Button Component

struct ButtonComponent: View {
    var imageName: String
    var body: some View {
        Rectangle()
            .fill(Color(#colorLiteral(red: 0.962238729, green: 0.9752469659, blue: 0.9876249433, alpha: 1)).opacity(0.8))
            .frame(width: 38, height: 38)
            .overlay {
                Image(imageName)
            }
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.18),
                    radius: 1,
                    x: 0,
                    y: 5)
    }
}

// MARK: UPGrade Button

struct UpGradeButton: View {
    var body: some View {
        ZStack{
            Image("upgradeBG")
                .resizable()
            HStack (spacing: 3){
                Image("Crown")
                    .resizable()
                    .frame(width: 25, height: 21)
                Text("Upgrade")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color.white)
            }
        }
        .frame(width: 95, height: 40)
        
   }
}


// MARK: Server Component

struct ServerComponent: View {
    var body: some View {
        ZStack{
            HStack{
                Image("Flag")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 44)
                VStack{
                    Text("Germany")
                        .font(.system(size: 14, weight: .semibold))
                    Text("Mannheim")
                        .font(.system(size: 12, weight: .light))
                }
                .padding(.trailing, 40)
                Image("Arrow")
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 10)
        }
        .background(Color(#colorLiteral(red: 0.962238729, green: 0.9752469659, blue: 0.9876249433, alpha: 1)).opacity(0.8))
        .cornerRadius(16)
    }
}


// MARK: GridOfTimeAndLocation

struct GridOfTimeAndLocation: View {
    var body: some View {
        
        Grid(horizontalSpacing: 11, verticalSpacing: 7) {
            GridRow{
                Text("Free Time")
                    .font(.system(size: 14, weight: .semibold))
                Text("Location")
                    .font(.system(size: 14, weight: .semibold))
            }
            GridRow{
                HStack(spacing: 9){
                    Image("Plus")
                    Text("00:00:00")
                }
                .frame(width: 150,height: 46)
                .background(
                    Color(#colorLiteral(red: 0.9529411793, green: 0.9686274529, blue: 0.9843137264, alpha: 1))
                )
                .cornerRadius(10)
                
                HStack(spacing: 9){
                    Image("Pin")
                    VStack{
                        Text("Germany")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Mannheim")
                            .font(.system(size: 12, weight: .light))
                    }
                    Image("arrowRight")
                        .padding(.leading, 20)
                }
                .background(
                    Color(#colorLiteral(red: 0.9529411793, green: 0.9686274529, blue: 0.9843137264, alpha: 1))
                )
                .frame(width: 150,height: 46)
                .background(
                    Color(#colorLiteral(red: 0.9529411793, green: 0.9686274529, blue: 0.9843137264, alpha: 1))
                )
                .cornerRadius(10)
            }
            GridRow{
                ControlServerSpeedComponent()

            }
            .gridCellColumns(2)
            GridRow{
                SettingsAndBoostComponent(imageName: "Settings", textName: "Advanced Settings")
                SettingsAndBoostComponent(imageName: "SecoreVpn", textName: "Boost VPN")
            }

        }
        .padding(.top, 20)
    }
}

// MARK: ControlServerSpeedComponent

struct ControlServerSpeedComponent: View {
    @State var value: Double = 0
    private let totalWidth: CGFloat = 308
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Text("Control Server Speed")
                .font(.system(size: 14, weight: .light))
                .padding(.bottom, 10)
            MovingSpeedText(value: $value)
                .offset(x: calculateOffset())
            
            Slider(value: $value, in: 0...100)
                .frame(width: totalWidth)
            
            HStack{
                Text("Slow")
                Spacer()
                Text("Fast")
            }
        }
        .frame(width: 308)
    }
    private func calculateOffset() -> CGFloat {
        let valuePercentage = CGFloat(value) / 110
        let position = valuePercentage * totalWidth
        return position - 10
    }
}

// MARK: MovingSpeedText

struct MovingSpeedText: View {
    @Binding var value: Double
    var body: some View {
        ZStack{
            Image("Union")
                .resizable()
                .scaledToFit()
                .frame(width: 47, height: 20)
            Text("\(Int(value))MB/s")
                .font(.system(size: 10))
                
        }
    }
}

// MARK: SettingsAndBoostComponent

struct SettingsAndBoostComponent: View {
    var imageName: String
    var textName: String
    var body: some View {
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text(textName)
                .font(.system(size: 14, weight: .light))
        }
        .frame(width: 150, height: 90)
        .background(
            Color(#colorLiteral(red: 0.9529411793, green: 0.9686274529, blue: 0.9843137264, alpha: 1))
        )
        .cornerRadius(10)
    }
}
