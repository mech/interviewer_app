InterviewerApp::Application.routes.draw do

  resources :positions do
    resources :stages do
      resources :stage_questions
    end
  end
  
  get "home/index"

end
