//
//  AddBook.swift
//  LibraryBooks
//
//  Created by Angelos Staboulis on 3/12/23.
//

import SwiftUI

struct AddBook: View {
    @State var book:BookModel
    @Environment(\.managedObjectContext) var viewContext
    @State var selectedMenu:String
    var body: some View {
        ScrollView{
            HStack{
                Text("Title:")
                TextField("Enter Title of Book", text: $book.title)
            }.frame(maxWidth:.infinity,alignment:.leading)
            .padding(30)
            Spacer()
            HStack{
                Text("Author:")
                TextField("Enter Author of Book", text: $book.author)
            }.frame(maxWidth:.infinity,alignment:.leading)
            .padding(30)
            Spacer()
            HStack{
                Text("Publication Date")
                TextField("Enter Publication Date",text:$book.pubDate)
            }.frame(maxWidth:.infinity,alignment:.leading)
            .padding(30)
            Spacer()
            HStack{
                Text("ISBN of Book")
                TextField("Enter ISBN of Book",text:$book.isbn)
            }.frame(maxWidth:.infinity,alignment:.leading)
            .padding(30)
            Spacer()
            Button(action: {
                saveBook()
            }, label: {
                Text("Save Record")
            })
        }
    }
    func saveBook(){
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
}


