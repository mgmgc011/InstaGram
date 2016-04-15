//
//  AddFriendsViewController.swift
//  GoldenGram
//
//  Created by Dylan Bruschi on 4/14/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import Firebase

class AddFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var users = [User]()
    var filteredUsers = [User]()
    var searchActive: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let usersRef = FIREBASE_REF.childByAppendingPath("users")
        
        usersRef.observeEventType(.Value, withBlock: {
            snapshot in
            let userArray = snapshot.value.allValues as? [NSDictionary]!
            if userArray != nil {
                for dict in userArray! {
                    let aUser = User.init(dict: dict)
                    self.users.append(aUser)
                
                    if self.users.count == userArray!.count {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tableView.reloadData()
                        }
                    }
                }
                }
            })
        }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = users.filter({ (user) -> Bool in
            let tmp: User = user
            let range = (tmp.username as NSString).rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if filteredUsers.count == 0 {
            searchActive = false;
        } else {
            searchActive = true;
        }
        tableView.reloadData()
    }
    
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredUsers.count
        } else {
            
        return users.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)
        if (searchActive) {
            let user = filteredUsers[indexPath.row];
            cell.textLabel?.text = user.username
            cell.detailTextLabel?.text = "\(user.firstName) \(user.lastName)"
        }
        else {
        let user = users[indexPath.row];
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = "\(user.firstName) \(user.lastName)"
        }
        return cell

    }
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let user = users[indexPath!.row] 
        let destVC = segue.destinationViewController as! FriendViewController
        destVC.friendUID = user.userID
    }
    






}
