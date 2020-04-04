import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    let postStream: Post
    let details: Details
    let title : String
    let id: Int
    let postsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postStream = "post_stream"
        case details
        case title
        case id
        case postsCount = "posts_count"
    }
}
struct Details: Codable {

    let canDelete: Bool? 
    
    
    enum CodingKeys: String, CodingKey {
        case canDelete = "can_delete"
        
    }
}

struct Post: Codable{
    let posts: [Detail]
    
}

struct Detail: Codable{
    let topicId: Int
    let postNumber: Int
    let cooked: String
    let userDeleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case postNumber = "post_number"
        case topicId = "topic_id"
        case cooked
        case userDeleted = "user_deleted"
        
    }
}

