import SwiftUI
import Combine

struct ContentView: View {
    @State private var currentRoom: String = "SignUp"
    @State private var inputTime: String = ""
    @State private var isRunning = false
    
    let timerHeartbeat = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color(red: 0.75, green: 0.85, blue: 0.95)
            
            Group {
                if currentRoom == "SignUp" { SignUpView(currentRoom: $currentRoom) }
                else if currentRoom == "PetID" { PetIDView(currentRoom: $currentRoom) }
                else if currentRoom == "Menu" { MenuView(currentRoom: $currentRoom) }
                else if currentRoom == "Chat" { BlupptsApp(currentRoom: $currentRoom) }
                else if currentRoom == "Timer" { TimerView(currentRoom: $currentRoom, inputTime: $inputTime, isRunning: $isRunning) }
                else if currentRoom == "Bluppy LIVE" { DayMode(currentRoom: $currentRoom) }
                else if currentRoom == "NightMode" { NightMode(currentRoom: $currentRoom, inputTime: $inputTime, isRunning: $isRunning) }
                else if currentRoom == "Transition" { TransitionView() }
            }
        }
        .frame(width: 400, height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .onReceive(timerHeartbeat) { _ in
            if isRunning { runGlobalTimer() }
        }
    }
    
    func runGlobalTimer() {
        let clean = inputTime.filter { "0123456789".contains($0) }
        let padded = clean.padding(toLength: 6, withPad: "0", startingAt: 0)
        let h = Int(padded.prefix(2)) ?? 0
        let m = Int(padded.dropFirst(2).prefix(2)) ?? 0
        let s = Int(padded.suffix(2)) ?? 0
        var totalSeconds = (h * 3600) + (m * 60) + s
        
        if totalSeconds > 0 {
            totalSeconds -= 1
            inputTime = String(format: "%02d%02d%02d", totalSeconds / 3600, (totalSeconds % 3600) / 60, totalSeconds % 60)
        } else {
            isRunning = false
            inputTime = "000000"
            withAnimation { currentRoom = "Transition" }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                currentRoom = "NightMode"
            }
        }
    }
}
