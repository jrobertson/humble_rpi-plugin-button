#!/usr/bin/env ruby

# file: humble_rpi-plugin-button.rb


require 'pi_piper'


class HumbleRPiPluginButton
  include PiPiper

  def initialize(settings: {}, variables: {})

    @pins = settings[:pins]
    @notifier = variables[:notifier]
    @device_id = variables[:device_id] || 'pi'
      
    at_exit do
      
      @pins.each do |pin|

        uexp = open("/sys/class/gpio/unexport", "w")
        uexp.write(pin)
        uexp.close
      
      end
    end

    
  end

  def start()
    
    notifier = @notifier
    device_id = @device_id
        
    puts 'ready to detect buttons'
    
    @pins.each.with_index do |button, i|
      
      puts 'button %s on GPIO %s enabled ' % [i+1, button]
      
      n = (i+1).to_s
      
      PiPiper.watch :pin => button.to_i, :invert => true do |pin|
        
        notifier.notice "%s/button/%s: value %s" % [device_id, i, pin.value]

      end
      
    end
    
    PiPiper.wait    

    
  end
  
  alias on_start start
  
  
end
