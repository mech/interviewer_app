InterviewerApp::Application.routes.draw do

  resources :positions do
    resources :stages do
      resources :stage_questions do
        delete 'index', :on => :collection
      end
    end
  end
  
  get "home/index"

end
