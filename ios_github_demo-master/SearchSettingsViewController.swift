//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Gerard Recinto on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SearchSettingsViewController: UIViewController {

    @IBOutlet weak var slideStar: UISlider!
    var settings = GithubRepoSearchSettings()
    weak var delegate: SettingsPresentingViewControllerDelegate?
    var numStars: Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveButtonTapped(_ sender: Any) {
        self.delegate?.didSaveSettings(settings: settings)

    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.delegate?.didCancelSettings()

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
