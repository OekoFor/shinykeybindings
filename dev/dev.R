library(devtools)


# Add dependencies --------------------------------------------------------
use_package("shiny")
use_package("glue")



# Add Functions -----------------------------------------------------------
use_r("kb_click")
use_r("key_args_to_js_condition")



# Package Setup -----------------------------------------------------------
use_readme_rmd()

# Git and Github ----------------------------------------------------------
# For the use of Github, follow this Blogpost to properly setup your credentialmanager if you haven't already
# https://blog.djnavarro.net/posts/2021-08-08_git-credential-helpers/#use-libsecret-credential-manager

use_git()
use_github(
  organisation = "OekoFor",
  private = TRUE,
  protocol = git_protocol(),
)


# Metadata stuff that needs to be updated  -----------------------------------------------------------------
use_lifecycle_badge( "Experimental" )
build_readme()


usethis::use_version()
