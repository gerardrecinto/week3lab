//
//  GithubRepo.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

private let reposUrl = "https://api.github.com/search/repositories"
private let clientId: String? = nil
private let clientSecret: String? = nil

// Model class that represents a GitHub repository
class GithubRepo: CustomStringConvertible {

    var name: String?
    var ownerHandle: String?
    var ownerAvatarURL: String?
    var stars: Int?
    var forks: Int?
    var repoDescription: String?

    // Initializes a GitHubRepo from a JSON dictionary
    init(jsonResult: NSDictionary) {
        if let name = jsonResult["name"] as? String {
            self.name = name
        }

        if let stars = jsonResult["stargazers_count"] as? Int? {
            self.stars = stars
        }

        if let forks = jsonResult["forks_count"] as? Int? {
            self.forks = forks
        }

        if let repoDescription = jsonResult["description"] as? String {
            self.repoDescription = repoDescription
        }

        if let owner = jsonResult["owner"] as? NSDictionary {
            if let ownerHandle = owner["login"] as? String {
                self.ownerHandle = ownerHandle
            }
            if let ownerAvatarURL = owner["avatar_url"] as? String {
                self.ownerAvatarURL = ownerAvatarURL
            }
        }
    }

    // Actually fetch the list of repositories from the GitHub API.
    // Calls successCallback(...) if the request is successful
    class func fetchRepos(_ settings: GithubRepoSearchSettings, successCallback: @escaping ([GithubRepo]) -> (), error: ((Error?) -> ())?) {
        let params = queryParamsWithSettings(settings)
        var components = URLComponents(string: reposUrl)!
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = components.url else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, requestError in
            if let requestError = requestError {
                DispatchQueue.main.async { error?(requestError) }
                return
            }
            guard let data = data,
                  let response = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = response["items"] as? [NSDictionary] else {
                DispatchQueue.main.async { error?(nil) }
                return
            }
            let repos = results.map { GithubRepo(jsonResult: $0) }
            DispatchQueue.main.async { successCallback(repos) }
        }
        task.resume()
    }

    // Helper method that constructs a dictionary of the query parameters used in the request to the
    // GitHub API
    fileprivate class func queryParamsWithSettings(_ settings: GithubRepoSearchSettings) -> [String: String] {
        var params: [String:String] = [:]
        if let clientId = clientId {
            params["client_id"] = clientId
        }

        if let clientSecret = clientSecret {
            params["client_secret"] = clientSecret
        }

        var q = ""
        if let searchString = settings.searchString {
            q = q + searchString
        }
        q = q + " stars:>\(settings.minStars)"
        params["q"] = q

        params["sort"] = "stars"
        params["order"] = "desc"

        return params
    }

    // Creates a text representation of a GitHub repo
    var description: String {
        return "[Name: \(name ?? "")]" +
            "\n\t[Stars: \(stars ?? 0)]" +
            "\n\t[Forks: \(forks ?? 0)]" +
            "\n\t[Owner: \(ownerHandle ?? "")]" +
            "\n\t[Avatar: \(ownerAvatarURL ?? "")]" +
            "\n\t[Description: \(repoDescription ?? "")]"
    }
}
