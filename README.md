# Emacs configuration file using `straight.el` + `Helm`


## Description

Configuration files to customize the aspect of emacs and extend its default capabilities. It consists of two files, `init.el` and `config.org`. The former defines some basic customization, most relevantly, it defines the repositories where to fetch the packages and loads `config.org` where most of the packages are loaded and configured. The configuration files used in the main branch were modified to use the package manager [straight.el](https://github.com/radian-software/straight.el#features) which installs packages directly from their repository. This allows one to revert a package version in case the current one is broken; or to install packages that are not yet in a repository. The configuration file uses [helm](https://github.com/emacs-helm/helm) for completion, selection, searching and other functions


## Third party software


### Dependencies

-   **Pandoc:** Required for exporting (converting) org files to other formats (*e.g.* HTML, markdown, etc). See pandoc's official website for [installation instructions](https://pandoc.org/installing.html)


### Others

-   [Anaconda](https://anaconda.org/):
-   [R](https://cran.r-project.org/):
-   Tex distribution: [TeXLive](http://www.tug.org/texlive/) [MikTeX](https://miktex.org/)

Two packages that help writing code are [format-all](https://ianyepan.github.io/posts/format-all/) and [flycheck](https://www.flycheck.org/en/latest/). These, require additional packages to check the format of the code, those used in the configuration are described below

| Language | Package                                                 | Notes                                                  |
|-------- |------------------------------------------------------- |------------------------------------------------------ |
| R        | styler                                                  | `install.packages("styler")`                           |
| Bash     | [shfmt](https://tracker.debian.org/pkg/golang-mvdan-sh) | `sudo apt install golang-mvdan-sh-dev`                 |
|          | [beautysh](https://github.com/lovesegfault/beautysh)    | `pip install beautysh`                                 |
| Python   | various                                                 | `pip3 install black jedi autopep8 flake8 ipython yapf` |
| Html     | [tidy](http://www.html-tidy.org/)                       | `sudo apt install tidy`                                |
| Latex    | auctex                                                  | Part of [TexLive](https://tug.org/texlive/)            |

| Language   | Package                                               | Notes                                       |
|---------- |----------------------------------------------------- |------------------------------------------- |
| R          | [lintr](https://lintr.r-lib.org/)                     | `install.packages("lintr")`                 |
| Awk        | gawk                                                  | `sudo apt install gawk`                     |
| Bash       | [shellcheck](https://github.com/koalaman/shellcheck/) | `sudo apt install shellcheck`               |
| Html       | [tidy](http://www.html-tidy.org/)                     | `sudo apt install tidy`                     |
| JavaScript | [jshint](https://jshint.com/)                         | `npm install -g jshint`                     |
| Python     | various                                               | `pip3 install pylint flake8`                |
|            |                                                       | `sudo apt install pylint`                   |
| Latex      | lacheck                                               | Part of [TexLive](https://tug.org/texlive/) |


## Loading

The files should be placed in the `.emacs.d` folder located in the home directory (On windows, `C:\Users\username\.emacs.d` and on Linux, `/home/your-username/.emacs.d`). Make sure there is not an `.emacs` file already which will take precedence over these files (/i.e./they will not be loaded).

Provided an internet connection is available, the configuration file will install and configure most of the packages automatically.


### Packages that require the specification of a pathway

The following packages require the user to specify the pathway where specific files or directories are located.

-   **org-ref:** Allows inserting references in a org file. References should be in bibtex format (`*.bib`) and the path to their location, as well as, that of the associated files should be specified. More information can be found on the official `org-ref` [GitHub page](https://github.com/jkitchin/org-ref)

```emacs-lisp
;; Bibtex paths and files
  (defvar docs-dir
    (if (file-directory-p "~/Documents")
        "~/Documents"
      (if (file-directory-p "~/Documentos")
          "~/Documentos"
        "other")))
  (setq
   bibtex-completion-bibliography (concat docs-dir "/Referencias/Bibtex/Working.bib")
   bibtex-completion-library-path (concat docs-dir "/Articulos_y_Libros/")
   bibtex-completion-notes-path (concat docs-dir "/Articulos_y_Libros/Resumenes"))
```

-   **org-reveal:** It is a package to export org files to [reveal.js](https://revealjs.com/) format. The path to the cloned directory should be specified

```emacs-lisp
(defvar reveal-path
    (if (file-directory-p "/media/discs/shared/Cloned/reveal.js")
        "file:///media/discs/shared/Cloned/reveal.js"
      (if (file-directory-p "/media/particiones/Compartidos/saul/Cloned/reveal.js")
          "file:///media/particiones/Cloned/reveal.js"
        "other")))
(setq org-reveal-root reveal-path)
```

-   **Python (Anaconda):** It assumes an anaconda or miniconda installation is present (See [official installation page](https://docs.anaconda.com/anaconda/install/index.html)). To be able to use the environments, make sure to specify the pathway to the installation folder, as well as, the environments folder is specified

```emacs-lisp
;; Path to anaconda installation 
(defvar conda-dir
  (if (file-directory-p "/media/discs/shared/miniconda3")
      "/media/discs/shared/miniconda3"
    (if (file-directory-p "~/.local/bin/miniconda3")
        "~/.local/bin/miniconda3"
      "other")))

(defvar essl/anaconda-home conda-dir)
(defvar essl/anaconda-venv (concat conda-dir "/envs"))
```

**For easier maintenance variables that require a path were grouped in the section *Custom variables*. Modify these accordingly**


### Troubleshooting

-   **error the first time emacs is loaded:** Sometimes an error may appear the first time emacs is started with this configuration but it is usually resolved after re-starting emacs
-   **missing fonts:** Font used are specified in the *Custom variables* section in the `config.org` file. Currently, they are set to `Courier New` and `Verdana`.
    
    ```emacs-lisp
    ;; Fonts
    (defvar essl/mono-font "Courier-New")
    (defvar essl/sans-font "Verdana")
    (defvar essl/default-font "Courier-New")
    ```
