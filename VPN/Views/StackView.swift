import SwiftUI

struct StackView: View {
    let features = [
            "Change IP Address",
            "Always on VPN",
            "VPN Kill Switch",
            "Hi-Speed Browsing",
            "100% Ad-Free",
            "100+ Server Locations"
        ]
    
    var body: some View {
        ZStack{
            Image("MainBackGround")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                Image("Settings")
                    .resizable()
                    .frame(width: 200, height: 200)
                HStack(spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("VPN Features")
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        ForEach(features, id: \.self) { feature in
                            Text(feature)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding()
                    .frame(maxHeight: 344)
                    .background(Color.white)
                    .cornerRadius(12)

                    
                    VStack(spacing: 20) {
                        Text("Free")
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        checkmarkList(statuses: [true, false, false, false, false, false])
                    }
                    .padding()
                    .frame(maxHeight: 344)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    VStack(spacing: 20) {
                        HStack {
                            Text("Pro")
                                .font(.headline)
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)
                        }
                        .padding(.bottom, 10)
                        
                        checkmarkList(statuses: [true, true, true, true, true, true])
                    }
                    .padding()
                    .frame(maxHeight: 344)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(12)
                }
                .padding()
            }
        }
    }
    private func checkmarkList(statuses: [Bool]) -> some View {
       VStack(spacing: 20) {
           ForEach(statuses, id: \.self) { status in
               Image(systemName: status ? "checkmark.circle.fill" : "xmark.circle.fill")
                   .foregroundColor(status ? .green : .red)
           }
       }
   }
}

#Preview {
    StackView()
}
