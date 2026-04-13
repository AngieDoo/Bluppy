import SwiftUI
import Combine

struct TimerView: View {
    @Binding var currentRoom: String
    @Binding var inputTime: String
    @Binding var isRunning: Bool
    
    @FocusState private var isFieldFocused: Bool
    
    var formattedDisplay: String {
        let clean = inputTime.filter { "0123456789".contains($0) }
        let padded = clean.padding(toLength: 6, withPad: "0", startingAt: 0)
        let hours = padded.prefix(2)
        let minutes = padded.dropFirst(2).prefix(2)
        let seconds = padded.suffix(2)
        return "\(hours):\(minutes):\(seconds)"
    }

    var body: some View {
        ZStack {
            Color(red: 0.85, green: 0.93, blue: 1.0).ignoresSafeArea()
            
            VStack(spacing: 25) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12).fill(Color.white).frame(width: 260, height: 80)
                    
                    Text(formattedDisplay)
                        .font(.system(size: 45, weight: .medium, design: .rounded))
                        .foregroundColor(inputTime == "000000" ? .red : .black)
                    
                    TextField("", text: $inputTime)
                        .font(.system(size: 45, design: .rounded))
                        .multilineTextAlignment(.center)
                        .textFieldStyle(PlainTextFieldStyle())
                        .foregroundColor(.clear)
                        .accentColor(.black)
                        .frame(width: 260, height: 80)
                        .focused($isFieldFocused)
                        .disableAutocorrection(true)
                        .disabled(inputTime == "000000")
                        .onReceive(Just(inputTime)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered.count <= 6 { inputTime = filtered }
                            else { inputTime = String(filtered.prefix(6)) }
                            
                            if inputTime == "000000" { isFieldFocused = false }
                        }
                }

                HStack(spacing: 20) {
                    if !isRunning {
                        Button(action: {
                            if !inputTime.isEmpty && inputTime != "000000" {
                                isRunning = true
                                withAnimation { currentRoom = "NightMode" }
                            }
                        }) {
                            Text("START").font(.system(size: 14, weight: .bold)).foregroundColor(.white)
                                .frame(width: 90, height: 38).background(Color(red: 0.65, green: 0.78, blue: 0.59)).cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else {
                        Button(action: { isRunning = false }) {
                            Text("PAUSE").font(.system(size: 14, weight: .bold)).foregroundColor(.white)
                                .frame(width: 90, height: 38).background(Color(red: 0.96, green: 0.87, blue: 0.60)).cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Button(action: {
                        isRunning = false
                        inputTime = ""
                        isFieldFocused = true
                    }) {
                        Text("END").font(.system(size: 14, weight: .bold)).foregroundColor(.white)
                            .frame(width: 90, height: 38).background(Color(red: 0.91, green: 0.59, blue: 0.58)).cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }

            VStack {
                Spacer()
                HStack {
                    Button(action: { isRunning = false; withAnimation { currentRoom = "Menu" } }) {
                        Image(systemName: "house.fill").font(.system(size: 12)).foregroundColor(.white)
                            .padding(6).background(Color(red: 0.05, green: 0.15, blue: 0.4)).clipShape(Circle())
                    }
                    .padding(10.5)
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
        }
    }
}
