import Alamofire

class StoreDetailsService: StoreDetailsServiceProtocol {
    func fetchStoreProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let request = AF.request(Constants.productListURL)
        
        request.responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
