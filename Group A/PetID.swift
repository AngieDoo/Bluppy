import SwiftUI

struct PetIDView: View {
    @Binding var currentRoom: String
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 4) {
                Text("Welcome to Bluppy!")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                Text("Here is your personal pet assistant.")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 0.1, green: 0.25, blue: 0.5).opacity(0.8))
            }
            .multilineTextAlignment(.center)
            .padding(.top, 30)
            
            HStack(spacing: 15) {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 5) {
                    DetailRow(label: "NAME", value: "Mimo")
                    DetailRow(label: "BREED", value: "Orange Cat")
                    DetailRow(label: "PERSONALITY", value: "Cute,Playful")
                }
            }
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
            .padding(.horizontal, 30)
            
            Button(action: { withAnimation { currentRoom = "Menu" } }) {
                Text("GO EXPLORE")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(width: 90, height: 26)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
    }
}

struct DetailRow: View {
    var label: String; var value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label).font(.system(size: 7, weight: .bold)).foregroundColor(.gray)
            Text(value).font(.system(size: 11, weight: .medium)).foregroundColor(.black)
        }
    }
}
