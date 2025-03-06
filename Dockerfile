FROM oryd/kratos

# Copy the configuration file
COPY kratos.yml /etc/config/kratos.yml

# Copy the identity schema file
COPY identity.schema.json /etc/config/identity.schema.json

# Create a shell script to run migrations and then start the server
RUN echo '#!/bin/sh\n\
kratos migrate sql -y --config /etc/config/kratos.yml\n\
exec kratos serve --config /etc/config/kratos.yml\n\
' > /run.sh && chmod +x /run.sh

# Set the entrypoint to the script
ENTRYPOINT ["/run.sh"] 