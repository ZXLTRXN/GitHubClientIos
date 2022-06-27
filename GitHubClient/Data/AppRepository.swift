//
//  AppRepository.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//

import Foundation

class AppRepository {
    private let api = APIService.shared
    
      func getRepositories(completion: @escaping (Array<Repo>?, Error?) -> Void) {
          // TODO:
      }
      
      func getRepository(repoId: String, completion: @escaping (Repo?, Error?) -> Void) {
         // TODO:
      }
      
      func getRepositoryReadme(ownerName: String, repositoryName: String, branchName: String, completion: @escaping (String?, Error?) -> Void) {
         // TODO:
      }
      
      func signIn(token: String, completion: @escaping (UserInfo?, Error?) -> Void) {
//          api.getUser(token: token).map(to: RepoNetwork.self, completion: {(repoNetwork, error) in
//              repoNetwork?.toRepo()
//              
//          })

          }
      }

      
