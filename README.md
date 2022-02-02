# Mending Milo

This repo is designed to aid with exploring DevOps tools and practices such as test/build/deploy automation and CI/CD. Documentation and tutorials will be made to collate key information so that projects here can be replicated and redeployed as easily as possible.

**If you run into any problems while following these guides, please raise them as an issue on this repo so that I can investigate and attempte to resolve them.**
___


## Preparing the docker workstation
For my applications I am using Ubuntu 18.04 on the `host machine` (i.e. where docker is installed), although there is no particular reason for this choice as my goal is to have these set-up procedures as agnostic of the exact Linux distro used as is reasonably possible.


|Installing Ubuntu on modern DELL computers
|-
(without getting locked out of your OS by the BIOS)


This took me a while to get right, but if you follow [this](https://www.youtube.com/watch?v=n8VwTYU0Mec) Tutorial you shouldn't run into this sort of issue.
Key things to consider:
- prepare a `bootable USB` (Ubuntu 20.04 for long-term support, but this works for 18.04 as well)
- configure the BIOS to run `"Data Wipe"` (wipe on next boot), and clear the boot sequence in the BIOS so that only the bootable USB is selected.
- also install `"third-party-software"` when installing Ubunutu via the bootable USB.

*update (02/02/2022)*\
I am using a Dell Precision-7560, and I needed to disable `hybrid graphics` in the BIOS menu to prevent the laptop display from crashing on boot (Ubuntu 18.04 OS still works when this happens, but and external display is needed to see anything).



|Minimum installation on host machine
|-
Once Ubunut is installed, run the `fresh-install-setup.sh` script as root. This script installs the minimum dependencies (as well as some software that I find generally useful to keep on the host machine)Once this is finished, you're ready to go! 

|Additional installation for GUI-enabled docker containers
|-
Run the `setup-cuda-drivers-ubuntu-18-04.sh` script and do not enroll new key if prompted. This is necessary if you're using an nvidia GPU'


## Misc
<sub><sup>
Tired of sitting around mending broken code?
Have you considered going to the gym and [rebuilding milo](https://www.goodreads.com/en/book/show/54303312-rebuilding-milo) instead? 
</sup></sub>