import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct AddNewTopicResponse: Codable {
    
    let id: Int
    let name: String
    let username: String
    
    
    enum CodingKeys: String, CodingKey{
        case id = "topic_id"
        case username
        case name
    }

}
