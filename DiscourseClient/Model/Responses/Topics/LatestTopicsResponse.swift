import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    let topicList: TopicList
    
    enum CodingKeys: String, CodingKey {
        case topicList = "topic_list"
    }
}
struct TopicList: Codable {
    let topics: [Topic]
}


struct Topic: Codable {
    let id: Int
    let title: String
    let closed: Bool
}
