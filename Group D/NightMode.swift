import SwiftUI
import AVKit

struct NightMode: View {
    @Binding var currentRoom: String
    @Binding var inputTime: String
    @Binding var isRunning: Bool
    @State private var showFinishedPopUp = false
    @State private var player = AVPlayer(url: Bundle.main.url(forResource: "Night", withExtension: "mp4")!)

    var formattedDisplay: String {
        let clean = inputTime.padding(toLength: 6, withPad: "0", startingAt: 0)
        let h = clean.prefix(2); let m = clean.dropFirst(2).prefix(2); let s = clean.suffix(2)
        return "\(h):\(m):\(s)"
    }

    var body: some View {
        ZStack {
            CustomVideoPlayer(player: player)
                .onAppear {
                    player.play()
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                        player.seek(to: .zero)
                        player.play()
                    }
                }
                .blur(radius: showFinishedPopUp ? 8 : 0)

            VStack {
                Spacer()
                HStack(spacing: 8) {
                    Button(action: { withAnimation { currentRoom = "Menu" } }) {
                        Image(systemName: "house.fill").font(.system(size: 12)).foregroundColor(.white)
                            .padding(6).background(Color(red: 0.05, green: 0.15, blue: 0.4)).clipShape(Circle())
                    }
                    .padding(.leading, 10.5).padding(.bottom, 10.5)
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { withAnimation { currentRoom = "Timer" } }) {
                        Text("BACK").font(.system(size: 10, weight: .bold)).foregroundColor(.white)
                            .frame(width: 50, height: 24).background(Color(red: 0.05, green: 0.15, blue: 0.4)).cornerRadius(12)
                    }
                    .padding(.bottom, 10.5)
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            .blur(radius: showFinishedPopUp ? 8 : 0)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 12).fill(Color.white).frame(width: 105, height: 40).shadow(radius: 4)
                        Text(formattedDisplay).font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(inputTime == "000000" ? .red : .black)
                    }
                    .padding(20)
                }
            }
            .blur(radius: showFinishedPopUp ? 8 : 0)

            if showFinishedPopUp {
                ZStack {
                    Color.black.opacity(0.3).ignoresSafeArea()
                    
                    VStack(spacing: 12) {
                        Text("Good job today!")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                        
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                        
                        Text("Do you want to start another session?")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                showFinishedPopUp = false; inputTime = ""; withAnimation { currentRoom = "Timer" }
                            }) {
                                Text("Yes").font(.bold(.system(size: 14))())
                                    .frame(width: 80, height: 35).background(Color(red: 0.25, green: 0.75, blue: 0.75)).foregroundColor(.white).cornerRadius(10)
                            }.buttonStyle(PlainButtonStyle())
                            
                            Button(action: {
                                showFinishedPopUp = false; withAnimation { currentRoom = "Bluppy LIVE" }
                            }) {
                                Text("No").font(.bold(.system(size: 14))())
                                    .frame(width: 80, height: 35).background(Color(red: 1.0, green: 0.85, blue: 0.3)).foregroundColor(Color(red: 0.4, green: 0.3, blue: 0.0)).cornerRadius(10)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(25).background(Color(red: 1.0, green: 0.9, blue: 0.94)).cornerRadius(25)
                }
            }
        }
        .onAppear {
            if inputTime == "000000" {
                withAnimation(.spring()) { showFinishedPopUp = true }
            }
        }
    }
}
