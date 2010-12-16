InterviewerApp::Application.routes.draw do

  resources :jobs

  get "home/index"

end
