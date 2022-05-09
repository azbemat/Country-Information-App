//
//  FavouriteViewController.swift
//

import UIKit
import CoreData

class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Variables and Outlets
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var favouritesList:[Favourite] = []
        
    @IBOutlet weak var tableVIewFavourite: UITableView!
    
    // Table View functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableVIewFavourite.dequeueReusableCell(withIdentifier: "myFavouriteCell", for: indexPath)
        
        // get the current favourite
        let currFavourite = self.favouritesList[indexPath.row]
        
        cell.textLabel?.text = currFavourite.name
        cell.detailTextLabel?.text = "Population: \(String(currFavourite.population))"
        
        // If population is greater than Canada
        if(currFavourite.population > 38005238){
            cell.backgroundColor = UIColor.yellow
            
            
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Find the country that user want to delete
            let find:String = favouritesList[indexPath.row].name!
            
            let request_:NSFetchRequest<Favourite> = Favourite.fetchRequest()

            request_.predicate = NSPredicate(format: "name == %@", find)
            
            
            do{
                let results:[Favourite] = try self.context.fetch(request_)
                
                let deleteCountry = results.first
                
                // Delete country from database
                self.context.delete(deleteCountry!)
                
                // Save context
                try self.context.save()
                
                // Delete from list
                favouritesList.remove(at: indexPath.row)
                
                // Reload table
                self.tableVIewFavourite.reloadData()
                
            }catch{
                print("Error while deleting country from favourite list")
            }
            
        }
    }

    // Lifecycle function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableVIewFavourite.delegate = self
        self.tableVIewFavourite.dataSource = self
        
        getFavouriteList()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getFavouriteList()
        self.tableVIewFavourite.reloadData()
    }

    // Get the favourite list from storage
    
    func getFavouriteList(){
        
        let request:NSFetchRequest<Favourite> = Favourite.fetchRequest()
        
        do{
            favouritesList = try self.context.fetch(request)
            print("Number of result: \(favouritesList.count)")
        }catch{
            print("Error while fetching")
        }
    }
}
