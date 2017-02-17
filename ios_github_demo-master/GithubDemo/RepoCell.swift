//
//  RepoCell.swift
//  GithubDemo
//
//  Created by Gerard Recinto on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    @IBOutlet weak var fork: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var star: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var forkImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
