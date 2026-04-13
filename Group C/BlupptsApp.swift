import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isMimo: Bool
}

struct BlupptsApp: View {
    @Binding var currentRoom: String
    @State private var messageText: String = ""
    @State private var isLoading: Bool = false
    @State private var messages: [Message] = [
        Message(content: "Meow! I am Mimo.", isMimo: true)
    ]
    
    let babyBlue = Color(red: 0.85, green: 0.93, blue: 1.0)
    let darkBlue = Color(red: 0.05, green: 0.15, blue: 0.4)
    let mimoGreen = Color.green
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 90)
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(messages) { msg in
                                ChatBubbleView(msg: msg, mimoGreen: mimoGreen)
                            }
                            if isLoading {
                                HStack(spacing: 4) {
                                    Image(systemName: "pawprint.fill").font(.system(size: 8))
                                    Text("loading...").font(.system(size: 10, design: .monospaced))
                                }
                                .foregroundColor(.gray).padding(.leading, 10)
                            }
                        }
                        .padding(8)
                    }
                    
                    HStack(spacing: 5) {
                        TextField("Meow...", text: $messageText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .font(.system(size: 10))
                            .padding(10)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                        
                        Button(action: sendMessage) {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .frame(width: 22, height: 22) // Borderless arrow button
                                .foregroundColor(messageText.isEmpty || isLoading ? .gray : darkBlue)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .disabled(isLoading || messageText.isEmpty)
                    }
                    .padding(8)
                    .background(Color.white.opacity(0.2))
                }
                .background(babyBlue)
            }
            
            Button(action: { currentRoom = "Menu" }) {
                Image(systemName: "house.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(darkBlue)
                    .clipShape(Circle())
            }
            .padding(10.5)
            .buttonStyle(PlainButtonStyle())
        }
    }

    func sendMessage() {
        let userQuery = messageText
        messages.append(Message(content: userQuery, isMimo: false))
        messageText = ""
        isLoading = true
        
        APIManager.getResponse(for: userQuery) { response in
            DispatchQueue.main.async {
                self.messages.append(Message(content: response, isMimo: true))
                self.isLoading = false
            }
        }
    }
}

struct ChatBubbleView: View {
    let msg: Message
    let mimoGreen: Color
    var body: some View {
        HStack {
            if !msg.isMimo { Spacer() }
            Text(msg.content)
                .font(.system(size: 10))
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(msg.isMimo ? Color.white : mimoGreen)
                .foregroundColor(msg.isMimo ? .black : .white)
                .cornerRadius(10)
            if msg.isMimo { Spacer() }
        }
    }
}
