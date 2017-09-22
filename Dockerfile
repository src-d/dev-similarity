FROM ubuntu:16.04

ADD profile.ipynb /

RUN echo '#!/bin/bash\n\
\n\
echo\n\
echo "	$@"' > /browser && \
    chmod +x /browser && \
    apt-get update && \
    apt-get install -y python3 curl && \
    curl https://bootstrap.pypa.io/get-pip.py | python3 && \
    pip3 install --no-cache-dir jupyter numpy matplotlib && \
    apt-get remove -y curl && \
    apt-get remove -y *-doc && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV BROWSER /browser
EXPOSE 8888

CMD ["jupyter", "notebook", "--ip", "0.0.0.0", "--allow-root", "/profile.ipynb"]
