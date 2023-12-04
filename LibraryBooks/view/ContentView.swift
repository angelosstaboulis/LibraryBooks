//
//  ContentView.swift
//  LibraryBooks
//
//  Created by Angelos Staboulis on 3/12/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var menuItems  = ["Add Record","Edit Record","Delete Record","Find Record","List Records"]
    @State var selectedMenu:String
    var body: some View {
        NavigationView{
            Color.teal.overlay {
                List($menuItems,id:\.self){item in
                    NavigationLink {
                        if item.wrappedValue == "Add Record"{
                            AddBook(book: .init(id: .init(), title: "", author: "", isbn: "", pubDate: ""), selectedMenu: "")
                        }
                        if item.wrappedValue == "Edit Record"{
                            EditBook(findBook: "", newBook: .init(id: .init(), title: "", author: "", isbn: "", pubDate: ""))
                        }
                        if item.wrappedValue == "Delete Record"{
                            DeleteBook(findBook: "", newBook: .init(id: .init(), title: "", author: "", isbn: "", pubDate: ""))
                        }
                        if item.wrappedValue == "Find Record"{
                            FindBook(findBook: "", newBook: .init(id: .init(), title: "", author: "", isbn: "", pubDate: ""))
                        }
                        if item.wrappedValue == "List Records"{
                            ListBooks(selectedMenu: "")
                        }
                    } label: {
                        Text(String(describing:item.wrappedValue))
                    }
                        
                    
                }.navigationTitle("Library-Books")
                    .navigationBarTitleDisplayMode(.inline)
            }.colorMultiply(Color.teal)
        }.colorMultiply(Color.teal)
    }
}
#Preview {
   ContentView(selectedMenu: "")
}
