class ContactsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :new, :create, :destroy]
def index
	if admin_signed_in?
		@contacts = Contact.all
	else
		redirect_to root_path, notice: "無効なURLです。"
	end
end

def show
	if admin_signed_in?
		@contact = Contact.find(params[:id])
	else
		redirect_to root_path, notice: "無効なURLです。"
	end
end

def new
	@contact = Contact.new
end

def create
	contact = Contact.new(contact_params)
	contact.save
	redirect_to contacts_path, notice: "お問い合わせを送信しました。"
end

def destroy
	if admin_signed_in?
		contact = Contact.find(params[:id])
	    contact.destroy
	    redirect_to contacts_path, notice: "お問い合わせを削除しました。"
	end
end

private
def contact_params
    params.require(:contact).permit(:name, :phone, :email, :title, :body)
  end

end
