FROM ubuntu:gecode
MAINTAINER Vincent Vigneron <vigneron@info.univ-angers.fr>
RUN cd tmp && wget https://dtai.cs.kuleuven.be/CP4IM/cpsm/cpsm-0.5.tar.gz && tar -xzf cpsm-0.5.tar.gz && rm cpsm-0.5.tar.gz && cd cpsm && find . -name "*.[hc]pp" -exec sed -i 's/float/double/g' {} \; && sed -i 's/minsup = (threshold >= 1)?threshold/minsup = (threshold >= 1)?this->num_trans_init/g' data.cpp && make && mv cpsm /bin && mv cpsm_emb /bin && cd .. && rm -r cpsm  && cd .. && mkdir data && mkdir results
