import SwiftUI
import AppKit

@main
struct BluppyApp: App {
    init() {
        GlobalWindowManager.shared.setupPanel()
        
        NSApp.setActivationPolicy(.accessory)
        
        GlobalWindowManager.shared.showWindow()
    }

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
