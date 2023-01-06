//
//  TagCloudView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 05.01.23.
//

import SwiftUI

struct TagElement: Identifiable, Hashable {
    let icon: Image
    let text: String
    
    var id: String {
        text
    }
    
    var hashValue: Int {
        text.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        text.hash(into: &hasher)
    }
}

struct TagCloudView: View {
    let tags: [TagElement]
    let backgroundColor: Color
    let foregroundColor: Color

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
//        = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
//        .frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags) { tag in
                BadgeView(backgroundColor: backgroundColor) {
                    HStack {
                        tag.icon
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundColor(foregroundColor)
                            .frame(width: 14, height: 14)
                            .padding(.trailing, -4)
                        Text(tag.text)
                            .foregroundColor(foregroundColor)
                    }
                }
                .padding([.horizontal, .vertical], 4)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if tag == self.tags.last! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if tag == self.tags.last! {
                        height = 0 // last item
                    }
                    return result
                })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct TagCloudView_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Header").font(.largeTitle)
            TagCloudView(tags: [TagElement(icon: Image("tag-solid"), text: "Ninetendo"), TagElement(icon: Image("tag-solid"), text: "XBox"), TagElement(icon: Image("tag-solid"), text: "PlayStation"), TagElement(icon: Image("tag-solid"), text: "PlayStation 2"), TagElement(icon: Image("tag-solid"), text: "PlayStation 3"), TagElement(icon: Image("tag-solid"), text: "PlayStation 4"), TagElement(icon: Image("tag-solid"), text: "Ninetendo"), TagElement(icon: Image("tag-solid"), text: "XBox"), TagElement(icon: Image("tag-solid"), text: "PlayStation"), TagElement(icon: Image("tag-solid"), text: "PlayStation 2"), TagElement(icon: Image("tag-solid"), text: "PlayStation 3"), TagElement(icon: Image("tag-solid"), text: "PlayStation 4"), TagElement(icon: Image("tag-solid"), text: "Ninetendo"), TagElement(icon: Image("tag-solid"), text: "XBox"), TagElement(icon: Image("tag-solid"), text: "PlayStation"), TagElement(icon: Image("tag-solid"), text: "PlayStation 2"), TagElement(icon: Image("tag-solid"), text: "PlayStation 3"), TagElement(icon: Image("tag-solid"), text: "PlayStation 4")], backgroundColor: Color(red: 0.87, green: 0.97, blue: 0.89), foregroundColor: .black)
            Text("Some other text")
            Divider()
            Text("Some other cloud")
            TagCloudView(tags: [TagElement(icon: Image("tag-solid"), text: "Apple"), TagElement(icon: Image("tag-solid"), text: "Amazon"), TagElement(icon: Image("tag-solid"), text: "Google"), TagElement(icon: Image("tag-solid"), text: "Facebook")], backgroundColor: Color(red: 0.87, green: 0.97, blue: 0.89), foregroundColor: .black)
        }
    }
}

