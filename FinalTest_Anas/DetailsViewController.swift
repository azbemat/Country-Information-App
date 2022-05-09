//
//  DetailsViewController.swift
//

import UIKit
import CoreData


class DetailsViewController: UIViewController {
    
    // Variables and Outlets

    var receivedCountry:Country?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCapital: UILabel!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    @IBOutlet weak var lblError: UILabel!
    
    // Action btn
    
    @IBAction func btnAddFav(_ sender: Any) {
        
        guard let obj = receivedCountry else{
            print("Nil obj is passed")
            return
        }
        
        var name:String? = receivedCountry?.name
        var population:Int32 = Int32(receivedCountry!.population)
        
        // Validate if country is already in the database
        let request_:NSFetchRequest<Favourite> = Favourite.fetchRequest()
        
        request_.predicate = NSPredicate(format: "name == %@", name!)

        var found:[Favourite] = []
        do{
            found = try self.context.fetch(request_)
            print("FOUND: \(found.count)")
        }catch{
            print("Error while fetching")
        }
        
        // Save the country
        // if not on the favourite list
        if(found.count == 0){
            // Save the country

            // Create a Favourite object
            let favourite = Favourite(context: self.context)
            
            // set the properties
            favourite.name = name
            favourite.population = population
            
            // Save to storage
            do{
                try self.context.save()
                print("Favourite saved")
            }catch{
                print("Saved failed")
            }
            
            // Let the User know
            // Ceate an alert box
            let box = UIAlertController(title: "Success", message: "Country is added to your favourite list", preferredStyle: .alert)
            
            // Add button
            box.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // Show the popup
            self.present(box, animated: true)
            
        }else{
            // Already saved
            
            // Let the User know
            // Ceate an alert box
            let box = UIAlertController(title: "Fail", message: "This country is already present in your favourite list", preferredStyle: .alert)
            
            // Add button
            box.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            // Show the popup
            self.present(box, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
        
        if let counObj = receivedCountry {
            
            print(counObj.name)
            print(counObj.population)
            lblName.text = "Country name: \(counObj.name)"
            lblCapital.text = "Capital: \(counObj.capital)"
            lblCountryCode.text = "Country code: \(counObj.countryCode)"
            lblPopulation.text = "Population: \(String(counObj.population))"
            lblError.text = ""
            
        } else {
            
            lblName.text = "Country name: N/A"
            lblCapital.text = "Capital: N/A"
            lblCountryCode.text = "Country code: N/A"
            lblPopulation.text = "Population: N/A"
            lblError.text = "Sorry, no country information found"
            
        }

        
    }

}
