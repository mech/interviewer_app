InterviewerApp::Application.routes.draw do

  resources :positions

  get "home/index"

end
