if [ -r $HOME/.ashrc ]; then
  ENV=$HOME/.ashrc; export ENV
  . $ENV
fi
