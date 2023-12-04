//
//  BookModel.swift
//  LibraryBooks
//
//  Created by Angelos Staboulis on 3/12/23.
//

import Foundation
struct BookModel:Identifiable{
    var id:UUID
    var title:String
    var author:String
    var isbn:String
    var pubDate:String
}
