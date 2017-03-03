//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD


protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}
// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SettingsPresentingViewControllerDelegate {
    internal func didCancelSettings() {
        
    }

    internal func didSaveSettings(settings: GithubRepoSearchSettings) {
        searchSettings.minStars = settings.minStars
        doSearch()
        if searchSettings.minStars != 0 {
            searchSettings.minStars += 1
        }
    }


    
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navControl = segue.destination as? UINavigationController
        let vc = navControl?.topViewController as! SearchSettingsViewController
        vc.settings = self.searchSettings
        vc.numStars = Float(self.searchSettings.minStars)
        vc.delegate = self

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell
        let repo = repos[indexPath.row]
        
        
        let repoURL = URL(string: repo.ownerAvatarURL!)
        cell.avatarImage.setImageWith(repoURL!)
        cell.descriptionLabel.text = repo.repoDescription
        cell.name.text = repo.name
        cell.owner.text = repo.ownerHandle
        cell.star.text = "\(repo.stars)"
        cell.fork.text = "\(repo.forks)"
        cell.forkImage.image = #imageLiteral(resourceName: "fork")
        cell.starImage.image = #imageLiteral(resourceName: "star")
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //data source
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    
        
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        tableView.reloadData()

        // Perform the first search when the view controller first loads
        doSearch()

    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = repos {
            return repos.count
        } else {
            return 0
        }
        //return repos!.count
    }
    
    
    
    // Perform the search.
    fileprivate func doSearch() {

        
        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                //self.repos.append(repo)
                print(repo)
            }
            self.repos = newRepos
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
