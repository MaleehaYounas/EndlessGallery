

class RandomPhotosViewModel: BaseViewModel<[Photo]> {
    var photos: [Photo] {
        data ?? []
    }
    
    func fetchPhotos(page:Int = 1) {
        fetch(from: .randomPhotos(page: page))
    }
}

