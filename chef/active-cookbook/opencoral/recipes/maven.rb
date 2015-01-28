bash "mavenize coral binaries" do
  user 'coral'
  environment 'HOME' => '/home/coral'
  code <<-EOF
  for i in $(find /home/coral/opencoral/dist -name '*jar') ; do
    FILEBASE=$(basename $i .jar);
    /usr/local/maven/bin/mvn install:install-file -Dfile=$i -DgroupId=org.opencoral -DartifactId=opencoral-$FILEBASE  -Dversion=3.4.9 -Dpackaging=jar
  done
EOF
end
