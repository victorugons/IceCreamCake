import Alamofire

class StoreListService: StoreListServiceProtocol {
    
    func fetchStores(completion: @escaping (Result<[Store], Error>) -> Void) {
        let request = AF.request(Constants.storeListURL)
        
        request.responseDecodable(of: [Store].self) { response in
            switch response.result {
            case .success(let storeList):
                completion(.success(storeList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchBanners(completion: @escaping (Result<[Banner], Error>) -> Void) {
        let request = AF.request(Constants.bannerListURL)
        
        request.responseDecodable(of: [Banner].self) { response in
            switch response.result {
            case .success(let banners):
                completion(.success(banners))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
