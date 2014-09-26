#! /bin/bash
DATA_DIR=${DATA_DIR:/var/lib/wiki_data}
SETTINGS_DIR=${DATA_DIR}/settings
IMAGES_DIR=${DATA_DIR}/images
WIKI_DIR=/var/lib/mediawiki
echo DATA_DIR=${DATA_DIR}
#mkdir ${DATA_DIR}
if [ -d ${DATA_DIR} ]; then
    if [ ! -d ${SETTINGS_DIR} ]; then
	mkdir ${SETTINGS_DIR}
    fi
    chown -R www-data:www-data ${SETTINGS_DIR}
    if [ -f ${SETTINGS_DIR}/wiki.png ]; then
        (cd ${WIKI_DIR}/skins/common/images/; mv wiki.png wiki.png.orig)
    else
        mv ${WIKI_DIR}/skins/common/images/wiki.png ${SETTINGS_DIR}/
    fi
    ln -sf ${SETTINGS_DIR}/wiki.png ${WIKI_DIR}/skins/common/images/
    ln -sf ${SETTINGS_DIR}/LocalSettings.php ${WIKI_DIR}/LocalSettings.php
    if [ ! -d ${IMAGES_DIR} ]; then
        cp -a ${WIKI_DIR}/images ${IMAGES_DIR}
    fi
    mv ${WIKI_DIR}/images ${WIKI_DIR}/images.orig
    ln -sf ${IMAGES_DIR} ${WIKI_DIR}/images
    chown -R www-data:www-data ${IMAGES_DIR}
    chmod -R 775 ${IMAGES_DIR}

    if [ -d ${DATA_DIR}/mysql ]; then
	mv /var/lib/mysql /var/lib/mysql.orig
        ln -sf  ${DATA_DIR}/mysql /var/lib/mysql
    else
	mv /var/lib/mysql ${DATA_DIR}/mysql
	ln -sf ${DATA_DIR}/mysql /var/lib/mysql
    fi
fi
