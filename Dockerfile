FROM binwiederhier/ntfy:latest

# Set maintainer info
LABEL maintainer="tuyishimireemmanuel24@gmail.com @gmail.com"
LABEL description="Custom ntfy server with bundled configuration"
LABEL version="1.0"

# Create ntfy user and group for security
RUN addgroup -g 1000 ntfy && \
    adduser -D -s /bin/sh -u 1000 -G ntfy ntfy

# Create necessary directories
RUN mkdir -p /etc/ntfy /var/cache/ntfy /var/lib/ntfy

# Copy configuration file
COPY server.yml /etc/ntfy/server.yml

# Set proper permissions
RUN chown -R ntfy:ntfy /etc/ntfy /var/cache/ntfy /var/lib/ntfy && \
    chmod 644 /etc/ntfy/server.yml && \
    chmod 755 /etc/ntfy /var/cache/ntfy /var/lib/ntfy

# Install bash
USER root
RUN apk add --no-cache bash
USER ntfy

# Expose port
EXPOSE 80

# Use the bundled configuration
CMD ["serve", "--config", "/etc/ntfy/server.yml"]
