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
      expect(console).to receive(:write).with(
        "Passphrase for EEF971D578000737 Tobias Funke (Mr F) <tobias@bluemangroup.org>: "
      )
      expect(console).to receive(:noecho).and_yield(double("FD", gets: "1234"))
      expect(console).to receive(:puts)
      expect(IO).to receive("console").and_return(console)

      keyring = Keyring.new(path: fixture_path('app.yml.gpg'))
      expect(keyring.data).to eq('production' => { 'secret' => 'hello' })
    end
  end
end
