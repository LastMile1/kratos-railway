FROM oryd/kratos:v1.0.0

# Copy the configuration file
COPY kratos.yml /etc/config/kratos.yml

# Copy the identity schema file
COPY identity.schema.json /etc/config/identity.schema.json

# Create a shell script to run migrations and then start the server
RUN echo '#!/bin/sh' > /run.sh && \
    echo 'kratos migrate sql -y --config /etc/config/kratos.yml' >> /run.sh && \
    echo 'exec kratos serve --config /etc/config/kratos.yml' >> /run.sh && \
    chmod +x /run.sh

# Set the entrypoint to the script
ENTRYPOINT ["/run.sh"] 