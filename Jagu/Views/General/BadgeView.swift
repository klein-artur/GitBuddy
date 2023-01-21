//
//  BadgeView.swift
//  Jagu
//
//  Created by Artur Hellmann on 05.01.23.
//

import SwiftUI

struct BadgeView<Content: View>: View {
    let content: Content
    let backgroundColor: Color
    
    init(backgroundColor: Color, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        self.content
            .padding(5)
            .font(.system(size: 10))
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}

struct BadgeVeiw_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(backgroundColor: Color.red) {
            HStack {
                Text("Tag Name")
            }
        }
    }
}
