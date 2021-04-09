//
//  ReviewResponse.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 22/02/21.
//

// MARK: - Review
struct ReviewResponse: Codable {
    let id, page: Int
    let results: [Review]
    let totalPages, totalResults: Int
}

// MARK: - Result
struct Review: Codable,Identifiable,Hashable {
    let author, content, id: String
    let url: String
}
