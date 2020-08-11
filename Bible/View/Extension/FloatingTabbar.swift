//
//  FloatingTabbar.swift
//  Bible
//
//  Created by jge on 2020/08/11.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct FloatingTabbar: View {
    var body: some View {
        HStack(alignment: .center) {
            barView(imageName: "LeftBook", text: "통독표")
                .padding(.leading, 20)
            
            Spacer()
            
            barView(imageName: "MusicBook", text: "찬송가")
            
            Spacer()
            
            barView(imageName: "Book", text: "교독문")
            
            Spacer()
            
            barView(imageName: "CCM", text: "CCM 듣기")
                .padding(.trailing, 20)
            
        }.padding(.top, 10)
            .padding(.bottom, 10)
            .background(Color("LightGray"))
            .clipShape(Capsule())
            .shadow(radius: 10)
    }
}

struct barView: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .frame(width: 40, height: 40)
            Text(text)
        }
    }
}

struct FloatingTabbar_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTabbar().previewLayout(.sizeThatFits)
    }
}
