# AnyoneGuard
### Deploy a Docker container to set up a WireGuard server that routes all client traffic through the Tor network.
### Generate Keys
`$ServerPrivateKey` and `$PeerPublicKey1` needs to be generated and replaced in `docker-compose.yml`, example:
#### Server keys:
```
ServerPrivateKey=$(wg genkey | tee /etc/wireguard/ServerPrivate.key)
ServerPublicKey=$(cat ServerPrivate.key | wg pubkey | tee ServerPublic.key)
chmod go= ServerPrivate.key
```
#### Peer1 keys:
```
PeerPrivateKey1=$(wg genkey | tee PeerPrivate1.key)
PeerPublicKey=$(cat PeerPrivate1.key | wg pubkey | tee PeerPublic1.key)
chmod go= PeerPrivate1.key
```
> [!NOTE]  
> It's advised to only deploy this setup on a server that you trust and control.
> 
##### If needed, make sure the Wireguard Server's `ListenPort = 51828` is reachable from outside the Local Network, only UDP is required.
