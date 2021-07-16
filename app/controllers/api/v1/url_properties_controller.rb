class Api::V1::UrlPropertiesController < ApplicationController
    before_action :find_url_property_by_id, only: [:show, :update, :destory]

    # GET api/v1/url_properties
    def index
        @url_properties = UrlProperty.all
        render json: @url_properties
    end
    
    # GET api/v1/url_properties/:id
    def show
        if @url_property
            render json: @url_property, status: 200
        else
            render json: {error: "A url property with Id:'#{params[:id]}' does not exist"}, status: 404 
        end    
    end
    
    # GET api/v1/url_properties/redirect?key=:key
    def get_redirect
        @url_property = UrlProperty.where(unique_url_key: params[:key]).first
        if @url_property
           redirect_to @url_property.long_url
        else
            render json: {error: "A url property with Key:'#{params[:key]}' does not exist"}, status: 404 
        end    
    end

    # POST api/v1/url_properties
    def create
        @url_property = UrlProperty.new(url_property_params)
        until UrlProperty.where(unique_url_key: @url_property.unique_url_key).first == nil do 
            @url_property.generate_key 
        end
        if @url_property.save
            render json: @url_property, status: 200
        else
            render json: {error: 'Unable to create a new property'}, status: 400    
        end
    end
    
    # PUT api/v1/url_properties/:id
    def update
        if @url_property
           @url_property.update(url_property_params) 
            render json: @url_property, status: 200
        else
            render json: {error: "A url property with Id:'#{params[:id]}' does not exist"}, status: 404    
        end
    end

    # DELETE api/v1/url_properties/:id
    def destroy
        if @url_property
           @url_property.destroy 
            render json: {message: "Deleted sucessfully!"}, status: 200
        else
            render json: {error: "A url property with Id:'#{params[:id]}' does not exist"}, status: 404    
        end
    end

    private

    def url_property_params
        params.require(:url_property).permit(:long_url, :unique_url_key, :title)
    end
    
    def find_url_property_by_id
        @url_property = UrlProperty.find(params[:id])
    end    
end
