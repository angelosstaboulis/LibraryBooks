//
//  EditBook.swift
//  LibraryBooks
//
//  Created by Angelos Staboulis on 4/12/23.
//

import SwiftUI
import CoreData
struct EditBook: View {
    @Environment(\.managedObjectContext) var viewContext
    var booksArray = NSFetchRequest<NSFetchRequestResult>(entityName:"Book")
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
                        editRecord()
                    }, label: {
                        Text("Edit Record")
                    })
                }.padding(30)
            }
        }
    }
    func editRecord(){
        do{
            let objects = self.newBookArray as? [NSManagedObject]
            for book in objects! {
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
    func search(){
        do{
            self.newBookArray = try viewContext.fetch(booksArray)
            for book in newBookArray {
                let tempbook = book as! Book
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

#Preview {
    EditBook(findBook: "", newBook: .init(id: .init(), title: "", author: "", isbn: "", pubDate: ""))
}
