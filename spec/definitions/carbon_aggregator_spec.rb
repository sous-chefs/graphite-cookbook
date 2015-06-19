require 'spec_helper'

describe 'graphite_carbon_aggregator (definition)' do
  let(:recipe_run) do
    fake_recipe_run do
      graphite_carbon_aggregator 'default' do
        config(
          line_receiver_interface: '0.0.0.0',
          line_receiver_port: 2005,
          destinations: %w(
            127.0.0.1:2003:a
            127.0.0.1:2004:b
          )
        )
      end
    end
  end

  it 'creates default carbon-aggregator configuration' do
    expect(recipe_run).to render_file('carbon.conf')
      .with_content([
        '[aggregator]',
        'LINE_RECEIVER_INTERFACE = 0.0.0.0',
        'LINE_RECEIVER_PORT = 2005',
        'DESTINATIONS = 127.0.0.1:2003:a, 127.0.0.1:2004:b'
      ].join("\n"))
  end
end
