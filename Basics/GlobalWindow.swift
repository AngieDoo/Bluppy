import AppKit
import SwiftUI

class GlobalWindowManager {
    static let shared = GlobalWindowManager()
    var panel: NSPanel?
    var eventMonitor: Any?
    var keyBuffer: String = ""

    func setupPanel() {
        let targetSize = NSSize(width: 400, height: 250)
        let windowRect = NSRect(origin: CGPoint(x: 100, y: 100), size: targetSize)
        
        panel = NSPanel(
            contentRect: windowRect,
            styleMask: [.nonactivatingPanel, .titled, .fullSizeContentView],
            backing: .buffered, defer: false
        )
        
        panel?.setFrame(windowRect, display: true)
        panel?.setContentSize(targetSize)
        panel?.isFloatingPanel = true
        panel?.level = .floating
        panel?.collectionBehavior = [.canJoinAllSpaces, .stationary]
        panel?.isMovableByWindowBackground = true
        panel?.titleVisibility = .hidden
        panel?.titlebarAppearsTransparent = true
        panel?.isOpaque = false
        panel?.backgroundColor = .clear
        
        let hostingView = NSHostingView(rootView: ContentView().frame(width: 400, height: 250))
        hostingView.setFrameSize(targetSize)
        hostingView.autoresizingMask = [.width, .height]
        panel?.contentView = hostingView
        
        hostingView.wantsLayer = true
        hostingView.layer?.cornerRadius = 30
        hostingView.layer?.masksToBounds = true
    }

    func showWindow() { panel?.makeKeyAndOrderFront(nil); NSApp.activate(ignoringOtherApps: true) }
    func hideWindow() { panel?.orderOut(nil) }
}
