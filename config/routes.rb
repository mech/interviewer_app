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
      # We are using QuestionsController to represent StageQuestion model because of naming
      resources :questions do
        # Each StageQuestion can have many responses (but only makes sense under the context of specific interview)
        resources :responses
      end
    end
  end

  resources :templates do
    get 'browse', :on => :collection
    
    resources :questions
  end
  
  get "home/index"

end
