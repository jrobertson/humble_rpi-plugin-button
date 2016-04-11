#!/usr/bin/env ruby

# file: humble_rpi-plugin-button.rb


require 'rpi_pinin'


class HumbleRPiPluginButton


  def initialize(settings: {ignore_keyup: true}, variables: {})

    @ignore_keyup = settings[:ignore_keyup] || true
    @pins = settings[:pins].map {|x| RPiPinIn.new x, pull: :up}
    @notifier = variables[:notifier]
    @device_id = variables[:device_id] || 'pi'
    
  end

  def start()
    
    notifier = @notifier
    device_id = @device_id
    
    t0 = Time.now + 1
        
    puts 'ready to detect buttons'
    
    @pins.each.with_index do |button, i|
      
      puts 'button %s on GPIO %s enabled ' % [i+1, button]
            
      n = (i+1).to_s
            
      Thread.new do      
        
        button.watch do |value|
          
          # ignore any movements that happened 250 
          #               milliseconds ago since the last movement
          if t0 + 0.25 < Time.now then                   
              
            state = case value
            when 1
              @ignore_keyup ? :press : :down
            when 0
              :up unless @ignore_keyup
            end

            if state            
              notifier.notice "%s/button/%s: key%s" % [device_id, i, state]
            end
            
            t0 = Time.now
            
          end
        end
        
      end      
      
    end    

    
  end
  
  alias on_start start
  
  
end