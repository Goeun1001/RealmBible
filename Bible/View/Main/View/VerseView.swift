//
//  currentVerseView.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct VerseView: View {
    
    @ObservedObject private var verseVM = VerseViewModel()
    @State private var show_modal: Bool = false
    
    @State private var offset = CGSize.zero
    @State private var float = true
    @State var inline = false
    @State var isBookmarked = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                GeometryReader { _ in
                    List {
                        ForEach(self.verseVM.verses, id:\.id) { verse in
                            HStack {
                                VStack {
                                    Text(verse.vnum)
                                        .font(.custom("NanumSquareL", size: 20))
                                    Spacer()
                                }
                                Text(verse.content)
                                    .font(.custom("NanumSquareB", size: 18))
                                
                                Spacer()
                                
                                if verse.bookmarked == 1 {
                                    LikeLottie(filename: "like")
                                        .frame(width: 25, height: 25)
                                }
                            }.onTapGesture(count: 2) {
                                if verse.bookmarked == 1 {
                                    self.isBookmarked = false
                                } else {
                                    self.isBookmarked = true
                                }
                                self.verseVM.LikeChange(id: verse.id, bool: self.isBookmarked)
                            }
                        }
                    }
                }.gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.offset = gesture.translation
                            if self.offset.height >= 0 {
                                self.float = true
                            } else if (self.offset.height < 0) {
                                self.float = false
                            }
                    }
                )
                
                // MARK: Floating Bar
                if float {
                    HStack(alignment: .center) {
                        NavigationLink(destination: CheckListToUI()) {
                            barView(imageName: "LeftBook", text: "통독표")
                                .padding(.leading, 20)
                        }.simultaneousGesture(TapGesture().onEnded{
                            self.inline = true
                        })
                        
                        Spacer()
                        
                        NavigationLink(destination: SongListView()) {
                            barView(imageName: "MusicBook", text: "찬송가")
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: GyodokListView()) {
                            barView(imageName: "Book", text: "교독문")
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: CCMVCtoUI()) {
                            barView(imageName: "CCM", text: "CCM")
                        }.simultaneousGesture(TapGesture().onEnded{
                            self.inline = true
                        })
                        
                        Spacer()
                        
                        NavigationLink(destination: SettingView()) {
                            barView(imageName: "Settings", text: "설정")
                                .padding(.trailing, 20)
                        }
                        
                    }.padding(.top, 10)
                        .padding(.bottom, 43)
                        .background(Color("Gray"))
                        .cornerRadius(25)
                        .shadow(radius: 10)
                }
            }.edgesIgnoringSafeArea(.bottom)
                .onAppear() {
                    if (UserDefaults.standard.value(forKey: "isChanged") as! Bool == true) {
                        self.verseVM.apply(.onAppear)
                        UserDefaults.standard.set(false, forKey: "isChanged")
                        UserDefaults.standard.synchronize()
                    }
                    self.inline = false
            }
            .navigationBarTitle(Text("\(self.verseVM.bibleName.name) \(self.verseVM.verses.first?.cnum ?? "0")장"), displayMode: inline ? .inline : .automatic)
            .navigationBarItems(trailing:
                HStack(spacing: 20) {
                    NavigationLink(destination: BibleListView()) {
                        imageView(imageName: "slider.horizontal.3")
                    }
                    imageView(imageName: "arrowtriangle.left")
                        .onTapGesture {
                            if (Int(self.verseVM.verses.first!.cnum)! - 1 != 0) {
                                let minus = Int(self.verseVM.verses.first!.cnum)! - 1
                                UserDefaults.standard.set("\(minus)", forKey: "cnum")
                                UserDefaults.standard.synchronize()
                                self.verseVM.apply(.onAppear)
                            }
                    }
                    imageView(imageName: "arrowtriangle.right")
                        .onTapGesture {
                            if (Int(self.verseVM.verses.first!.cnum)! + 1 != self.verseVM.bibleName.chapterCount + 1) {
                                let plus = Int(self.verseVM.verses.first!.cnum)! + 1
                                UserDefaults.standard.set("\(plus)", forKey: "cnum")
                                UserDefaults.standard.synchronize()
                                self.verseVM.apply(.onAppear)
                            }
                    }
            })
        }.accentColor(.black)
        
    }
    
}

struct currentVerseView_Previews: PreviewProvider {
    static var previews: some View {
        VerseView()
    }
}

struct imageView : View {
    let imageName: String
    var body: some View {
        Image(systemName: "\(imageName)")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.black)
    }
}

struct barView: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
            Text(text)
                .foregroundColor(.black)
        }
    }
}
