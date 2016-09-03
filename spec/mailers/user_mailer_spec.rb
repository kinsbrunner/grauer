require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "password_changed" do
    let(:user){ user = FactoryGirl.create(:user) }
    let(:mail) { UserMailer.password_changed(user.id) }

    it "renders the headers" do
      expect(mail.subject).to eq("GrauerCatering.com - Su contraseña ha sido modificada")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-responder@grauercatering.com"])
    end

    it "renders the body" do
      #expect(mail.body.encoded).to match("Cambio de contraseña en GrauerCatering.com")
    end
  end

end
