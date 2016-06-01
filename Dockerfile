# <DOCKER_FROM>  # Warning: text inside the DOCKER_FROM tags is auto-generated. Manual changes will be overwritten.
FROM aldryn/base-project:3.1.0
# </DOCKER_FROM>
ENV PYTHONPATH=/app/py_src:$PYTHONPATH
# add gettext for manage.py makemessages
RUN apt-get update && apt-get install -y gettext && apt-get clean && rm -rf /var/lib/apt/lists/*

# node modules
# ------------
# package.json is put into / so that mounting /app for local development
# does not require re-running npm install
ENV PATH=/node_modules/.bin:$PATH
RUN npm install -g npm-install-retry
COPY package.json /
RUN (cd / && npm-install-retry -- --production)
