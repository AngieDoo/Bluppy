import SwiftUI
import AVKit

struct TransitionView: View {
    @State private var player = AVPlayer(url: Bundle.main.url(forResource: "transition", withExtension: "mp4")!)

    var body: some View {
        CustomVideoPlayer(player: player)
            .onAppear { player.play() }
            .ignoresSafeArea()
    }
}

struct CustomVideoPlayer: NSViewRepresentable {
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
