#!/bin/sh
touch public
rsync -avzd  public/ go.beyondbroadcast.com:website-conf/opt/hugo
