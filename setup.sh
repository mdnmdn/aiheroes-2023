if  [ ! -d "./venv" ] 
then
  python3 -m venv venv
  . ./venv/bin/activate
  python3 -m pip install --upgrade pip
  
fi
. ./venv/bin/activate
pip install -r requirements.txt
