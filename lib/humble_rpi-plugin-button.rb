#!/usr/bin/env ruby

# file: humble_rpi-plugin-button.rb


require 'rpi_pinin_msgout'


class HumbleRPiPluginButton


  def initialize(settings: {}, variables: {}, verbose: false)
    
    pins = settings[:pins]
    settings.delete :pins
    
    h1 = {
      capture_rate: 0.25, # seconds
      mode: :default
      }.merge settings

    h2 = {device_id: 'pi'}.merge variables
    
    h3 = {
      pull: :up, 
      subtopic: 'button', 
      descriptor: 'pressed',
      verbose: verbose
    }
        
    h = h1.merge(h2).merge(h3)
    
    @pins = pins.map.with_index do |x,i|
      
      RPiPinInMsgOut.new x, h.merge(index: i+1)
      
    end    
    
  end
    
  def start()
        
    puts 'ready to detect buttons'
    
    @pins.each {|pin| Thread.new { pin.capture} }

  end  
  
  alias on_start start
  
  
end