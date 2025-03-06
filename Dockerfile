FROM oryd/kratos

# Copy the configuration file
COPY kratos.yml /etc/config/kratos.yml

# Copy the identity schema file
COPY identity.schema.json /etc/config/identity.schema.json

# Create a script to run migrations and then start the server
COPY <<EOF /run.sh
#!/bin/sh
kratos migrate sql -y --config /etc/config/kratos.yml
kratos serve --config /etc/config/kratos.yml
EOF

RUN chmod +x /run.sh

# Set the entrypoint to the script
ENTRYPOINT ["/run.sh"] 