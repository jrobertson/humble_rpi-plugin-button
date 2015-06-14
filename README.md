# Introducing the Humble_rpi-plugin-button gem

## Set up an SPS broker

    require 'simplepubsub'

    SimplePubSub::Broker.start(host: 'localhost', port: 59000)

## Test the SPS messaging is working

### Set up a subscriber

    require 'sps-sub'

    sps = SPSSub.new address: 'localhost', port: 59000

    def sps.ontopic(topic, msg)
      puts "%s - %s: %s"  % [Time.now.to_s, topic, msg.inspect]
    end

    sps.subscribe topic: '#'

### Publish a message

    require 'sps-pub'

    sps = SPSPub.new address: 'localhost', port: 59000
    sps.notice 'test: 123'


## Testing the plugin

    require 'sps-pub'
    require 'humble_rpi-plugin-button'

    sps = SPSPub.new address: 'localhost', port: 59000
    rpi = HumbleRPiPluginButton.new(settings: {pins: [4]}, variables: {notifier: sps})
    rpi.start

Observed <pre>2015-06-14 11:50:42 +0100 - pi/button/0: "value 0"
Received message: value 1
2015-06-14 11:50:43 +0100 - pi/button/0: "value 1"
Received message: value 0
2015-06-14 11:50:43 +0100 - pi/button/0: "value 0"
</pre>


## Resources

* ?humble_rpi-plugin-button https://rubygems.org/gems/humble_rpi-plugin-button?
* ?humble_rpi https://rubygems.org/gems/humble_rpi?

humblerpi plugin button
