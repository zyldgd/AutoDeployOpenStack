#!/bin/bash
############################################################
# @OS: Ubuntu 18.4 server
# @OpenStack version: Rocky
# @description：automatic deployment of openstack environments and services
# @dependencies: stack.conf  common-function.sh
# @author: zyl
# @date: 2019-8-14
# @use:
#   ./deploy.sh [options] [services]
#       options:
#           --help
#

#################### other variables ######################
WORK_PATH=$(dirname $(readlink -f $0))
source $WORK_PATH/src/function-common

if [ $# == 0 ]; then
    echo 'too few arguments, add "--help" for more info'
    exit 1
fi

if [ $1 == '--help' ]; then
    echo  '----------------------------------------------------------'
    echo  'use:'
    echo  '    ./deploy.sh [--help] [services...]'
    echo  ''
    echo  '        --help:  Display help documentation'
    echo  ''
    echo  '        services:'
    echo  '            keystone'
    echo  '            glance'
    echo  '            nova_controller'
    echo  '            nova_compute'
    echo  '            neutron_controller'
    echo  '            neutron_compute'
    echo  '            ironic'
    echo  '            horizon'
    echo  '            odl_controller'
    echo  '            odl_compute'
    echo  '            installationSource'
    echo  '            mysql'
    echo  '            rabbitmq'
    echo  '            memcache'
    echo  '            openstack'
    echo  '            etcd'
    echo  ''
    echo  '        e.g:'
    echo  '            Install and deploy the service of keystone:'
    echo  '                ./deploy.sh keystone'
    echo  '            Install and deploy services of Mysql etcd rabbitmq:'
    echo  '                ./deploy.sh mysql etcd rabbitmq'
    echo  '            download OpenStack:'
    echo  '                ./deploy.sh openstack'
    echo  '----------------------------------------------------------'
    exit 0
fi

initScript
for service in $*; do
    LOG -info -s "deploy service of ${service}"
    case ${service} in
        'keystone')
            installKeystone;;
        'glance')
            installGlance;;
        'nova_controller')
            installNova_controller;;
        'nova_compute')
            installNova_compute;;
        'neutron_controller')
            installNeutron_controller;;
        'neutron_compute')
            installNeutron_compute;;
        'ironic')
            installIronic;;
        'odl_controller')
            integrateODL controller;;
        'odl_compute')
            integrateODL compute;;
        'mysql')
            installMysql;;
        'rabbitmq')
            installRabbitmqctl;;
        'openstack')
            installOpenStackClient;;
        'etcd')
            installEtcd;;
        'memcache')
            installMemcache;;
        'installationSource')
            modifyInstallationSource;;
        'horizon')
            installHorizon;;
    esac
    exit 0
done










