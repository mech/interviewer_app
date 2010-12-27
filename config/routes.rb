InterviewerApp::Application.routes.draw do

  resources :positions do
    resources :stages
  end
  
  get "home/index"

end
