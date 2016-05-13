docker pull ubuntu:14.04
cd gecode-4.0.0
docker build -t gecode:4.0.0 .
cd ..
cd GSPMCP
docker build -t gspmcp .
cd CPSM
docker build -t cpsm .
cd ..
