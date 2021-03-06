## Assetto Corsa Server Docker image

### About
Docker image for installing Assetto Corsa server with Steam CLI - user credentials are provided with build phase
After AC Server installation, [ACServerManager](https://github.com/jo3stevens/ACServerManager) is installed to provide 
web GUI for server management. It is also possible to provide additional content by mounting content directory as volume.

### Requirements
- Docker

### Build Image
1. Replace build-args with credentials:
    - `[STEAM_USER]` - steam user with Assetto Corsa available in library
    - `[STEAM_PASS]` - password for that steam account
    - `[STEAM_CODE]` - token generated in steam mobile app
    
    `docker build --build-arg STEAM_USER=[STEAM_USER] --build-arg STEAM_PASS=[STEAM_PASSWORD] --build-arg STEAM_CODE=[STEAM_CODE] -t acserver .`
1. Run command and wait for build to finish

### Install
1. Create `content` directory and copy all additional content that should be available on server into it
1. Replace command env params with server settings:   
    - `[USER]` - user name for ac manager console admin
    - `[PASS]` - password for ac manager console admin
    - `[PORT]` - port on which server management console will be available
    - `[CONTENT]` - path to `content` directory with additional tracks and cars
1. Run docker run command 
   `docker run --rm -p [PORT]:[PORT] -e ACM_USER=[USER] -e ACM_PASS=[PASS] -e ACM_PORT=[PORT] -v [CONTENT]:/tmp/content`