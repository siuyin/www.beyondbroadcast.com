#!/bin/sh
touch public
rsync -avzd  public/ rasp.h:html
