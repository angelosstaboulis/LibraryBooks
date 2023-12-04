//
//  DBHelper.swift
//  LibraryBooks
//
//  Created by Angelos Staboulis on 4/12/23.
//

import Foundation
import CoreData
class DBHelper{
    static let shared = DBHelper()
    private init(){}
    func getDB()->NSFetchRequest<NSFetchRequestResult>{
        let booksArray = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        return booksArray
    }
    func fetchValues(viewContext:NSManagedObjectContext) -> [NSFetchRequestResult]{
        var results:[NSFetchRequestResult] = []
        do{
            results =  try viewContext.fetch(getDB())
        }catch{
            debugPrint("something went wrong!!!")
        }
        return results
    }
    func saveBook(book:BookModel,viewContext:NSManagedObjectContext){
        do{
            let item = Book(context: viewContext)
            item.title = book.title
            item.isbn = book.isbn
            item.author = book.author
            item.pubDate = book.pubDate
            try viewContext.save()
        }catch{
            debugPrint("something went wrong!!!")
        }
    }
    func search(findBook:String,viewContext:NSManagedObjectContext)->BookModel{
        var newBookArray:[NSFetchRequestResult] = []
        var newBookModel:BookModel! = .init(id: .init(), title: "", author: "", isbn: "", pubDate: "")
        do{
            newBookArray = try viewContext.fetch(getDB())
            for book in newBookArray {
                let tempbook = book as! Book
                if tempbook.isbn!.elementsEqual(findBook){
                    newBookModel.title = tempbook.title!
                    newBookModel.isbn = tempbook.isbn!
                    newBookModel.pubDate = tempbook.pubDate!
                    newBookModel.author = tempbook.author!
                    break
                }
               
            }
        }catch{
            debugPrint("something went wrong!!")
        }
        return newBookModel
    }
    func deleteRecord(findBook:String,viewContext:NSManagedObjectContext){
        let objects = fetchValues(viewContext: viewContext)
        for book in objects {
            let tempbook = book as! Book
            if tempbook.isbn!.elementsEqual(findBook){
                viewContext.delete(tempbook)
                break
            }
        }
    }
    func editRecord(newBook:BookModel,findBook:String,viewContext:NSManagedObjectContext){
        do{
            let objects = fetchValues(viewContext: viewContext)
            for book in objects {
                let tempbook = book as! Book
                if tempbook.isbn!.elementsEqual(findBook){
                    let newObjectBook = tempbook as NSManagedObject
                    newObjectBook.setValue(newBook.title, forKey: "title")
                    newObjectBook.setValue(newBook.isbn, forKey: "isbn")
                    newObjectBook.setValue(newBook.author, forKey: "author")
                    newObjectBook.setValue(newBook.pubDate, forKey: "pubDate")
                    try viewContext.save()
                    break
                }
               
            }
        }catch{
            debugPrint("something went wrong!!!!")
        }
    }
}
