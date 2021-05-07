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

import UIKit

class DetailViewController: UITableViewController {
    var animalDetail: AnimalStructure

    
    @IBOutlet var readMeButton: UIButton!
    @IBOutlet var idNumberLabel: UILabel!
    @IBOutlet var cageNumberLabel: UILabel!
    @IBOutlet var animalNameLabel: UILabel!
    
    @IBOutlet var hatchDateLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var sexLabel: UILabel!
    @IBOutlet var poultryTypeLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var reviewTextView: UITextView!
    
    @IBAction func toggleReadMe() {
        animalDetail.toDo.toggle()
        let image = animalDetail.toDo
            ? LibrarySymbol.bookmarkFill.image
            : LibrarySymbol.bookmark.image
        readMeButton.setImage(image, for: .normal)
    }
    
    @IBAction func saveChanges() {
        AnimalDataArray.update(book: animalDetail)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
            ? .camera
            : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    /*
     let idNumber: String
     let cageNumber: String
     let animalName: String
     let hatchDate: String
     let weight: String
     let sex: String
     let poultryType: String
     let age: String
     
     var review: String?
     var toDo: Bool
     
     var image: UIImage?
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = animalDetail.image ?? LibrarySymbol.letterSquare(letter: animalDetail.idNumber.first).image
        imageView.layer.cornerRadius = 16
        idNumberLabel.text = animalDetail.idNumber
        cageNumberLabel.text = animalDetail.cageNumber
        animalNameLabel.text = animalDetail.animalName
        hatchDateLabel.text = animalDetail.hatchDate
        weightLabel.text = animalDetail.weight
        sexLabel.text = animalDetail.sex
        poultryTypeLabel.text = animalDetail.poultryType
        ageLabel.text = animalDetail.age
        
        if let review = animalDetail.review {
            reviewTextView.text = review
        }
        
        let image = animalDetail.toDo
            ? LibrarySymbol.bookmarkFill.image
            : LibrarySymbol.bookmark.image
        readMeButton.setImage(image, for: .normal)
        
        reviewTextView.addDoneButton()
    }
    
    required init?(coder: NSCoder) { fatalError("This should never be called!") }
    
    init?(coder: NSCoder, book: AnimalStructure) {
        self.animalDetail = book
        super.init(coder: coder)
    }
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        imageView.image = selectedImage
        animalDetail.image = selectedImage
        dismiss(animated: true)
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        animalDetail.review = textView.text
    }
}

extension UITextView {
    func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }
}
