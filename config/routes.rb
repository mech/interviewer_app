InterviewerApp::Application.routes.draw do

  resources :positions do
    resources :stages do
      post 'templates', :on => :member
      resources :stage_questions do
        delete 'index', :on => :collection
        post 'sort', :on => :collection
      end
    end
  end

  resources :templates do
    resources :questions
  end
  
  get "home/index"

end
