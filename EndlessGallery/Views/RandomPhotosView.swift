import SwiftUI

struct RandomPhotosView: View {
    @StateObject private var viewModel = RandomPhotosViewModel()
    @State private var currentPage: Int = 1
    @State private var singleColumn:Bool = true
    var body: some View {
        GeometryReader { geometry in
        NavigationView {
                VStack {
                    toggleButton
                    randomPhotosBody(geometry:geometry)
                    PaginationBottomBar
                }
                .navigationTitle("Gallery")
                .onAppear {
                    if viewModel.photos.isEmpty {
                        viewModel.fetchPhotos(page: currentPage)
                    }
                }
            }
        }
    }
    
    private func randomPhotosBody(geometry: GeometryProxy) -> some View{
        Group{
        if viewModel.isLoading {
                progressView
            } else if let error = viewModel.errorMessage {
                errorText(error:error)
            } else {
                ScrollView {
                    if singleColumn{
                        singleColumnView(width: geometry.size.width*0.97, height: geometry.size.height*0.40)
                    }
                    else{
                        let columns = [
                           GridItem(.flexible(), spacing: 12),
                           GridItem(.flexible(), spacing: 12)
                       ]
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(viewModel.photos.indices, id: \.self) { index in
                                let photo = viewModel.photos[index]
                                gridItem(
                                    photo: photo,
                                    width: (geometry.size.width / 2) - 20,
                                    height: geometry.size.height * 0.30
                                )
                                .onAppear {
                                    if index == viewModel.photos.count - 1 {
                                        currentPage += 1
                                        viewModel.fetchPhotos(page: currentPage)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .refreshable {
                    currentPage = 1
                    viewModel.fetchPhotos(page: currentPage)
                }
            }
        }
    }
    
    
    
    
    private var toggleButton: some View {
        Toggle("Single Column", isOn: $singleColumn)
            .padding(.horizontal)
    }
    private var progressView:some View{
        ProgressView("Loading photos...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    private func errorText(error:String) -> some View {
        VStack {
            Text("Error: \(error)")
                .foregroundColor(.red)
                .padding()
            Button("Retry") {
                viewModel.fetchPhotos(page: currentPage)
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    private func singleColumnView(width: Double, height:Double)->some View{
            LazyVStack {
                ForEach(viewModel.photos.indices, id: \.self) { index in
                    let photo = viewModel.photos[index]
                    AsyncImage(url: URL(string: photo.urls.small)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, minHeight: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: width, height: height)
                                .clipped()
                                .cornerRadius(12)
                                .shadow(radius: 5)
                                .padding(.vertical, 2)
                        case .failure:
                            ZStack {
                                Rectangle().fill(Color.gray.opacity(0.2))
                                VStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.red)
                                    Text("Image not available")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .frame(width: width, height: height)
                            .cornerRadius(12)
                            .shadow(radius: 5)

                        @unknown default:
                            EmptyView()
                        }
                    }
                    .onAppear {
                        if index == viewModel.photos.count - 1 {
                            currentPage += 1
                            viewModel.fetchPhotos(page: currentPage)
                        }
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private func gridItem(photo: Photo, width: CGFloat, height: CGFloat) -> some View {
        AsyncImage(url: URL(string: photo.urls.small)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 5)

            case .failure:
                ContentUnavailableView(
                    "Image not available",
                    image: "exclamationmark.triangle.fill"
                )
                .frame(width: width, height: height)
                .cornerRadius(12)
                .shadow(radius: 5)

            @unknown default:
                EmptyView()
            }
        }
    }
    private var previousPageButton: some View {
        Button {
            if currentPage > 1 {
                currentPage -= 1
                viewModel.fetchPhotos(page: currentPage)
            }
        } label: {
            Label("Prev", systemImage: "chevron.left")
        }
        .buttonStyle(.borderedProminent)
        .disabled(currentPage == 1)
    }
    
    private var currentPageText:some View{
        Text("Page \(currentPage)")
            .font(.headline)
            .padding(.horizontal)
    }
    private var nextPageButton: some View {
        Button {
            currentPage += 1
            viewModel.fetchPhotos(page: currentPage)
        } label: {
            HStack {
                Text("Next")
                Image(systemName: "chevron.right")
            }
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var PaginationBottomBar: some View {
        HStack {
            previousPageButton
            Spacer()
            currentPageText
            Spacer()
            nextPageButton
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
