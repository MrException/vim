# Some old window managers I once used
#exec ratpoison
#exec stumpwm

if [[ $1 == "lxde" ]]
then
  exec lxsession
elif [[ $1 == "xmonad" ]]
then
  # XMonad

  # Set background to black, using feh no
  #xsetroot -solid black

  # Add window transparency, but I don't really like this
  #xcompmgr -c -f -D 5 & # adds some kind of transparency

  # Change the mouse pointer to something normal
  xsetroot -cursor_name left_ptr

  # start feh to provide a background image
  eval $(cat ~/.fehbg)

  # unclutter make mouse disapear when it hasn't moved for a while
  unclutter &

  # trayer is a little system tray
  /home/rob/bin/trayer --edge top --align right --SetDockType true --SetPartialStrut true \
   --expand true --width 10 --tint black --height 21 --alpha 0 --transparent true &

  # screensaver
  xscreensaver -no-splash &

  # xflux will change the monitor 'heat' color as the light outside gets darker
  #xflux -l 49.8772 -g -119.4874 &

  # xmodmap to change key mapping, specifically change CapsLock to Esc for vim
  xmodmap /home/rob/.Xmodmap

  #/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

  # make sure numlock is always on
  numlockx &

  # wicd is a good wireless connection manager
  #wicd-client

  #exec ck-launch-session dbus-launch xmonad
  exec dbus-launch xmonad
else
  echo "Choose a Window Manager"
fi
