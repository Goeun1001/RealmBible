//
//  NumberListView.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct NumberListView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Binding var dismissAll: Bool
    
    var bcode: Int
    var chapter_num: Int
    var name : String
    
    var body: some View {
//        NavigationView {
//        ForEach(1..<chapter_num, id: \.self) { number in
//            numberGridView(text: String(number))
//        }
        WaterfallGrid(1..<chapter_num + 1, id: \.self)  { number in
                Text(String(number))
                .font(.headline)
                .foregroundColor(.black)
                    .frame(width: 40)
                    .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 2)
                ).onTapGesture {
                    UserDefaults.standard.set("\(self.bcode)", forKey: "bcode")
                    UserDefaults.standard.set("\(number)", forKey: "cnum")
                    UserDefaults.standard.synchronize()
                    print(number)
                    self.presentationMode.wrappedValue.dismiss()
                    self.dismissAll = true
                }
        }.gridStyle(columns: 4, spacing: 10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .navigationBarTitle(name)
//        }
        
    }
}

//struct NumberListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NumberListView(dismissAll: false, bcode: 1, chapter_num: 30, name: "창세기")
//    }
//}
