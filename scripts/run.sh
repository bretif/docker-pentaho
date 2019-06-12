touch .install_plugin

if [ ! -f "$PENTAHO_HOME/pentaho-server/pentaho-solutions/.pentaho_pgconfig" ]; then
   bash -x $PENTAHO_HOME/scripts/setup_postgresql.sh
   #HOSTNAME=$(`echo hostname`)

#   sed -i "s/node1/${HOSTNAME}/g" $PENTAHO_HOME/pentaho-server/pentaho-solutions/system/jackrabbit/repository.xml
   touch $PENTAHO_HOME/pentaho-server/pentaho-solutions/.pentaho_pgconfig
fi

if [ ! -f "$PENTAHO_HOME/pentaho-server/pentaho-solutions/.install_plugin" ]; then
   sh $PENTAHO_HOME/scripts/install_plugin.sh
   touch $PENTAHO_HOME/pentaho-server/pentaho-solutions/.install_plugin
fi

if [ -f "./custom_script.sh" ]; then
   . ./custom_script.sh
   mv ./custom_script.sh ./custom_script.sh.bkp
fi

sh $PENTAHO_HOME/pentaho-server/start-pentaho.sh
