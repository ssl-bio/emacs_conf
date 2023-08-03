# Emacs configuration file


## Description

Configuration files to customize the aspect of emacs and extend its default capabilities. It consists of two files, `init.el` and `config.org`. The former defines some basic customization, most relevantly, it defines the repositories where to fetch the packages and loads `config.org` where most of the customizations are defined. An advantage of using an `.org` format is that it allows to include regular text (with notes and descriptions) along with the code for package configuration. Also when edited on emacs it facilitates moving throughout the text by collapsing/expanding the headers which in turn are used to separate the configuration in different sections.


## Dependencies

-   **Pandoc:** Required for exporting (converting) org files to other formats (*e.g.* HTML, markdown, etc). See pandoc's official website for [installation instructions](https://pandoc.org/installing.html)


## Loading

The files should be placed in the `.emacs.d` folder located in the home directory (On windows, `C:\Users\username\.emacs.d` and on Linux, `/home/your-username/.emacs.d`). Make sure there is not an `.emacs` file already which will take precedence over these files (/i.e./they will not be loaded).

Provided an internet connection is available, the configuration file will install and configure most of the packages automatically.


### Manual configuration

For some packages user configuration is required, mainly specifying the path for some files/folders.

-   **All the icons:** Upon installation is necessary to run from emacs `M-x all-the-icons-install-fonts` where `M` stands for the meta key (usually associated with the `Alt` key).
    -   On windows it may be necessary to manually install the fonts by double-click on each of the downloaded font files (see this [reddit post](https://www.reddit.com/r/emacs/comments/gznezn/alltheicons/))

1.  Packages that require the specification of a pathway

    The following packages require the user to specify the pathway where specific files or directories are located.
    
    -   **org-ref:** Allows inserting references in a org file. References should be in bibtex format (`*.bib`) and the path to their location, as well as, that of the associated files should be specified and uncomment the relevant code. More information can be found on the official `org-ref` [GitHub page](https://github.com/jkitchin/org-ref)
    
    -   **org-reveal:** It is a package to export org files to [reveal.js](https://revealjs.com/) format. The path to the cloned directory should be specified and uncommented
    
    -   **Python (Anaconda):** It assumes an anaconda or miniconda installation is present (See [official installation page](https://docs.anaconda.com/anaconda/install/index.html)). To be able to use the environments, make sure to specify the pathway to the installation folder, as well as, the environments folder is specified
    
    For easier maintenance variables that require a path were grouped in the section *Custom variables*
    
    ```emacs-lisp
    ;; Path to anaconda installation 
    (defvar essl/anaconda-home "~/.local/bin/miniconda3")
    (defvar essl/anaconda-venv "~/.local/bin/miniconda3/envs/")
    
    ;; Bibtex paths and files Change according to your installation
    (setq
     bibtex-completion-bibliography '("~/Documents/Refs/Bibtex/Working.bib")
     bibtex-completion-library-path '("~/Documents/Papers/")
     bibtex-completion-notes-path "~/Documents/Papers/Notes")
    
    ;; org-reveal-path
    (setq org-reveal-root "file:///run/media/shared/Cloned/reveal.js")
    
    ;; Path to bash (ansi term)
    (defvar essl/my-term "/bin/bash")
    
    ;; Fonts
    (defvar essl/mono-font "Courier New")
    (defvar essl/sans-font "Verdana")
    ```


### Troubleshooting

-   **error the first time emacs is loaded:** Sometimes an error may appear the first time emacs is started with this configuration but it is usually resolved after re-starting emacs
-   **missing custom.el:** It may be possible that the configuration file fail to load due to the absence of a `custom.el` file. In that case an empty file should be created which will be populated while loading the configuration file.
-   **missing fonts:** Font customization is specified in the *Font* section (`Font > Default font`) and in the *Org-mode* section (`Org-mode > Aspect > Setup fonts`). Currently, they are set to `Courier New` and `Verdana`. Change them in the section *Custom variables*