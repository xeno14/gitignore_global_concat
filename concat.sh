#!/bin/bash

dst=".gitignore_global"
echo -n > $dst
\ls -1 ./gitignore/Global/*.gitignore | while read gitignore; do
  echo "##" >> $dst
  echo "## ${gitignore}" >> $dst
  echo "##" >> $dst
  cat $gitignore >> $dst
  echo "" >> $dst
done
