//
//  HW4_Design_Twitter.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 22.09.2022.
//

import Foundation

//355. Design Twitter
//Medium

//Design a simplified version of Twitter where users can post tweets, follow/unfollow another user, and is able to see the 10 most recent tweets in the user's news feed.
//
//Implement the Twitter class:
//
//Twitter() Initializes your twitter object.
//void postTweet(int userId, int tweetId) Composes a new tweet with ID tweetId by the user userId. Each call to this function will be made with a unique tweetId.
//List<Integer> getNewsFeed(int userId) Retrieves the 10 most recent tweet IDs in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user themself. Tweets must be ordered from most recent to least recent.
//void follow(int followerId, int followeeId) The user with ID followerId started following the user with ID followeeId.
//void unfollow(int followerId, int followeeId) The user with ID followerId started unfollowing the user with ID followeeId.
//
//
//Example 1:
//
//Input
//["Twitter", "postTweet", "getNewsFeed", "follow", "postTweet", "getNewsFeed", "unfollow", "getNewsFeed"]
//[[], [1, 5], [1], [1, 2], [2, 6], [1], [1, 2], [1]]
//Output
//[null, null, [5], null, null, [6, 5], null, [5]]
//
//Explanation
//Twitter twitter = new Twitter();
//twitter.postTweet(1, 5); // User 1 posts a new tweet (id = 5).
//twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5]. return [5]
//twitter.follow(1, 2);    // User 1 follows user 2.
//twitter.postTweet(2, 6); // User 2 posts a new tweet (id = 6).
//twitter.getNewsFeed(1);  // User 1's news feed should return a list with 2 tweet ids -> [6, 5]. Tweet id 6 should precede tweet id 5 because it is posted after tweet id 5.
//twitter.unfollow(1, 2);  // User 1 unfollows user 2.
//twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5], since user 1 is no longer following user 2.
//
//
//Constraints:
//
//1 <= userId, followerId, followeeId <= 500
//0 <= tweetId <= 104
//All the tweets have unique IDs.
//At most 3 * 104 calls will be made to postTweet, getNewsFeed, follow, and unfollow.

enum CommandType {
    case Twitter
    case postTweet(userId: Int, tweetId: Int)
    case getNewsFeed(userId: Int)
    case follow(userId: Int, followingId: Int)
    case unfollow(userId: Int, followingId: Int)
    

}

extension String {
    func setCommand(_ str: String, data: [Int]) -> CommandType {
        switch self {
        case "Twitter":
            return .Twitter
        case "postTweet":
            return .postTweet(userId: data[0], tweetId: data[1])
        case "getNewsFeed":
            return .getNewsFeed(userId: data[0])
        case "follow":
            return .follow(userId: data[0], followingId: data[1])
        case "unfollow":
            return .unfollow(userId: data[0], followingId: data[1])
        default:
            fatalError("unrecognized command")
        }
    }
}

class Twitter {
    
    var followersData: [Int: Set<Int>] = [:]
    var postsData: [Int: Set<Int>] = [:]
    
    init() { }
    
    func postTweet(_ userId: Int, _ tweetId: Int) {
        if let _ = postsData[userId] {
            postsData[userId]?.insert(tweetId)
        } else {
            postsData[userId] = [tweetId]
        }
    }
    
    func getNewsFeed(_ userId: Int) -> [Int] {
        var userPosts = postsData[userId] ?? []
        let followees = followersData[userId] ?? []
        
        for f in followees {
            userPosts = userPosts.union(postsData[f] ?? [])
        }
        
        let latastNews = userPosts.sorted { $0 > $1 }
        if userPosts.count > 20 {
            return userPosts.dropFirst(userPosts.count - 10).map { $0 }
        } else {
            return Array(userPosts)
        }
    }
    
    func follow(_ followerId: Int, _ followeeId: Int) {
        if let _ = followersData[followerId] {
            followersData[followerId]?.insert(followeeId)
        } else {
            followersData[followerId] = [followeeId]
        }
    }
    
    func unfollow(_ followerId: Int, _ followeeId: Int) {
            followersData[followerId]?.remove(followeeId)
    }
}

extension Twitter {
    
    //    Input
//["Twitter", "postTweet", "getNewsFeed", "follow", "postTweet", "getNewsFeed", "unfollow", "getNewsFeed"]
//[[], [1, 5], [1], [1, 2], [2, 6], [1], [1, 2], [1]]
    //    Output
    //    [null, null, [5], null, null, [6, 5], null, [5]]
    
    func start() {
        
        let commands: [CommandType] =
        [
            .Twitter,
            .postTweet(userId: 1, tweetId: 5),
            .getNewsFeed(userId: 1),
            .follow(userId: 1, followingId: 2),
            .postTweet(userId: 2, tweetId: 6),
            .getNewsFeed(userId: 1),
            .unfollow(userId: 1, followingId: 2),
            .getNewsFeed(userId: 1)
        ]
        
        for command in commands {
            switch command {
            case .Twitter:
                print("init")
            case .postTweet(let userId, let tweetId):
                postTweet(userId, tweetId)
            case .getNewsFeed(let userId):
                print(getNewsFeed(userId))
            case .follow(let userId, let followingId):
                follow(userId, followingId)
            case .unfollow(let userId, let followingId):
                unfollow(userId, followingId)
            }
        }
    }
}
