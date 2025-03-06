FROM oryd/kratos

# Copy the configuration file
COPY kratos.yml /etc/config/kratos.yml

# Copy the identity schema file
COPY identity.schema.json /etc/config/identity.schema.json

# Set the command to run migrations and then start the server
CMD ["bash", "-c", "kratos migrate sql -y && kratos serve --config /etc/config/kratos.yml"] 