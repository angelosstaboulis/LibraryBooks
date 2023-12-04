//
//  DeleteBook.swift
//  LibraryBooks
//
//  Created by Angelos Staboulis on 4/12/23.
//

import SwiftUI
import CoreData
struct DeleteBook: View {
    @Environment(\.managedObjectContext) var viewContext
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
                HStack{
                    Button(action: {
                        deleteRecord()
                    }, label: {
                        Text("Delete Record")
                    })
                }
            }
        }
    }
    func deleteRecord(){
        DBHelper.shared.deleteRecord(findBook: findBook, viewContext: viewContext)
    }
    func search(){
        newBook = DBHelper.shared.search(findBook: findBook, viewContext: viewContext)
    }
}

