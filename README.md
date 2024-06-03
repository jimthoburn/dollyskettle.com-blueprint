# Blueprint for dollyskettle.com _beta_

This is a [blueprint](https://render.com/docs/infrastructure-as-code) for setting up a web site using [Deno](https://deno.land), [Git](https://git-scm.com) and [Docker](https://www.docker.com).

It’s a work in progress 🚧

I’m using it to practice with new tools, and to help a family member who’s publishing recipes & pictures 🍎 🖼

This works together with a separate [content repository](https://github.com/jimthoburn/dollyskettle.com) that has tools for building and serving the web site.

If you’d like to re-use this code to set up your own web site, the basic steps are…

1. Make a copy of this repository and do the same for the [content repository](https://github.com/jimthoburn/dollyskettle.com). You may want to make them both private. 🔐
2. Consider editing the included Dockerfile and [render.yaml](render.yaml) file. For example, you can change the region from `oregon` to one that’s closer to you. Another thing to consider is the [disk size](https://render.com/docs/disks).
3. Create a new GitHub account that only has access to your copy of the [content repository](https://github.com/jimthoburn/dollyskettle.com).
4. Generate a new [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) and add it to your new GitHub account.
5. In your Render dashboard, create new environment groups, following the examples in: [render.yaml](render.yaml). For `GIT_REPOSITORY`, enter a value like `username/repository.git`, with the path to your copy of the [content repository](https://github.com/jimthoburn/dollyskettle.com). You can use the account and key you created in steps 3 and 4 for the other environment variables and secrets. For the `known_hosts` secret file, you can add GitHub’s [SSH key entries](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints).
6. In your Render dashboard, create a new [blueprint](https://render.com/docs/infrastructure-as-code) using your copy of this repository. A new service will be set up for you automatically.
7. [Link the environment groups](https://docs.render.com/configure-environment-variables#linking-a-group-to-a-service) you created in step 5 to your new service (if they’re not already linked), and re-deploy your service.
8. After you service is deployed, [connect to it using SSH](https://docs.render.com/ssh).
9. Switch to the home directory with `cd ~/`
10. Finish the setup process by running `bash setup-images.sh`
11. Build the site with `bash build.sh`

You can pull the latest files from your [content repository](https://github.com/jimthoburn/dollyskettle.com) by running `bash reset.sh`. (This will also discard any local changes, since these may be generated from the build process.)

If you want to run [Git](https://git-scm.com) commands manually, you can set up `Git` for your SSH session with `bash configure-git.sh`.

## Image file storage

[Git Large File Storage](https://git-lfs.github.com/) is configured for the service. This will support using `git-lfs` if it’s also enabled in your [content repository](https://github.com/jimthoburn/dollyskettle.com). If you have a lot of image files, you may run into [bandwidth limits on GitHub](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-storage-and-bandwidth-usage) when deploying the service.

## Project goals

This project is an experiment to see how easily the following goals can be achieved when deploying a static site…

1. Support a large amount of images during the build step for a static site (more than 10 GB).
2. Host the images using [GitHub’s Large File Storage](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage), so that they can be easily cloned from a private repository or downloaded from a public repository.
3. Use [Deno](https://deno.com) to build the site, to make local development and deployment more secure.

