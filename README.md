# Docker BindDNS

This project provides a Docker container setup for running a **Bind9 DNS** server. Bind9 is a powerful, flexible, and widely-used DNS server that can act as both an authoritative server and a DNS forwarder. This setup allows you to deploy a fully functional Bind9 DNS server within a Docker environment for easy management and portability.

## Features

- **Bind9 DNS Server:** A Dockerized Bind9 DNS server with flexible configuration options.
- **DNS Forwarding and Caching:** Supports DNS forwarding, caching, and recursion.
- **Custom Zones:** Easily set up and manage custom DNS zones for your network.
- **Persistent Configuration:** Bind configuration files and data are stored in persistent Docker volumes to ensure your settings are saved across container restarts.
- **Easy to Use:** Quickly deploy a DNS server using Docker with minimal configuration required.

## Requirements

- [Docker](https://www.docker.com/) installed on your host machine.
- [Docker Compose](https://docs.docker.com/compose/) (optional, for easier setup).

## Installation

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/OddRefrigerator/Docker-BindDNS.git
   cd Docker-BindDNS
   ```

2. Customize the Bind9 configuration as needed. The Bind9 configuration files are located in the `config/` directory:
   - `named.conf`: Main Bind9 configuration file.
   - `named.conf.options`: Options for DNS forwarding, recursion, and general DNS settings.
   - `named.conf.local`: Define custom zones here.

3. Run the container using Docker Compose (recommended) or Docker CLI.

### Docker Compose (recommended)

If you have Docker Compose installed, run the following command to start the Bind9 server:

```bash
docker-compose up -d
```

This will bring up the Bind9 container in the background. The DNS server is now running and accessible.

### Docker CLI

Alternatively, you can run the container directly using the Docker CLI:

```bash
docker run -d \
  --name bind9-dns \
  -v $(pwd)/config:/etc/bind \
  -p 53:53/tcp \
  -p 53:53/udp \
  --restart unless-stopped \
  bind9
```

## Configuration

### DNS Forwarding

By default, Bind9 is set up to act as a DNS forwarder. You can specify the upstream DNS servers to forward queries to by editing the `named.conf.options` file:

```bash
forwarders {
    8.8.8.8;  // Google DNS
    8.8.4.4;  // Google DNS
};
```

You can replace these IPs with the addresses of your preferred DNS servers.

### Custom Zones

To define custom DNS zones for your local network or domain, edit the `named.conf.local` file. Here's an example of setting up a zone for the domain `example.com`:

```bash
zone "example.com" {
    type master;
    file "/etc/bind/db.example.com";
};
```

Make sure to create the corresponding zone file in the `config/` directory (e.g., `db.example.com`).

### Persistent Data

The Bind9 configuration and zone files are mounted from the `config/` directory, allowing you to persist data across container restarts. Any changes made to the files in this directory will be reflected in the running container.

## Usage

Once the container is up and running, you can start querying the DNS server from other devices on your network. Simply configure your devices to use the Docker host's IP address as their DNS server.

Example DNS query using `dig`:

```bash
dig @<docker-host-ip> example.com
```

Replace `<docker-host-ip>` with the IP address of the machine running Docker.

## Stopping and Removing the Container

To stop the container, run:

```bash
docker-compose down
```

Or, if you're using Docker CLI:

```bash
docker stop bind9-dns && docker rm bind9-dns
```

## Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue if you have any improvements or fixes.

### Steps for Contribution

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Description of your feature or fix"
   ```
4. Push your branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request with a detailed explanation of your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any inquiries or issues, feel free to open an issue on GitHub or contact the repository owner.

---

Enjoy your easy-to-deploy Bind9 DNS server in Docker!
