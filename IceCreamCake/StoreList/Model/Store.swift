struct Store: Codable {
    let id: Int
    let name: String
    let storeType: [String]
    let category: String
    let rating: String
    
    init(id: Int, name: String, storeType: [String], category: String, rating: String) {
        self.id = id
        self.name = name
        self.storeType = storeType
        self.category = category
        self.rating = rating
    }
}
