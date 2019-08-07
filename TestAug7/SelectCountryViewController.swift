//
//  SelectCountryViewController.swift
//  TravelAssist
//
//  Created by Murali Mantravadi on 10/5/17.
//  Copyright © 2017 SamaraTech LLC. All rights reserved.
//

import UIKit
import CountryPicker

class SelectCountryViewController: UIViewController {
    weak var DelegateSelect: UpdateCountryList!
    @IBOutlet weak var tvCountries: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries: [Country] = [Country]()
    var filteredCountries: [Country] = [Country]()
    
    var textCountry: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.countries = CountryPicker.countryNamesByCode()
    }
    @IBAction func backBtnClicked(){
        self.dismiss(animated: true) {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadCountries()
    }
    
    func loadCountries() {
        self.filteredCountries.removeAll()
        let keyword = self.searchBar.text?.lowercased()
        for index in 0..<self.countries.count {
            let country = self.countries[index]
            if keyword == "" {
                self.filteredCountries.append(country)
                continue
            }
            let countryName = country.name?.lowercased()
            let countryCode = country.code
            let countryPhoneCode = country.phoneCode
            if countryName?.range(of:keyword!) != nil {
                self.filteredCountries.append(country)
            } else if countryCode?.range(of:keyword!) != nil {
                self.filteredCountries.append(country)
            } else if countryPhoneCode?.range(of:keyword!) != nil {
                self.filteredCountries.append(country)
            }
        }
        
        self.tvCountries.reloadData()
    }

}

extension SelectCountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "CountryCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CountryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let country = self.filteredCountries[indexPath.row]
      //  Change
      //  cell.ivCountryFlag.image = country.flag!
        cell.lblCountryName.text = country.name
        
        cell.accessoryType = .none
        cell.selectionStyle = .none
        cell.ivCountryFlag.image = country.flag
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = self.filteredCountries[indexPath.row]
        if self.textCountry != nil {
            self.textCountry?.text = country.name
            DelegateSelect.updateCountrySelection(countryname: country.name ?? "")
            self.dismiss(animated: true) {
                
            }
            //self.navigationController?.popViewController(animated: false)
        }
    }
}

extension SelectCountryViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.loadCountries()
    }
}

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivCountryFlag: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
