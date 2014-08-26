class HomeController < ApplicationController
  
  around_filter :shopify_session
  
 # def welcome
   # current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
  #  @callback_url = "http://#{current_host}/login"
 # end
  
def index
   # flash[:notice] =" Welcome!"
    # check for tabs on current product, load and display
    # if no tabs for current product, uncheck box tab_show
    
    # Get first product metafields
   
#product = ShopifyAPI::Product.find("#{id}")


# retrieve metafield

   # @product = ShopifyAPI::Product.handle
   
    
   # see if current product has metafields
   
   
   #tabs = ShopifyAPI::Metafield.find(:first,:params=>{:resource => "products", :resource_id => params[:id], :namespace => "tabsapp", :key => "tab"}).value
   
   #if tabs.
   
   # if yes, load current metafields and display them in form
   #tab_show
   
   
   # if no, do nothing.
    
   if request.post?
     # Add metafield to product
    flash[:notice] =" Posting... " 
      
     #product = ShopifyAPI::Product.find('product_id') 
      
     if params[:product_id].present?
       product = ShopifyAPI::Product.find(params[:product_id]) 
      
       #flash[:notice] =" Found product record..." + product.title
   
    
       show_tabs= (params[:tab_show]) ? "true" : "false"
      
       # flash[:notice] =" Found product record..." #+ product.title + "- show? " + show_tabs
       tabs_output = String.new
       contents_output = String.new
       final_description = String.new
      
       product.add_metafield(ShopifyAPI::Metafield.new({
         :description => 'Tab Description',
         :namespace => 'tabsapp',
         :key => 'tab_show',
         :value => show_tabs,
         :value_type => 'string'
         }))
      
         for i in 1..5
           tab_title = params[:"tab_title_#{i.to_s}"]
           product.add_metafield(ShopifyAPI::Metafield.new({
             :description => 'Tab Description',
             :namespace => 'tabsapp',
             :key => 'tab_title_'+i.to_s ,
             :value => tab_title,
             :value_type => 'string'
             }))
             
             
             
             
             description = "<p></p>"
             if params[:"tab_content_#{i.to_s}"].present?
               description=params[:"tab_content_#{i.to_s}"]    
               
            end
             
             product.add_metafield(ShopifyAPI::Metafield.new({
               :description => 'Tab Description',
               :namespace => 'tabsapp',
               :key => 'tab_content_'+i.to_s ,
               :value => description,
               :value_type => 'string'
               }))
      
               # build tab HTML to save
               if description != "<p></p>" && description != "<p>&nbsp;</p>" && description != ""
               tabs_output.concat("<li class=\"active-tab\">\n<a href=\"#tab-#{i.to_s}\">#{tab_title}</a>\n</li>\n")
               contents_output.concat("<div id=\"tab-#{i.to_s}\" class=\"\">#{description}</div>")
               end
             end
             
             #if tabs are being used, save fully formatted html back to main description.  If not, save first tab content back to description only if unchecked
             if show_tabs == "true"
               final_description.concat("<div class=\"tabs\">\n<ul>\n#{tabs_output}</ul>\n<div>\n#{contents_output}</div>\n</div>\n");
                #save final description
                product.body_html = final_description
                product.save
                
             elsif show_tabs == "false"
               if params[:"tab_content_1"].present?
                 final_description = params[:"tab_content_1"]   
                  #save final description 
                  product.body_html = final_description
                  product.save
               end
             end
            
             
             #reload product
    
              @product = ShopifyAPI::Product.find(params[:product_id]) 
      

              refresh_tabs(@product.id)
    end
      
     else
       #need to "catch" this
       
       
       if params[:id].present?
       @product = ShopifyAPI::Product.find(params[:id]) 
       flash[:notice] = params[:id]
     else
       flash[:notice] = "item not loaded, refresh product selection"
     end
       
    
      # @metafields =
    
     # if @product.metafields.any?
     # flash[:notice] = "foo"
     # end
     # refresh_tabs(@product.id)
      
      
      # if params[:name].present?
      #   flash[:notice] = "Created #{ params[:colour] } unicorn: #{ params[:name] }."
      # else
      # flash[:error] = "Name must be set."
      # end
      flash[:notice] = "Submitted!"
    end
    
    
  end

 # def modal
 # end

 # def modal_buttons
 # end

  #def regular_app_page
  #end

  #def buttons
 # end

 # def help
 # end

  def error
    raise "An error page"
  end

  def refresh_tabs(product_id) 
    flash[:notice] = "refreshing..." 
   #+ product_id.to_s
    
    @metafields = ShopifyAPI::Metafield.find(:first,:params=>{:resource => "products", :resource_id => product_id})
    
    show_tabs= (params[:tab_show]) ? "true" : "false"
    
     #flash[:notice] =" Found product record..." + product.title + "- show? " + show_tabs
    
     
    
    # flash[:notice] =" value: " + @metafields.each
     # if there is a value, update "show" check box
     
     # update saved values for all tabs
    
  for i in 1..5
    
  end
    
    
  end

#  def pagination
 #   @total_pages = 3
#    @page = (params[:page].presence || 1).to_i
#    @previous_page = "/pagination?page=#{ @page - 1 }" if @page > 1
#    @next_page = "/pagination?page=#{ @page + 1 }" if @page < @total_pages
#  end

end
