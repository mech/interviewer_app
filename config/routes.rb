InterviewerApp::Application.routes.draw do

  resources :positions do
    resources :stages do
      post 'save_as_templates', :on => :member
      post 'pinned', :on => :member
      post 'pull_questions', :on => :member
      
      resources :stage_questions do
        delete 'index', :on => :collection
        post 'sort', :on => :collection
      end
    end

    resources :interviews do
      resources :questions
    end
  end

  resources :templates do
    get 'browse', :on => :collection
    
    resources :questions
  end
  
  get "home/index"

end
