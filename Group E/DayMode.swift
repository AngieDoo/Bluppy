import SwiftUI
import AVKit

struct DayMode: View {
    @Binding var currentRoom: String
    @State private var player = AVPlayer(url: Bundle.main.url(forResource: "Day", withExtension: "mp4")!)

    var body: some View {
        ZStack {
            PlayerView(player: player)
                .onAppear {
                    player.play()
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                        player.seek(to: .zero)
                        player.play()
                    }
                }
            
            VStack {
                Spacer()
                HStack {
                    Button(action: { withAnimation { currentRoom = "Menu" } }) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color(red: 0.05, green: 0.15, blue: 0.4))
                            .clipShape(Circle())
                    }
                    .padding(10.5)
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }
            }
        }
        .frame(width: 400, height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct PlayerView: NSViewRepresentable {
    var player: AVPlayer
    
    func makeNSView(context: Context) -> AVPlayerView {
        let view = AVPlayerView()
        view.player = player
        view.controlsStyle = .none
        view.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateNSView(_ nsView: AVPlayerView, context: Context) {}
}
