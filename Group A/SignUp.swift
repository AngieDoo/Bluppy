import SwiftUI

struct SignUpView: View {
    @Binding var currentRoom: String
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 8) {
            Text("BLUPPY")
                .font(.system(size: 24, weight: .black, design: .rounded))
                .foregroundColor(Color(red: 0.1, green: 0.25, blue: 0.5))
                .padding(.top, 20)
            
            Text("SIGN IN")
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(.horizontal, 10)
                .padding(.vertical, 2)
                .background(RoundedRectangle(cornerRadius: 6).fill(Color.white))
            
            VStack(spacing: 8) {
                CustomInputBox(title: "USERNAME", text: $username)
                CustomInputBox(title: "EMAIL", text: $email)
                CustomInputBox(title: "PASSWORD", text: $password, isSecure: true)
            }.padding(.horizontal, 82)
            
            Button(action: { withAnimation { currentRoom = "PetID" } }) {
                Text("CONTINUE")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(width: 70, height: 26)
                    .background(Color.blue)
                    .cornerRadius(8)
            }.buttonStyle(PlainButtonStyle()).padding(.top, 5)
            Spacer()
        }.frame(width: 400, height: 250)
    }
}

struct CustomInputBox: View {
    var title: String; @Binding var text: String; var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(title)
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(.black)
                .padding(.leading, 4)
            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white)
                    .frame(height: 28)
                
                (isSecure ? AnyView(SecureField("", text: $text)) : AnyView(TextField("", text: $text)))
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .font(.system(size: 10))
            }
        }
    }
}
