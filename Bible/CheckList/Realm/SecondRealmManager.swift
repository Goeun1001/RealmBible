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

let koreaBibles = ["창세기", "출애굽기", "레위기", "민수기", "신명기", "여호수아", "사사기", "룻기", "사무엘상", "사무엘하", "열왕기상", "열왕기하", "역대상", "역대하", "에스라", "느헤미야", "에스더", "욥기", "시편", "잠언", "전도서", "아가", "이사야", "예레미야", "예레미야 애가", "에스겔", "다니엘", "호세아", "요엘", "아모스", "오바댜", "요나", "미가", "나훔", "하박국", "스바냐", "학개", "스가랴", "말라기", "마태복음", "마가복음", "누가복음", "요한복음", "사도행전", "로마서", "고린도전서", "고린도후서", "갈라디아서", "에베소서", "빌립보서", "골로새서", "데살로니가전서", "데살로니가후서", "디모데전서", "디모데후서", "디도서", "빌레몬서", "히브리서", "야고보서", "베드로전서", "베드로후서", "요한1서", "요한2서", "요한3서", "유다서", "요한계시록"]

let englishBibles = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs", "Ecclesiastes", "Song of Songs", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi", "Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galantians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"]

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
        
        for i in koreaBibles {
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
