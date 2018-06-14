class ContactsController < ApplicationController
def index
	@contacts = Contact.all
end

def show
	@contact = Contact.find(params[:id])
end

def new
	@contact = Contact.new
end

def create
	contact = Contact.new(contact_params)
	contact.save
	redirect_to items_path
end

def destroy
	contact = Contact.find(params[:id])
    contact.destroy
    redirect_to contacts_path
end

private
def contact_params
    params.require(:contact).permit(:name, :phone, :email, :title, :body)
  end

end
