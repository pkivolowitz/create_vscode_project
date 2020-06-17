#!/bin/bash
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
                "cwd": ""
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

cat > launch.json <<EOF
{
	// Use IntelliSense to learn about possible attributes.
	// Hover to view descriptions of existing attributes.
	// For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
	"version": "0.2.0",
	"configurations": [
		{
			"name": "g++ - Build and debug active file",
			"type": "cppdbg",
			"request": "launch",
			"program": "\$fileDirname}/a.out",
			"args": [
			],
			"cwd": "\${workspaceFolder}"
			"externalConsole": true,
			"MIMode": "lldb",
			"preLaunchTask": "C/C++: g++ build active file",
			"setupCommands": [ { "text": "set startup-with-shell enable"}]
		}
	]
}
EOF
echo "launch.json created."

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
