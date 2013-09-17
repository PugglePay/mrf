require 'spec_helper'
require 'io/console'


module MrF
  describe Keyring do
    it "can get retrive data from keyring" do
      keyring = Keyring.new(
        path: fixture_path('app.yml.gpg'),
        gpg_passphrase: '1234'
      )

      expect(keyring.data).to eq('production' => { 'secret' => 'hello' })
    end

    it "can retrive passphrase from console if no passphrase is given" do
      console = double("IO::Console")
      console.should_receive(:write).with(
        "Passphrase for EEF971D578000737 Tobias Funke (Mr F) <tobias@bluemangroup.org>: "
      )
      console.should_receive(:noecho).and_yield(double("FD", gets: "1234"))
      console.should_receive(:puts)

      IO.should_receive("console").and_return(console)

      keyring = Keyring.new(path: fixture_path('app.yml.gpg'))
      data = keyring.data
      expect(data).to eq('production' => { 'secret' => 'hello' })
    end
  end
end
