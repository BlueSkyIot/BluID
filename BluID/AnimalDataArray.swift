/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

// This was the Library.swift file from the ReadMe Tutorial

import UIKit

// MARK:- Reusable SFSymbol Images

// MARK:- Reusable SFSymbol Images
enum LibrarySymbol {
    case bookmark
    case bookmarkFill
    case book
    case letterSquare(letter: Character?)
    
    var image: UIImage {
        let imageName: String
        switch self {
        case .bookmark, .book:
            imageName = "\(self)"
        case .bookmarkFill:
            imageName = "bookmark.fill"
        case .letterSquare(let letter):
            guard let letter = letter?.lowercased(),
                  let image = UIImage(systemName: "\(letter).square")
            else {
                imageName = "square"
                break
            }
            return image
        }
        return UIImage(systemName: imageName)!
    }
}



// MARK:- Library


enum AnimalDataArray {
    private static let starterData = [
        AnimalStructure(idNumber: "101", cageNumber: "Cage: 1", animalName: "Name1", hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "102", cageNumber: "Cage: 1", animalName: "Name2",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "103", cageNumber: "Cage: 1", animalName: "Name3",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "104", cageNumber: "Cage: 1", animalName: "Name4",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "105", cageNumber: "Cage: 2", animalName: "Name5",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "106", cageNumber: "Cage: 2", animalName: "Name6",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "107", cageNumber: "Cage: 2", animalName: "Name7",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "108", cageNumber: "Cage: 2", animalName: "Name8",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "109", cageNumber: "Cage: 3", animalName: "Name9",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "110", cageNumber: "Cage: 3", animalName: "Name10",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
        AnimalStructure(idNumber: "111", cageNumber: "Cage: 3", animalName: "Name11",hatchDate: "Today", weight: "4 oz", sex: "Male", poultryType: "Quail", age: "6 weeks", toDo: true),
    ]
    
    static var books: [AnimalStructure] = loadBooks()
    
    private static let booksJSONURL = URL(fileURLWithPath: "Books",
                                          relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("json")
    
    
    /// This method loads all existing data from the `booksJSONURL`, if available. If not, it will fall back to using `starterData`
    /// - Returns: Returns an array of books, loaded from a JSON file
    private static func loadBooks() -> [AnimalStructure] {
        let decoder = JSONDecoder()
        
        guard let booksData = try? Data(contentsOf: booksJSONURL) else {
            return starterData
        }
        
        
        do {
            let books = try decoder.decode([AnimalStructure].self, from: booksData)
            return books.map { libraryBook in
                AnimalStructure(
                    idNumber: libraryBook.idNumber,
                    cageNumber: libraryBook.cageNumber,
                    animalName: libraryBook.animalName,
                    hatchDate: libraryBook.hatchDate,
                    weight: libraryBook.weight,
                    sex: libraryBook.sex,
                    poultryType: libraryBook.poultryType,
                    age: libraryBook.age,
                    review: libraryBook.review,
                    toDo: libraryBook.toDo,
                    image: loadImage(forBook: libraryBook)
                )
            }
            
        } catch let error {
            print(error)
            return starterData
        }
    }
    
    private static func saveAllBooks() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: booksJSONURL, options: .atomicWrite)
        } catch let error {
            print(error)
        }
    }
    
    /// Adds a new book to the `books` array and saves it to disk.
    /// - Parameters:
    ///   - book: The book to be added to the library.
    ///   - image: An optional image to associate with the book.
    static func addNew(book: AnimalStructure) {
        if let image = book.image { saveImage(image, forBook: book) }
        books.insert(book, at: 0)
        saveAllBooks()
    }
    
    
    /// Updates the stored value for a single book.
    /// - Parameter book: The book to be updated.
    static func update(book: AnimalStructure) {
        if let newImage = book.image {
            saveImage(newImage, forBook: book)
        }
        
        guard let bookIndex = books.firstIndex(where: { storedBook in
                                                book.idNumber == storedBook.idNumber } )
        else {
            print("No book to update")
            return
        }
        
        books[bookIndex] = book
        saveAllBooks()
    }
    
    /// Removes a book from the `books` array.
    /// - Parameter book: The book to be deleted from the library.
    static func delete(book: AnimalStructure) {
        guard let bookIndex = books.firstIndex(where: { storedBook in
                                                book == storedBook } )
        else { return }
        
        books.remove(at: bookIndex)
        
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.idNumber)
        do {
            try FileManager().removeItem(at: imageURL)
        } catch let error { print(error) }
        
        saveAllBooks()
    }
    
    static func reorderBooks(bookToMove: AnimalStructure, bookAtDestination: AnimalStructure) {
        let destinationIndex = AnimalDataArray.books.firstIndex(of: bookAtDestination) ?? 0
        books.removeAll(where: { $0.idNumber == bookToMove.idNumber })
        books.insert(bookToMove, at: destinationIndex)
        saveAllBooks()
    }
    
    /// Saves an image associated with a given book title.
    /// - Parameters:
    ///   - image: The image to be saved.
    ///   - title: The title of the book associated with the image.
    static func saveImage(_ image: UIImage, forBook book: AnimalStructure) {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.idNumber)
        if let jpgData = image.jpegData(compressionQuality: 0.7) {
            try? jpgData.write(to: imageURL, options: .atomicWrite)
        }
    }
    
    /// Loads and returns an image for a given book title.
    /// - Parameter title: Title of the book you need an image for.
    /// - Returns: The image associated with the given book title.
    static func loadImage(forBook book: AnimalStructure) -> UIImage? {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.idNumber)
        return UIImage(contentsOfFile: imageURL.path)
    }
}

extension FileManager {
    static var documentDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
