import SwiftUI

struct MenuView: View {
    @Binding var currentRoom: String
    let brandBlue = Color(red: 0.1, green: 0.25, blue: 0.5)
    let pawPink = Color(red: 0.95, green: 0.75, blue: 0.85)

    var body: some View {
        VStack(spacing: 20) {
            Text("MENU")
                .font(.system(size: 24, weight: .black, design: .rounded))
                .foregroundColor(brandBlue)
                .padding(.top, 20)
            
            HStack(spacing: 15) {
                CustomMenuButton(label: "BlupptsApp", icon: "bubble.left.and.bubble.right", color: pawPink) {
                    currentRoom = "Chat"
                }
                
                CustomMenuButton(label: "Bluppy LIVE", icon: "camera", color: pawPink) {
                    currentRoom = "Bluppy LIVE"
                }
                
                CustomMenuButton(label: "Timer", icon: "timer", color: pawPink) {
                    currentRoom = "Timer"
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .frame(width: 400, height: 250)
    }
}

struct CustomMenuButton: View {
    var label: String
    var icon: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                Text(label)
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
            }
            .frame(width: 90, height: 90)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
