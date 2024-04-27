//
//  Created by Aman on 27/07/23.
//

import Foundation

final class postViewModel {
    // ViewModel code here
    var post:[postModel] = []
    var eventHandler:((_ event:Events) -> Void)?
    
    
    func fetchProduct(pages:Int){
        self.eventHandler?(.loading)
        APIHelper.shared.request(
            form: [postModel].self,
            type: EndpointItem.posts(page: pages)) { result in
                self.eventHandler?(.stopLoading)
                switch result{
                case .success(let posts):
                    self.post.append(contentsOf: posts)
                    self.eventHandler?(.dataLoaded)
                case .failure(let err):
                    self.eventHandler?(.error(err))
                }
            }
    }
}
