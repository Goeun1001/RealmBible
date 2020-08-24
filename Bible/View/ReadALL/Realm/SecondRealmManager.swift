//
//  RealmManager .swift
//  BibleCheckList
//
//  Created by eunjin Jo on 05/11/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//
//https://medium.com/@riccione83/easy-use-of-realm-in-swift-444f41a5742d
import Foundation
import RealmSwift

class SecondRealmManager {
    
    static let shared = SecondRealmManager()
    
    private init(){
        if !getAllBooks().isEmpty { return }
        let bible = Bible.getBibleInfoFromFile()
        bible.forEach{ addBook($0) }
    }
    
    private func addBook(_ bookTuple: BookTuple){
        
        //db에 추가
        let book = Book()
        book.title = bookTuple.title
        
        for i in 1...bookTuple.numOfpages{
            let pageObject = PageObject(pageNumber: String(i))
            book.pageList.append(pageObject)
        }

        book.category = bookTuple.category.rawValue
        
        if book.title == "잠언" || book.title == "시편" {
            book.isDaily = true
        }
        
        book.add()
    }
    
    
    func getAllBooks()->[Book]{
        
        var bookList:[Book] = []
        
        do {
            let realm = try Realm()
            let results = realm.objects(Book.self)
            //Results<Book> 타입
            bookList = results.map{$0}
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return bookList
    }
    
    func getBooksOfCategory(category: String)->[Book]{
        
        var bookList:[Book] = []
        
        do {
            let realm = try Realm()
            let books = realm.objects(Book.self).filter{$0.category == category}
            bookList = books.map{$0}
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return bookList
        
    }
    
    
    func getBook(title:String)->Book?{
        
        do{
            let realm = try Realm()
            let book = realm.objects(Book.self).filter{$0.title == title}.first
            return book
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func changeIsReadOfPage(title:String, pageNumber:String, isRead:Bool){
        
        do{
            let realm = try Realm()
            let book = realm.objects(Book.self).filter{$0.title == title}.first
            try realm.write {
                let page = book?.pageList.filter{$0.pageNumber == pageNumber}.first
                page?.isRead = isRead
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func changeAllRead(title:String,isRead:Bool){
        do{
            let realm = try Realm()
            let book = realm.objects(Book.self).filter{$0.title == title}.first
            try realm.write {

                if let pageList = book?.pageList{
                    for page in pageList{
                        page.isRead = isRead
                    }
                }
                
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func changeAllDelete(isRead:Bool){
        var title = ["창세기", "출애굽기", "레위기", "민수기", "신명기", "여호수아서", "사사기", "룻기", "사무엘상", "사무엘하", "열왕기상", "열왕기하", "역대기상", "역대기하", "에스라서", "느헤미아서", "에스더서", "욥기", "시편", "잠언", "전도서", "아가", "이사야서", "예레미야서", "예레미야애가", "에스겔서", "다니엘서", "호세아서", "요엘서", "아모스서", "오바다서", "요나서", "미가", "나훔서", "하박국서", "스바냐서", "학개서", "스가랴서", "말라기", "마태복음", "마가복음", "누가복음", "요한복음", "사도행전", "로마서", "고린도전서", "고린도후서", "갈라디아서", "에베소서", "빌립보서", "골로새서", "데살로니가전서", "데살로니가후서", "디모데전서", "디모데후서", "디도서", "빌레몬서", "히브리서", "야고보서", "베드로전서", "베드로후서", "요한1서", "요한2서", "요한3서", "유다서", "요한계시록"]
        for i in title {
            do{
                let realm = try Realm()
                let book = realm.objects(Book.self).filter{$0.title == i}.first
                try realm.write {

                    if let pageList = book?.pageList{
                        for page in pageList{
                            page.isRead = isRead
                        }
                    }
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func changeDaily(title: String, isDaily: Bool) {
        do{
            let realm = try Realm()
            let book = realm.objects(Book.self).filter{$0.title == title}.first
            try realm.write {
                book?.isDaily = isDaily
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
