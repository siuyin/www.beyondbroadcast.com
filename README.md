# Academic theme for Hugo: Do Not Use
This is a forked version customized for personal requirements.

Do not clone / use this repository unless you want my settings.

Instead please use the [original repository](https://github.com/gcushen/hugo-academic).

## Installation

1. Clone the repository.
1. Install hugo extended. For a snap installation: `sudo snap install hugo --channel=extended` .
1. Update git sub-modules:
   1. Change directory to repository.
   1. `git submodule update --init --recursive`

## Development

At the project root: `hugo server`. The site will be served at localhost:1313.

To create a new post|talk:  
hugo new post/{new post title}  
edit content/post/{new post title}/index.md

Subtitute "post" above with talk when creating a new talk.

## Deployment

At the project root:
1. `hugo --cleanDestinationDir --minify`
1. `rsync -avzd public/ target.host.com:html_public_folder`

