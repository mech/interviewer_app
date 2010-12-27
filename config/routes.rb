InterviewerApp::Application.routes.draw do

  resources :positions do
    resources :stages do
      resources :questions
    end
  end

  resources :questions
  
  get "home/index"

end
