#!/bin/bash

# Update package list and upgrade installed packages
pkg update -y
pkg upgrade -y

# Install Node.js (which includes npm)
pkg install nodejs -y

# Install Firebase CLI globally
npm install -g firebase-tools

# Log in to Firebase (you may need to interactively log in)
firebase login
