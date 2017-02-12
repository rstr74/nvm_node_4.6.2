FROM rstr74/debian_jessie_base

LABEL com.example.is-beta= \
      com.example.is-production="" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2015-02-12"

USER worker

ENV NVM_VERSION 0.31.4
ENV NVM_DIR $WORKER_HOME/.nvm/v$NVM_VERSION
ENV NODE_VERSION 4.6.2

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Set up our PATH correctly so we don't have to long-reference npm, node, &c.
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install pm2 so we can run Node applications
RUN npm i mocha async request base64-stream bower concat-stream express@4.13.3 express-fileupload file-type gulp html2jade http-server image-size jasmine jasmine-node jshint markdown marked moment moment-range moment-recur moment-spans node-async-runner sequence twix mkdirp body-parser@1.14.2 node-sass@3.4.2 -g