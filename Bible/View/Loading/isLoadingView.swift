//
//  loading.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct isLoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 4,
                       height: geometry.size.width / 4)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}

struct isLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        isLoadingView(isShowing: .constant(true)) {
            Text("asdf")
        }.previewLayout(.sizeThatFits)
//        .environment(\.sizeCategory, .extraLarge)
    }
}
