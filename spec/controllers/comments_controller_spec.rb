require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "comments#create action" do
    before :each do
      @school = FactoryGirl.create(:school)
      @user = FactoryGirl.create(:user)
      @family = FactoryGirl.create(:family)
      @comment = FactoryGirl.attributes_for(:comment)
    end

    it "should successfully create a comment in our database" do
      sign_in @user
      
      qty_comments = @family.comments.count
      expect{post :create, comment: @comment, school_id: @school, family_id: @family}.to change(Comment,:count).by(1)
      expect(response).to redirect_to school_family_path(@school, @family)
      
      new_comment = Comment.last
      expect(new_comment.message).to eq(@comment[:message])
      expect(@family.comments.count).to eq(qty_comments + 1)
    end
    
    it "should require users to be logged in" do
      post :create, comment: @comment, school_id: @school, family_id: @family
      expect(response).to redirect_to new_user_session_path
    end
  end
end
