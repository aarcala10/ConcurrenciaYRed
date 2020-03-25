import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    let postStream: Post
    
    enum CodingKeys: String, CodingKey {
        case postStream = "post_stream"
    }
}

struct Post: Codable{
    let posts: [Detail]
    
}

struct Detail: Codable{
    let id: Int
    let postNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case postNumber = "post_number"
        case id
        
    }
}

