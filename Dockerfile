FROM ubuntu:20.04

# Use the latest available version of python3 and pip
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3=3.8.2-0ubuntu2 python3-pip=20.0.2-5ubuntu1 && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Pin versions in pip install and use no-cache-dir
RUN pip3 install --no-cache-dir flask==1.1.2

COPY app.py /opt/
RUN chown -R appuser:appgroup /opt/

USER appuser  # Run as non-root user

# Use JSON notation for ENTRYPOINT
ENTRYPOINT ["flask", "run", "--host=0.0.0.0", "--port=8080"]