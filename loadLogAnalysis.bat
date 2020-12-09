cd C:\Users\davinciadmin\stadiumLogAnalysis
sqlplus -s assort1800/gtuiASY1299@stadavp.int.stadium.biz:1521/STADAVP @loadcsv\load.sql
sqlplus -s assort1830/xzytre8913@stadavp.int.stadium.biz:1521/STADAVP @loadcsv\loadoutlet.sql

git config --global user.email "jason.zhuang@davinciretail.com"
git config --global user.name "jasonzhuangdavinci"

git add loadcsv\*
git add *
git commit -m 'commit'
git push