Pry::Commands.block_command 'c', 'Alias for continue' do
  _pry_.run_command('continue')
end
Pry.config.prompt = Pry::Prompt.new(
  'Custom prompt',
  'My custom prompt',
  [proc { ">> " },
   proc { " | " }])
