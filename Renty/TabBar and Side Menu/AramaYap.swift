//
//  AramaYap.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/27/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class AramaYap: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var countryNameArray = [NSDictionary]()
    
    var searchCountryy = [String]()
    
    var searching = false
    var sendtext = ""
 
    
    @IBOutlet weak var viewSearch: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSearchItem()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        searchBar.searchTextField.textColor = .white
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        tableView.separatorColor = .rgb(red: 0, green: 90, blue: 63)

        
        
        viewSearch.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        viewSearch.layer.cornerRadius = 26
        viewSearch.layer.borderColor = UIColor.rgb(red: 201, green: 213, blue: 51).cgColor
        viewSearch.layer.borderWidth = 2
        
        
    }
    
    
    
    
    @IBAction func btnLeft(_ sender: Any) {
        print("left")
        self.dismiss(animated: true, completion: nil)
    }
    
    func getSearchItem() {
        let userID = Auth.auth().currentUser?.uid
        
        
        let userRef = Database.database().reference().child("SearchHistory").child(userID!).queryLimited(toLast: 5)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get search history
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                if value != nil {
                    self.countryNameArray.append(value!)
                }
                self.countryNameArray.reverse()
                self.tableView.reloadData()
                
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    
}

extension AramaYap : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryNameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.textColor = .white
        
        let value2 = self.countryNameArray[indexPath.row]
        
        let word = value2["word"] as? String ?? ""
        cell?.textLabel?.text = word
        return cell!

    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let value2 = countryNameArray[indexPath.row]
       
        let searchword = value2["word"] as? String ?? ""
        
        if searchword != "" {
            
            //database kayit etme
            let searchid = Database.database().reference().child("SearchHistory").childByAutoId().key
            
            var firebasesearchmap = [String : Any]()
            
            let userID = Auth.auth().currentUser?.uid
            
            firebasesearchmap["searchid"] = searchid
            firebasesearchmap["word"] = searchword
            firebasesearchmap["publisher"] = userID
            
            let searchref = Database.database().reference().child("SearchHistory").child(userID!)
            
            searchref.observeSingleEvent(of: .value, with: { (snapshot) in
                // Get search history
                
                for child in snapshot.children {
                    
                    let snap = child as! DataSnapshot //get first snapshot
                    let value = snap.value as? NSDictionary //get second snapshot
                    
                    if value != nil {
                        
                        let word = value!["word"] as? String ?? ""
                        let searchid2 = value!["searchid"] as? String ?? ""
                        
                        //burda eliyim onda  ? he bunun yaxiris zad deilde duzdu ?
                        
                        
                        if word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == searchword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
                            Database.database().reference().child("SearchHistory").child(userID!).child(searchid2).removeValue()
                            
                        }
                        
                    }
                }
                
                
                searchref.child(searchid!).setValue(firebasesearchmap)
                { (err, resp) in
                    guard err == nil else {
                        print("Posting failed : ")
                        return
                    }
                    
                    
                    self.sendtext = searchword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    self.performSegue(withIdentifier: "arama", sender: self)
                    
                    
                }
                
                
                
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}

extension AramaYap : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    }
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" {
        
        //database kayit etme
        let searchid = Database.database().reference().child("SearchHistory").childByAutoId().key
        
        var firebasesearchmap = [String : Any]()
        
        let userID = Auth.auth().currentUser?.uid
        
        firebasesearchmap["searchid"] = searchid
        firebasesearchmap["word"] = searchBar.text
        firebasesearchmap["publisher"] = userID
        
        let searchref = Database.database().reference().child("SearchHistory").child(userID!)
        
        searchref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get search history
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                if value != nil {
                    
                    let word = value!["word"] as? String ?? ""
                    let searchid2 = value!["searchid"] as? String ?? ""
                                        
                    if word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == searchBar.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
                        Database.database().reference().child("SearchHistory").child(userID!).child(searchid2).removeValue()
                        
                    }
                    
                }
            }
            
            
            searchref.child(searchid!).setValue(firebasesearchmap)
            { (err, resp) in
                guard err == nil else {
                    print("Posting failed : ")
                    return
                }
                
                self.sendtext = searchBar.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) as! String
                self.performSegue(withIdentifier: "arama", sender: self)
                
                
            }
            
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
      }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nav = segue.destination as! UINavigationController
        
        let search = nav.topViewController as! Search
        search.btnAramaYap.setTitle(sendtext, for: .normal)
        let keyword = sendtext
        search.searchWord = keyword
    }
    
}

