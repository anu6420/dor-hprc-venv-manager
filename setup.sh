
rootdir=$PWD

cp src/activate_venv.template activate_venv
cp src/list_venvs.template list_venvs
cp src/create_venv.template create_venv
cp src/delete_venv.template delete_venv

sed -i "s|<BINDIR>|${rootdir}/bin|"  activate_venv 
sed -i "s|<LOGDIR>|${rootdir}/logs|" activate_venv
sed -i "s|<LOGDIR>|${rootdir}/logs|" list_venvs
sed -i "s|<LOGDIR>|${rootdir}/logs|" create_venv
sed -i "s|<LOGDIR>|${rootdir}/logs|" delete_venv


mkdir -p bin
mv activate_venv create_venv src/json_to_command  list_venvs delete_venv  ${rootdir}/bin/

#setup log directory
mkdir -p ${rootdir}/logs
touch ${rootdir}/logs/venv.log 
chmod uog+rw ${rootdir}/logs/venv.log 
