# Emacs configuration file


## Description

Configuration files to customize the aspect of emacs and extend its default capabilities. It consists of two files, `init.el` and `config.org`. The former defines some basic customization, most relevantly, it defines the repositories where to fetch the packages and loads `config.org` where most of the customizations are defined. An advantage of using an `.org` format is that it allows to include regular text (with notes and descriptions) along with the code for package configuration. Also when edited on emacs it facilitates moving throughout the text by collapsing/expanding the headers which in turn are used to separate the configuration in different sections.


## Loading

The files should be placed in the `.emacs.d` folder located in the home directory (On windows, `C:\Users\username\.emacs.d` and on Linux, `/home/your-username/.emacs.d`). Make sure there is not an `.emacs` file already which will take precedence over these files (i.e. they will not be loaded).

Provided an internet connection is available, the configuration file will install and configure most of the packages automatically.


### Manual configuration

For some packages user configuration is required, mainly specifying the path for some files/folders.

-   **All the icons:** Upon installation is necessary to run from emacs `M-x all-the-icons-install-fonts` where `M` stands for the meta key (usually associated with the `Alt` key).
    -   On windows it may be necessary to manually install the fonts by double-click on each of the downloaded font files (see this [reddit post](https://www.reddit.com/r/emacs/comments/gznezn/alltheicons/))
-   **org-ref:** Allows inserting references in a org file. References should be in bibtex format and the path to their location, as well as, that of the associated files should be specified. More information in org-ref [GitHub page](https://github.com/jkitchin/org-ref)
    
    ```emacs-lisp
      (setq bibtex-completion-bibliography
    	;; Directory of Bibtex file with references
    	 '("~/Documents/Referencias/Bibtex/Working.bib")
    	;; Directory of associated pdfs
    	bibtex-completion-library-path '("~/Documents/Articulos_y_Libros/")
    	;; Directory where notes are stored
    	bibtex-completion-notes-path "~/Documents/Articulos_y_Libros/Resumenes"
    ;; Other configurations ...
    	)
    ```
-   **org-reveal:** It is a package to export org files to [reveal.js](https://revealjs.com/) format. The path to the cloned directory should be specified and uncommented
    
    ```emacs-lisp
    (setq org-reveal-root "file:///<path-to-reveal>/reveal.js")
    ```
-   **Python (Anaconda):** It assumes an anaconda or miniconda [installation](https://docs.anaconda.com/anaconda/install/index.html) is present. To be able to use the environments, make sure to specify the pathway to the installation folder, as well as, the environments folder is specified
    
    ```emacs-lisp
    ;; Search for these lines and adjust the pathway accordingly
    ;; Part of 'conda' configuration
    (setq conda-anaconda-home (expand-file-name "~/.local/bin/miniconda3"))
    (setq conda-env-home-directory (expand-file-name "~/.local/bin/miniconda3"))
    
    ;; Part of 'elpy' configuration
    (setenv "WORKON_HOME" "/home/saul/.local/bin/miniconda3/envs/")
      (setq python-shell-virtualenv-path
          "/home/saul/.local/bin/miniconda3/envs/"
          elpy-rpc-virtualenv-path
          "/home/saul/.local/bin/miniconda3/envs/"
    ```


### Troubleshooting

-   **missing custom.el:** It may be possible that the configuration file fail to load due to the absence of a `custom.el` file. In that case an empty file should be created which will be populated while loading the configuration file.
-   **missing fonts:** Font customization is specified in the *Font* section (`Font > Default font`) and in the *Org-mode* section (`Org-mode > Aspect > Setup fonts`). Currently, they are set to `Courier New` and `Verdana`.