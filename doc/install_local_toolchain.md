# How to edit and build your thesis locally?

The thesis template is potentially too large to be compiled efficiently with Overleaf (or the local ShareLaTeX instance). In this tutorial, we show you how to install the software to edit and compile your thesis on your local PC.


## 1 - Fork and clone this repository

### Fork this repo

Fork the repository into your local account:

![Fork this repo](/assets/fork_repo.png)

(you can also star this repo)

Choose a name for your repo:

![Choose a name for your fork](/assets/create_fork.png)

Your fork is now available at https://github.com/YOUR_GITHUB_USERNAME/YOUR_FORK_NAME

### Clone your fork

#### Using GitHub Desktop

Install GitHub Desktop from https://desktop.github.com/download/ :

![Download GitHub Desktop](/assets/download_github_desktop.png)

Sign in to your account and clone your repository:

![Clone GitHub repository](/assets/clone_github_desktop.png)

#### Using command line

<a id="install_git"></a>
Install git:

**Windows:**

Install git from https://git-scm.com/install/windows :

![Download git for Windows](/assets/download_git_windows.png)

Run the installer, you can leave the default options.

**MacOS:**

Run:

```bash
brew install git
```

**Linux (Debian / Ubuntu):**

Run

```bash
sudo apt update
sudo apt install git
```

Clone your repository:

```bash
cd parent_directory
git clone https://github.com/YOUR_GITHUB_USERNAME/YOUR_FORK_NAME.git
```

You may be asked for credentials

## 2 - Install the compilation toolchain

Install the required software to build your LaTeX locally

### Windows

First install Strawberry Perl from https://strawberryperl.com/:

![Download strawberry perl MSI](/assets/download_strawberry_perl.png)

Launch the msi file, keep the default destination folder:

![Keep Strawberry Perl default destination folder](/assets/strawberry_perl_destination_folder.png)


Next install MikTeX from https://miktex.org/download :

![Download MikTex for Windows](/assets/download_miktex.png)

Launch the installer, and install just for you:

![Install MikTex just for you](/assets/install_miktex_for_me.png)

Automatically install missing packages:

![Automatically install MikTex missing packages](/assets/miktex_install_missing_packages.png)

### MacOS

Run:
```bash
sudo tlmgr update --self
sudo tlmgr install latexmk
brew install --cask mactex
```

### Linux (Debian / Ubuntu)

Run:

```bash
sudo apt update
sudo apt install texlive-full latexmk
```

## 3 - Setup your IDE

### Setup Visual Studio Code

Download Visual Studio Code from https://code.visualstudio.com/Download :

![Download Visual Studio Code](/assets/download_vscode.png)

Run the installer, you can leave the default options.

Install LaTeX Workshop extension:

![Install LaTeX Workshop on VS Code](/assets/install_latex_workshop_extension.png)

Open your clone directory:

![Open folder in VSCode](/assets/vscode_open_folder.png)

If asked, install git, [as explained above](#install_git):

![VS Code asks for git](/assets/vs_code_download_git.png)

:warning: **You may need to restart Visual Studio Code!**

### Compile your thesis

Inside Visual Studio Code, open the main tex file (probably `sommaire.tex`):

![Open main file in VS Code](/assets/vs_code_main_file.png)

:bulb: **TIP:** you can enable auto word wrap in order to have all the text in your screen by pressing Alt+Z on Windows / Linux, ⌥+Z on MacOS.

Open the command palette by pressing F1 or Ctrl+P (⌘+P on MacOS) and type "Build LaTex project", then press enter:

![VS Code build LaTeX project from command palette](/assets/vscode_build_latex_project.png)

Wait until the spinning wait cursor is done (this could be long on the first build...).

![LaTeX is building in VSCode](/assets/vscode_latex_building.png)

Build done:

![Build is done in VSCode](/assets/vscode_latex_build_done.png)

:warning: If a compilation error appears, ensure that you followed correctly the procedure. Also check the error messages if there is a LaTeX syntax error. If the error came from us, do not hesitate to open an issue or a pull request to update this tutorial!

### Enable side view

Open the command palette and type "*latex workshop: view LaTex PDF file in VSCode tab*":

![VSCode command palette: view generated PDF](/assets/vscode_view_pdf.png)

The generated PDF should appear:

![We can preview the generated PDF](/assets/vscode_view_pdf_tab.png)

Now you can edit your LaTeX: the compiled PDF file and the side view will be updated automatically.

:arrow_right: The output PDF is likely `sommaire.pdf`.


## 4 - Commit your changes to your repo

When you have made some changes, stage the changes using Visual Studio Code Source Control menu:

![Stage changes in VSCode](/assets/vscode_stage_changes.png)

Write a commit message describing your changes, then commit and push.

![Commit and push in VSCode](/assets/vscode_commit_push.png)


## 5 - Convert your PDF for archiving

When your thesis is ready, it must be converted to archiving format before uploading to ADUM.

### Using CINES Facile service

Go to https://facile.cines.fr/ then **Correction PDF** > **Conversion en PDF 1.7 à l'aide de Ghostscript**:

![Convert to PDF 1.7 using CINES Facile tool](/assets/facile_cines_convert_pdf.png)

### Using Ghostscript locally:

Install Ghostscript:

**Windows:**

Download Ghostscript from https://ghostscript.com/releases/gsdnld.html

**MacOS:**

Run:

```bash
brew install ghostscript
```

**Linux (Debian / Ubuntu):**

Run:

```bash
sudo apt update
sudo apt-get install ghostscript
```

Finally convert your PDF:

```bash
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.7 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=OUTPUT_FILE.pdf sommaire.pdf
```

### Using GitHub Actions workflow auto build:

Archivable PDF builds are auto generated at each push to your repo. You can download the PDF in generated artifacts, [as explained in README.md](/README.md#automatic_generation_pdf).