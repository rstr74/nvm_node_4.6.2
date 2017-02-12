FROM rstr74/debian_jessie_base

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


# Install npm modules
RUN npm config set unsafe-perm=true
RUN npm i mocha async request base64-stream -g
RUN npm i bower concat-stream express@4.13.3 -g
RUN npm i express-fileupload file-type gulp -g
RUN npm i html2jade http-server image-size -g
RUN npm i jasmine jasmine-node jshint markdown marked -g
RUN npm i moment moment-range moment-recur moment-spans -g
RUN npm i node-async-runner sequence twix -g
RUN npm i mkdirp body-parser@1.14.2 node-sass@3.4.2 -g

