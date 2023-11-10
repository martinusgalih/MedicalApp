#!/bin/bash

# Xcodegen Execution
xcodegen --spec project.yml;
# Pod Version
echo "Your pod version : $(pod --version)";

# Pod Install
pod install;

# Open Project
open 'MedicalApp.xcworkspace'
