# tauri-developer-template-in-docker

Place your app in the tauri-docker directory or modify the docker-compose file to link your root app directory to the /tauri folder inside the Docker container.

You need to use X11 and add non-network local connections to the access control list by executing the following command on your GNU/Linux host machine:
```bash
xhost +local:*
```

## DEV
To synchronize and rebuild your app live, use this command:
```bash
sudo docker compose up --watch
```

To build your Tauri app in a container, use this command:
```bash
sudo docker compose up --build
```
