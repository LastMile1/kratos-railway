# Ory Kratos on Railway

This repository contains the necessary files to deploy Ory Kratos, a headless cloud-native authentication and identity management system, on Railway.

## Files

- `kratos.yml`: Configuration file for Ory Kratos
- `identity.schema.json`: Schema file defining the structure of user identities
- `Dockerfile`: Custom Dockerfile to build the Ory Kratos image with our configuration

## Deployment Instructions

### Prerequisites

- A Railway account
- A PostgreSQL database already set up on Railway

### Steps to Deploy

1. Fork this repository to your GitHub account.
2. In Railway, create a new service by selecting "Deploy from GitHub" and choose your forked repository.
3. Set the service name to `kratos` (or your preferred name).
4. Configure the following environment variables:
   - `DSN`: Set to your PostgreSQL connection string, e.g., `postgresql://kratos:password@db:5432/kratos?sslmode=disable`
     - Replace `db` with your PostgreSQL service name in Railway
     - Replace `password` with your actual database password
   - `SECRETS_COOKIE`: Set to a secure random string (generate with `openssl rand -base64 22`)
   - `SECRETS_CIPHER`: Set to another secure random string (generate with `openssl rand -base64 22`)
5. Optionally, expose ports 4433 (public API) and 4434 (admin API) if you need direct access.

### Database Setup

Ensure your PostgreSQL database is properly set up:

1. Create a database named `kratos`:
   ```sql
   CREATE DATABASE kratos;
   ```
2. Create a user for Kratos:
   ```sql
   CREATE USER kratos WITH PASSWORD 'your_password';
   ```
3. Set password encryption:
   ```sql
   ALTER SYSTEM SET password_encryption = 'scram-sha-256';
   SELECT pg_reload_conf();
   ```
4. Grant access to the database:
   ```sql
   GRANT ALL PRIVILEGES ON DATABASE kratos TO kratos;
   ```

### Connecting to Your Frontend

After deployment, you'll need to update the UI URLs in `kratos.yml` to point to your actual frontend application. You can do this by:

1. Updating the configuration file in this repository
2. Redeploying the service

## Security Considerations

- Never hardcode secrets in the configuration files
- Use environment variables for all sensitive information
- Consider using a reverse proxy (like NGINX) for production deployments
- Regularly update the Ory Kratos image to get security patches

## Additional Resources

- [Ory Kratos Documentation](https://www.ory.sh/docs/kratos)
- [Railway Documentation](https://docs.railway.app/) 