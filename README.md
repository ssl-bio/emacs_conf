# Emacs configuration file using `straight.el` + `Helm`


## Description

Configuration files to customize the aspect of emacs and extend its default capabilities. It consists of two files, `init.el` and `config.org`. The former defines some basic customization, most relevantly, it defines the repositories where to fetch the packages and loads `config.org` where most of the packages are loaded and configured. The configuration files used in the main branch were modified to use the package manager [straight.el](https://github.com/radian-software/straight.el#features) which installs packages directly from their repository. This allows one to revert a package version in case the current one is broken; or to install packages that are not yet in a repository. The configuration file uses [helm](https://github.com/emacs-helm/helm) for completion, selection, searching and other functions


## Third party software


### Dependencies

-   **Pandoc:** [\*Recommended\*] Required for exporting (converting) org files to other formats (*e.g.* HTML, markdown, etc). See pandoc's official website for [installation instructions](https://pandoc.org/installing.html)
-   **Zoxide**: [\*Optional\*] Provides a better way to navigate directories [[homepage](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file)]. The emacs package, [zoxide.el](https://gitlab.com/Vonfry/zoxide.el), allows a similar functionality using dired.
-   **Mermaid-cli**: [\*Optional\*] Command line interface to the diagramming and charting tool, Mermaid. In the recommended way to [install](https://github.com/mermaid-js/mermaid-cli?tab=readme-ov-file#installation) is through node.js package manager, npm: `npm install -g @mermaid-js/mermaid-cli`. The path to the binaries should be defined accordingly.


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

The following packages require the user to specify the pathway where specific files or directories are located. **For easier maintenance variables that require a path were grouped in the section *Custom variables*. Modify these accordingly**

1.  Path to documents

    Since most of the packages are used to create notes, a custom variable to indicate the `Documents` path was created. It uses an `if` statement to distinguish two different locations based on the localization of the system but that could be changed
    
    ```emacs-lisp
    (defvar docs-dir
        (if (file-directory-p "~/Documents")
            "~/Documents"
          (if (file-directory-p "~/Documentos")
              "~/Documentos"
            "other")))
    ```

2.  Python (Anaconda)

    It assumes an anaconda or miniconda installation is present (See [official installation page](https://docs.anaconda.com/anaconda/install/index.html)). To be able to use the environments, make sure to specify the pathway to the installation folder, as well as, the environments folder is specified
    
    ```emacs-lisp
    ;; Path to anaconda installation 
    (defvar conda-dir
      (if (file-directory-p "/media/discs/shared/miniconda3")
          "/media/discs/shared/miniconda3"
        (if (file-directory-p "~/.local/bin/miniconda3")
            "~/.local/bin/miniconda3"
          "other")))
    
    (defvar my/anaconda-home conda-dir)
    (defvar my/anaconda-venv (concat conda-dir "/envs"))
    ```

3.  org-roam

    Allows the creation and management of interconnected notes using the Zettelkasten method (see its [homepage](https://www.orgroam.com/)). It requires to specify a directory where to store the notes. The following line creates a custom variable that is latter used in the org-roam configuration section.
    
    ```emacs-lisp
    (setq my/org-roam-dir "~/Documents/Org-files/Org-roam")
    ```

4.  org-noter

    Provides functions to simplify taking notes on documents particularly pdf files (see its [GitHub](https://github.com/org-noter/org-noter/tree/master) page). Examples include synchronizing the notes at specific points in the document or creating an overview of the document. It also requires to specify a directory where to store the notes.
    
    ```emacs-lisp
    (setq my/org-noter-dir "~/Documents/Org-files/Org_noter")
    ```

5.  org-ref

    Allows inserting references in a org file. References should be in bibtex format (`*.bib`) and the path to their location, as well as, that of the associated files should be specified. More information can be found on the official `org-ref` [GitHub page](https://github.com/jkitchin/org-ref)
    
    ```emacs-lisp
    ;; Bibtex paths and files
    (setq
       bibtex-completion-bibliography (concat docs-dir "/Refs/Bibtex/Working.bib")
       bibtex-completion-library-path (concat docs-dir "/Papers_Books/")
       bibtex-completion-notes-path (concat docs-dir "/Papers_Books/Summaries"))
    ```

6.  ebib

    Allows the management of references in bibtex format (see its [online manual](http://joostkremers.github.io/ebib/ebib-manual.html)). The following variables are used to store the location where to search for bibtex files and which files should be load when the package is started.
    
    ```emacs-lisp
    ;; ebib
      (setq my/ebib-search-dir (concat docs-dir "/Refs/Bibtex/"))
      (setq my/ebib-bibtex-files
          (list
           (concat docs-dir "/Refs/Bibtex/Articles_zotero.bib")
           (concat docs-dir "/Refs/Bibtex/Books_zotero.bib")))
    ```

7.  org-reveal

    It is a package to export org files to [reveal.js](https://revealjs.com/) format. The path to the cloned directory should be specified
    
    ```emacs-lisp
    ;; org-reveal-path
    (defvar reveal-path
      (if (file-directory-p "/media/discs/shared/Cloned/reveal.js")
          "file:///media/discs/shared/Cloned/reveal.js"
        (if (file-directory-p "/media/particiones/Cloned/reveal.js")
            "file:///media/particiones/Cloned/reveal.js"
          "other")))
    (setq org-reveal-root reveal-path)
    ```

8.  Mermaid-cli

    ```emacs-lisp
    ;; Define directory where ananconda is installed
    (defvar conda-dir
      (if (file-directory-p "/media/discs/shared/miniconda3")
          "/media/discs/shared/miniconda3"
        (if (file-directory-p "~/.local/bin/miniconda3")
            "~/.local/bin/miniconda3"
          "other")))
    ;; Concatenate the base directory for anaconda and
    ;; that for mermaid-cli
    (defvar my/mmdc-path (concat conda-dir "/bin/mmdc"))
    ```


### Troubleshooting

-   **error the first time emacs is loaded:** Sometimes an error may appear the first time emacs is started with this configuration but it is usually resolved after re-starting emacs
-   **missing fonts:** Font used are specified in the *Custom variables* section in the `config.org` file. Currently, they are set to `Courier New` and `Verdana`.
    
    ```emacs-lisp
    ;; Fonts
    (defvar my/mono-font "Courier-New")
    (defvar my/sans-font "Verdana")
    (defvar my/default-font "Courier-New")
    ```
