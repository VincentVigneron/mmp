====== Install docker ======
linux: https://docs.docker.com/engine/installation/ubuntulinux/
mac: https://docs.docker.com/v1.8/installation/mac/

====== Install ======
cd PATHTODOCKER/Docker
sudo ./install.sh

====== Run ======
sudo docker run --rm \
                -v ABSOLUTEPATHTODATA:/data \
                -v ABSOLUTEPATHTORESULTS:/results \
                ubuntu:GSPMCP /bin/GSPMCP \
                /data/instancename 1 1 -o /results/outpufile

===== Example ======
sudo docker run --rm \
                -v /home/vigneron/Docker/my_data:/data \
                -v /home/vigneron/Docker/my_results:/results \
                 ubuntu:GSPMCP /bin/GSPMCP \
                 /data/leap.txt 1 1 -o /results/leap.res

===== Example ======
sudo docker run --rm \
                -v /home/vigneron/Docker/my_data:/data \
                -v /home/vigneron/Docker/my_results:/results \
                 ubuntu:CSPM /bin/cspm \
                 /data/leap.txt 0.5

===== GSPMCP Help ======
sudo docker run --rm ubuntu:GSPMCP /bin/GSPMCP /data/instancename

===== CPSM Help ======
sudo docker run --rm ubuntu:CPSM /bin/cpsm --help
sudo docker run --rm ubuntu:CPSM /bin/cpsm_emb --help




====== Allowing non-root users (optional) ======
linux: https://docs.oracle.com/cd/E52668_01/E54669/html/section_rdz_hmw_2q.html
