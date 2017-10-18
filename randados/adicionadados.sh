#!/bin/bash
echo **************************************************
echo *****#########******##**************##************
echo *****##**************##************##*************
echo *****##***************##**********##**************
echo *****##****************##********##***************
echo *****##*****************##******##****************
echo *****##******************##****##*****************
echo *****##*******************##**##******************
echo *****#########*************####*******************
echo **************************************************

ini=$(date +%s)
psql -h localhost -d casavalor -U postgres -p 5432 -a -w -f pais.sql
fim=$(date +%s)
dif=$((ini - fim))
echo "tempo: $dif"
echo **************************************************
ini=$(date +%s)
psql -h localhost -d casavalor -U postgres -p 5432 -a -w -f estado.sql
fim=$(date +%s)
dif=$((ini - fim))
echo "tempo: $dif"
echo **************************************************
ini=$(date +%s)
psql -h localhost -d casavalor -U postgres -p 5432 -a -w -f cidade.sql
fim=$(date +%s)
dif=$((ini - fim))
echo "tempo: $dif"
echo **************************************************
ini=$(date +%s)
psql -h localhost -d casavalor -U postgres -p 5432 -a -w -f Endereco.sql
fim=$(date +%s)
dif=$((ini - fim))
echo "tempo: $dif"
echo **************************************************
ini=$(date +%s)
psql -h localhost -d casavalor -U postgres -p 5432 -a -w -f categoria.sql
fim=$(date +%s)
dif=$((ini - fim))
echo "tempo: $dif"
echo **************************************************
ini=$(date +%s)
psql -h localhost -d casavalor -U postgres -p 5432 -a -w -f imovel.sql
fim=$(date +%s)
dif=$((ini - fim))
echo "tempo: $dif"
echo **************************************************
