#!/bin/bash
kill $(ps -A | awk -r '/'"sleep|proc\.cmd"'/{print $1}')
