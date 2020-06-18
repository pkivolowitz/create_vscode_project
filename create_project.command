#!/bin/bash
sys="$(uname -s)"
case "${sys}" in
	Linux*)     machine=Linux;;
	Darwin*)    machine=Mac;;
	*)          machine=UNKNOWN
esac
if [ $machine == "UNKNOWN" ]
then
	echo "This script is written for Macintosh or Linux. This machine appears to be neither:" $sys
	exit
fi

cd -- "$(dirname "$BASH_SOURCE")"
echo "Current directory is:" `pwd`
read -p 'Enter new project name: ' project

if [ -e $project ]
then
	echo $project "alread exists"
	exit 
fi

mkdir $project
if [ $? -ne 0 ]
then
	echo "Attempt to create directory for" $project "failed."
	exit
fi
echo "Directory for" $project "created."

cd $project
if [ $? -ne 0 ]
then
	echo "Changing directory to" $project "failed."
	exit
fi

cat > project.code-workspace <<EOF
{
	"folders": [
		{
			"path": "."
		}
	],
	"settings": {
		"files.associations": {
			"iostream": "cpp"
		}
	}
}
EOF
echo "Workspace file created."

cat > main.cpp <<EOF
#include <iostream>

using namespace std;

int main(int argc, char * argv[]) {
	cout << "Hello Carthage CS Student" << endl;
	return 0;
}
EOF
echo "Starter c++ file created."

mkdir .vscode
if [ $? -ne 0 ]
then
	echo "Creating .vscode directory failed."
	exit
fi

cd .vscode

WinCreateLaunch() {
	cat > launch.json <<EOF
{
	// Windows version
    "version": "0.2.0",
    "configurations": [
        {
            "name": "g++ - Build and debug active file",
            "type": "cppdbg",
            "request": "launch",
            "program": "\${fileDirname}/a.out",
            "args": [],
            "stopAtEntry": false,
            "cwd": "\${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "C/C++: g++ build active file",
            "miDebuggerPath": "/usr/bin/gdb"
        }
    ]
}
EOF
	echo "launch.json created."
}

MacCreateLaunch() {
	cat > launch.json <<EOF
{
	// Mac version.
	"version": "0.2.0",
	"configurations": [
		{
			"name": "g++ - Build and debug active file",
			"type": "cppdbg",
			"request": "launch",
			"program": "\${fileDirname}/a.out",
			"args": [
			],
			"cwd": "\${workspaceFolder}",
			"externalConsole": true,
			"MIMode": "lldb",
			"preLaunchTask": "C/C++: g++ build active file",
			"setupCommands": [ { "text": "set startup-with-shell enable"}]
		}
	]
}
EOF
	echo "launch.json created."
}

WinCreateTasks() {
	cat > tasks.json <<EOF
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "C/C++: g++ build active file",
            "type": "shell",
            "command": "/usr/bin/g++",
            "args": [
                "-Wall",
                "-std=c++11",
                "-g",
                "\${workspaceFolder}/*.cpp",
                "-o",
                "\${workspaceFolder}/a.out"
            ]
        }
    ],
}
EOF
	echo "tasks.json created."
}

MacCreateTasks() {
	cat > tasks.json <<EOF
{
    "tasks": [
		{
			"type": "shell",
			"label": "Open Terminal",
			"command": "osascript -e 'tell application \"Terminal\"\ndo script \"echo hello\"\nend tell'",
			"problemMatcher": []
		},
        {
            "type": "shell",
            "label": "C/C++: g++ build active file",
            "command": "/usr/bin/g++",
            "args": [
				"-Wall",
				"-std=c++11",
                "-g",
                "*.cpp",
                "-o",
                "./a.out"
            ],
            "options": {
                "cwd": "\${workspaceFolder}"
            },
            "problemMatcher": [
                "$gcc"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ],
    "version": "2.0.0"
}
EOF
	echo "tasks.json created."
}

if [ $machine == "Mac" ]
then
	MacCreateTasks
	MacCreateLaunch
else
	WinCreateTasks
	WinCreateLaunch
fi

cat > settings.json <<EOF
{
    "files.exclude": {
        "**/a.out": true
    }
}
EOF
echo "settings.json created."

echo "Project" $project "created."
read -p "Hit enter to exit:" dummy
