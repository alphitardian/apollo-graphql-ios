import SwiftUI

struct LaunchListView: View {
    
    @StateObject private var viewModel = LaunchListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<viewModel.launches.count, id:\.self) { index in
                    NavigationLink(destination: DetailView(launchID: viewModel.launches[index].id)) {
                        LaunchRow(launch: viewModel.launches[index])
                    } 
                }
                if viewModel.lastConnection?.hasMore != false {
                    if viewModel.activeRequest == nil {
                        Button(action: viewModel.loadMoreLaunchesIfTheyExist) {
                            Text("Tap to load more")
                        }
                    } else {
                        Text("Loading...")
                    }
                }
            }
            .task {
                // TODO (Section 6 - https://www.apollographql.com/docs/ios/tutorial/tutorial-connect-queries-to-ui#use-launches-in-the-ui)
            }
            .navigationTitle("Rocket Launches")
            .appAlert($viewModel.appAlert)
            .task {
                viewModel.loadMoreLaunchesIfTheyExist()
            }
        }
        .notificationView(message: $viewModel.notificationMessage)
    }
    
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
    }
}
