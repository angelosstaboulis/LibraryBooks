//
//  FindBook.swift
//  LibraryBooks
//
//  Created by Angelos Staboulis on 4/12/23.
//

import SwiftUI
import CoreData
struct FindBook: View {
    @Environment(\.managedObjectContext) var viewContext
    var booksArray = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
    @State var newBookArray:[NSFetchRequestResult] = []
    @State var findBook:String
    @State var newBook:BookModel

    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("Find Book:")
                    TextField("Enter ISBN of Book", text: $findBook)
                    Button(action: {
                        search()
                    }, label: {
                        Text("Search Record")
                    })
                }.frame(maxWidth:.infinity,alignment:.leading)
                .padding(30)
                Spacer()
                HStack{
                    Text("Title:")
                    TextField("Enter Title of Book", text: ($newBook.title))
                }.frame(maxWidth:.infinity,alignment:.leading)
                .padding(30)
                Spacer()
                HStack{
                    Text("Author:")
                    TextField("Enter Author of Book", text: $newBook.author)
                }.frame(maxWidth:.infinity,alignment:.leading)
                .padding(30)
                Spacer()
                HStack{
                    Text("Publication Date")
                    TextField("Enter Publication Date",text:$newBook.pubDate)
                }.frame(maxWidth:.infinity,alignment:.leading)
                .padding(30)
                Spacer()
                HStack{
                    Text("ISBN of Book")
                    TextField("Enter ISBN of Book",text:$newBook.isbn)
                }.frame(maxWidth:.infinity,alignment:.leading)
                .padding(30)
            }
        }
    }
    func search(){
        do{
            self.newBookArray = try viewContext.fetch(booksArray)
            for book in newBookArray {
                var tempbook = book as! Book
                if tempbook.isbn!.elementsEqual(findBook){
                    newBook.title = tempbook.title!
                    newBook.isbn = tempbook.isbn!
                    newBook.pubDate = tempbook.pubDate!
                    newBook.author = tempbook.author!
                    break
                }
               
            }
        }catch{
            debugPrint("something went wrong!!")
        }
    }
}

