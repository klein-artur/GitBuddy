import SwiftUI

struct KeyAwareView: NSViewRepresentable {
    let onEvent: (Event) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = KeyView()
        view.onEvent = onEvent
        DispatchQueue.main.async {
            view.window?.makeFirstResponder(view)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

extension KeyAwareView {
    enum Event {
        case upArrow
        case downArrow
        case enter
    }
}

private class KeyView: NSView {
    var onEvent: (KeyAwareView.Event) -> Void = { _ in }

    override var acceptsFirstResponder: Bool { true }
    override func keyDown(with event: NSEvent) {
        switch Int(event.keyCode) {
        case 125:
            onEvent(.downArrow)
        case 126:
            onEvent(.upArrow)
        case 36:
            onEvent(.enter)
        default:
            super.keyDown(with: event)
        }
    }
}
