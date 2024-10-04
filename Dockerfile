FROM ubuntu:20.04
RUN apt-get update && apt-get install -y python3 python3-pip
RUN groupadd -r appgroup && useradd -r -g appgroup appuser
RUN pip3 install flask
COPY app.py /opt/
RUN chown -R appuser:appgroup /opt/
USER appuser  # Run as non-root user
ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080
