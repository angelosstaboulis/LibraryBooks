//
//  ListBooks.swift
//  LibraryBooks
//
//  Created by Angelos Staboulis on 3/12/23.
//

import SwiftUI
import CoreData
struct ListBooks: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var selectedMenu:String
    var books = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
    @State var booksArray:[NSFetchRequestResult] = []
    @State var listBooks = [Book]()
    var body: some View {
        VStack{
            List(listBooks){book in
                VStack{
                    Text("Title="+book.title!)
                    Text("Author="+book.author!)
                    Text("ISBN="+book.isbn!)
                    Text("PubDate="+book.pubDate!)
                }
            }
            
        }.onAppear {
            do{
                self.booksArray = try viewContext.fetch(books)
                for book in booksArray{
                    let newBook = book as! Book
                    self.listBooks.append(newBook)
                }
            }catch{
                debugPrint("something went wrong!!!!")
            }
                
        }
    }
}

#Preview {
    ListBooks(selectedMenu: "")
}
