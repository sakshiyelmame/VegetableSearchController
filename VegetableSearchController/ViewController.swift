//
//  ViewController.swift
//  VegetableSearchController
//
//  Created by Sakshi Yelmame on 11/04/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var MyUITableView: UITableView!
    @IBOutlet weak var vegUISearchBar: UISearchBar!
    var vegetableList = [Vegetable]()
    var searchVeg = [Vegetable]()
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching
        {
            return searchVeg.count
        }
        else
        {
            return vegetableList.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if searching {
            cell.textLabel?.text = searchVeg[indexPath.row].name
            cell.imageView?.image = UIImage(named: vegetableList[indexPath.row].imagename)
        }else {
            cell.textLabel?.text = vegetableList[indexPath.row].name
            cell.imageView?.image = UIImage(named: vegetableList[indexPath.row].imagename)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: .main)
        let vc = main.instantiateViewController(withIdentifier: "VegetableInfoViewController") as! VegetableInfoViewController
        vc.selectedVegetableInfo = Vegetable(name: vegetableList[indexPath.row].name, imagename: vegetableList[indexPath.row].imagename, description: vegetableList[indexPath.row].description)
        navigationController?.pushViewController(vc, animated: true)
    }
    func fetchData() {
        
        guard let fileLocation = Bundle.main.url(forResource: "Vegetables", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: fileLocation)
            let receivedData = try JSONDecoder().decode([Vegetable].self, from: data)
            //print(receivedData)
            self.vegetableList = receivedData
            DispatchQueue.main.async {
                self.MyUITableView.reloadData()
            }
            
        }
        catch
        {
            print("Error while decoding json")
        }
    }
}
extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searching = true
            searchVeg.removeAll()
            for vegetable in vegetableList {
                if vegetable.name.lowercased().contains(searchText.lowercased()){
                    searchVeg.append(vegetable)
                }
            }
        }
        else
        {
            searching = false
            searchVeg.removeAll()
            searchVeg = vegetableList
        }
        MyUITableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        MyUITableView.reloadData()
    }
}

