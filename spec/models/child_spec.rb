require 'rails_helper'

RSpec.describe Child, type: :model do
  # Valid factory test is on factories_spec.rb
  
  it { is_expected.to validate_presence_of(:nombre) }
  it { is_expected.to validate_presence_of(:grado) }
  it { is_expected.to validate_presence_of(:tipo_servicio) }
  it { is_expected.to belong_to(:family) }
  it { is_expected.to have_many(:menu_day).dependent(:destroy) }
    
  context "who is not on last year" do
    it "advances to next Grado" do
      child = FactoryGirl.create(:child,  grado: 3)
      expect{child.pasar_grado}.to change{child.grado}.by(1)
    end  
  
    it "doesn't get graduated" do
      child = FactoryGirl.create(:child,  grado: 3)
      user = FactoryGirl.create(:user)
      expect { child.egresar_alumno(user) }.not_to change(Child, :count)
      expect{ child.egresar_alumno(user) }.not_to change{ Comment.count }
    end
  end
  
  context "who is on last year" do
    it "doesn't advance to next Grado" do
      child = FactoryGirl.create(:child,  grado: Child::GRADOS['7mo Grado'])
      expect{ child.pasar_grado }.not_to change{ child.grado }
    end
    
    it "gets graduated" do
      child = FactoryGirl.create(:child,  grado: Child::GRADOS['7mo Grado'])
      user = FactoryGirl.create(:user)
      expect { child.egresar_alumno(user) }.to change(Child, :count).by(-1)
      expect{ child.egresar_alumno(user) }.to change{ Comment.count }.by(1)
    end
  end
end
