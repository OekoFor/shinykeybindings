library(devtools)


# Git and Github ----------------------------------------------------------
# For the use of Github, follow this Blogpost to properly setup your credentialmanager if you haven't already
# https://blog.djnavarro.net/posts/2021-08-08_git-credential-helpers/#use-libsecret-credential-manager


use_git()
use_github(
  organisation = "OekoFor",
  private = TRUE,
  protocol = git_protocol(),
)
