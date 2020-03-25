# install necessary packages
sudo apt install git python3-pip
pip3 install --user django RPi.GPIO requests

# download project files
mkdir SuperBikeLock
cd SuperBikeLock
git init
git config core.sparseCheckout true
git remote add -f origin https://github.com/ChicoState/BikeLock
echo "Hardware/" > .git/info/sparse-checkout
git checkout HwcDev

# set hostname

# register rackServer
