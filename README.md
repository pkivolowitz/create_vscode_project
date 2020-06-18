# Create VS Code Projects

The project creation script for Mac and Windows are combined into a single script. The script senses which kind of Linux it is running on (Mac or WSL) and installs appropriate VS Code files. 

This BASH script will create a new VSCode C++ project from scratch.

## Usage

Place this script in the directory in which you will store your CSC 1810 projects. When you move on to CSC 1820, make a directory for that class and copy this script over to the new one.

To launch the script on the Mac you have two choices:

1. From the terminal, when you are in your class folder you can enter: `./create_project.command`.
2. From the Finder, navigate to your class folder and double click on the above file.

To launch the script on Windows, you must be in Ubuntu. Then follow (1) above.

## Installation

Watch the video [here](https://youtu.be/EqkyGBz9av4?list=PLnE1d1TMuFwPqZq0caXSzHM4u2UdPmhW4) and read along below. While this video is recorded while running on a Mac, the steps are essentially the same for Ubuntu running on WSL.

Here are the written instructions, including what text you must copy then paste into your terminal.

1. Open TERMINAL on the Mac or start up Ubuntu on Windows. If you have not already done so, create the directory where all your CSC 1810 or CSC 1820 projects will go.
2. Change directory to where your projects will be stored. For example, `cd csc1810`
3. Copy this line:
```text
wget https://raw.githubusercontent.com/pkivolowitz/create_vscode_project/master/create_project.command
```
4. Paste the above line and hit return.
5. You should see something like this:
```text
% wget --no-check-certificate --content-disposition https://github.com/pkivolowitz/create_vscode_project/blob/master/create_project.command
--2020-06-13 10:56:44--  https://github.com/pkivolowitz/create_vscode_project_mac/blob/master/create_project.command
Resolving github.com (github.com)... 140.82.113.3
Connecting to github.com (github.com)|140.82.113.3|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/html]
Saving to: ‘create_project.command’

create_project.command              [ <=>                                                  ] 105.55K  --.-KB/s    in 0.1s    

2020-06-13 10:56:45 (764 KB/s) - ‘create_project.command’ saved [108087]

% 
```
6. Copy the following line:
```text
chmod 755 create_project.command
```
7. Paste the above line and hit return. Nothing will be printed.

