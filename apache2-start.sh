#!/bin/bash
# Execute apache2 on foreground
# Author : Kaushal Kishore <kaushal.rahuljaiswal@gmail.com>
source /etc/apache2/envvars
exec apache2 -D FOREGROUND
