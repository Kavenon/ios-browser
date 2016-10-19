//
//  ViewController.swift
//  iosbrowser-swift
//
//  Created by Użytkownik Gość on 13.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var navLabel: UILabel!
    
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var newButton: UIButton!
    @IBOutlet var stepper: UIStepper!
    
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var artistInput: UITextField!
    @IBOutlet var titleInput: UITextField!
    @IBOutlet var genreInput: UITextField!
    @IBOutlet var yearInput: UITextField!
    
    @IBAction func stepperAction(sender: AnyObject) {
        if(stepper.value > 5.0){
            stepper.value = 5.0;
        }
        else if(stepper.value < 0.0){
            stepper.value = 0.0;
        }
        self.ratingLabel.text = "\(Int(stepper.value))";
        print(stepper.value);
    }
    
    @IBAction func previousButtonAction(sender: AnyObject) {
        
        if(self.currentIndex > 1){
            self.currentIndex--;
            self.editNthElement(self.currentIndex);
            if(self.currentIndex == 1){
                self.previousButton.enabled = false;
            }
        }
        
    }
    
    @IBAction func saveButtonAction(sender: AnyObject) {
        
        if(self.newElementCreating){
            
        }
        else {
            var album = self.albums![self.currentIndex] as! NSDictionary;
            album.setValue(self.ratingLabel.text!, "rating");
            album["artist"] = self.artistInput.text;
            album["title"] = self.titleInput.text;
            album["genre"] = self.genreInput.text;
            album["date"] = self.yearInput.text?.intValue;
        }
        
    }
    
    @IBAction func nextButtonAction(sender: AnyObject) {
        
        self.currentIndex++;
        if(self.albums?.count < self.currentIndex){
            self.newElement();
        }
        else {
            self.editNthElement(self.currentIndex);
            self.previousButton.enabled = true;
        }
                
    }
    @IBAction func deleteAction(sender: AnyObject) {
          print("delete");
    }
    
   
    
    @IBAction func newButtonAction(sender: AnyObject) {
        self.newButton.enabled = false;
        newElement();
    }
    
    let plistCatPath = NSBundle.mainBundle().pathForResource("albums", ofType: "plist");
    
    var albums: NSArray?
    var currentIndex = 1;
    var newElementCreating = false;
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        albums = NSArray(contentsOfFile:plistCatPath!);

        if(albums!.count > 0){
            self.editNthElement(self.currentIndex);
        }
        
        self.previousButton.enabled = false;
        
        
    }
    
    func newElement(){
        
        self.ratingLabel.text = "";
        self.artistInput.text = "";
        self.titleInput.text = "";
        self.genreInput.text = "";
        self.yearInput.text = "";
        self.stepper.value = 0.0;
        navLabel.text = "New element";
        
        self.deleteButton.enabled = true;
        self.newElementCreating = true;
    }
       
    func editNthElement(index : Int){
        let realIndex = index - 1;
        let album = self.albums![realIndex];
        self.currentIndex = index;
      
        self.ratingLabel.text = album["rating"]??.stringValue;
        self.artistInput.text = album["artist"] as? String;
        self.titleInput.text = album["title"] as? String;
        self.genreInput.text = album["genre"] as? String;
        self.yearInput.text = album["date"]??.stringValue;
        
        self.stepper.value = (album["rating"]??.doubleValue)!;
        
        self.updateNavLabel();
        self.newButton.enabled = true;
        self.deleteButton.enabled = true;
        self.newElementCreating = false;
    }
    
    func updateNavLabel(){
        navLabel.text = "Record \(self.currentIndex) of \(self.albums!.count)";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

