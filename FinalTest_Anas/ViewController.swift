//
//  ViewController.swift
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Variables and Outlets
      
    var countryList:[Country] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    // Table View functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // get the current country
        let currCountry = self.countryList[indexPath.row]
        
        cell.textLabel?.text = currCountry.name

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print(countryList[indexPath.row])
        
        guard let detailScreen = storyboard?.instantiateViewController(withIdentifier: "ScreenDetails") as? DetailsViewController else{
            print("Cannot find details screen")
            return
        }
        
        // send country object to details screen
        detailScreen.receivedCountry = countryList[indexPath.row]

        self.navigationController?.pushViewController(detailScreen, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getCountryList()
    }

    // Get the country list from the api
    
    func getCountryList(){
        
        let apiEndpoint = "https://restcountries.com/v2/all"
        
        guard let apiURL = URL(string: apiEndpoint) else{
            print("Could not convert the string endpoint to an URL oject")
            return
        }
        
        // fetch the data
        URLSession.shared.dataTask(with: apiURL){ (data, response, error) in
            
            if let err = error{
                print("Error occured while fetching data from api")
                print(err)
                return
            }
             
            if let jsonData = data{
                
                print(jsonData)
                
                do{
                    let decoder = JSONDecoder()
                    let decodedItem:[Country] = try decoder.decode([Country].self, from: jsonData)
                    
                    print(decodedItem.count)

                    self.countryList = decodedItem
                }
                catch let error{
                    print("An error occured during JSON decoding")
                    print(error)
                }
                self.tableView.reloadData()

            }
            
        }.resume()
        
    }
    
}

