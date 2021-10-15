# Configuration examples

### Domain
```
service:
  ...
  labels:
    traefik.enable: 'true'
    traefik.http.routers.${PROJECT}-service.rule: 'Host(`${DOMAIN}`)'
```

### Domain and path
```
service-path:
  ...
  labels:
    traefik.enable: 'true'
    traefik.http.routers.${PROJECT}-service-path.rule: 'Host(`${DOMAIN}`) && PathPrefix(`/path`)'
```

### Tracking another port
```
mailcatcher:
  ...
  labels:
    traefik.enable: 'true'
    traefik.http.services.${PROJECT}-mailcatcher.loadbalancer.server.port: '1080'
    traefik.http.routers.${PROJECT}-mailcatcher.rule: 'Host(`mail.${DOMAIN}`)'
```

### SSL local certificate
```
service:
  ...
  labels:
    traefik.enable: 'true'
    traefik.http.middlewares.redirect-to-https.redirectscheme.scheme: 'https'

    traefik.http.routers.${PROJECT}-service.rule: 'Host(`${DOMAIN}`)'
    traefik.http.routers.${PROJECT}-service.middlewares: 'redirect-to-https'

    traefik.http.routers.${PROJECT}-service-tls.rule: 'Host(`${DOMAIN}`)'
    traefik.http.routers.${PROJECT}-service-tls.tls: 'true'
```

### SSL Let's Encrypt certificate
```
service:
  ...
  labels:
    traefik.enable: 'true'
    traefik.http.middlewares.redirect-to-https.redirectscheme.scheme: 'https'
    
    traefik.http.routers.${PROJECT}-service.rule: 'Host(`${DOMAIN}`)'
    traefik.http.routers.${PROJECT}-service.middlewares: 'redirect-to-https'
    
    traefik.http.routers.${PROJECT}-service-tls.rule: 'Host(`${DOMAIN}`)'
    traefik.http.routers.${PROJECT}-service-tls.tls: 'true'
    traefik.http.routers.${PROJECT}-service-tls.tls.certResolver: 'acmeresolver'
```

# Example middleware

### Redirect from http to https 
```
service:
  ...
  labels:
    traefik.enable: 'true'

    traefik.http.middlewares.redirect-to-https.redirectscheme.scheme: 'https'
    traefik.http.routers.${PROJECT}-service.middlewares: 'redirect-to-https'
```

### Basic auth
```
service:
  ...
  labels:
    traefik.enable: 'true'

    traefik.http.middlewares.${PROJECT}-service-basicauth.basicauth.users: '${BASIC_AUTH}'
    traefik.http.middlewares.${PROJECT}-service-basicauth.basicauth.removeheader: 'true'

    traefik.http.routers.${PROJECT}-service.middlewares: '${PROJECT}-service-basicauth'
```

### Multiple middlewares
```
service:
  ...
  labels:
    traefik.enable: 'true'

    traefik.http.middlewares.redirect-to-https.redirectscheme.scheme: 'https'
    traefik.http.middlewares.${PROJECT}-service-basicauth.basicauth.users: '${BASIC_AUTH}'
    traefik.http.middlewares.${PROJECT}-service-basicauth.basicauth.removeheader: 'true'

    traefik.http.routers.${PROJECT}-service.middlewares: 'redirect-to-https, ${PROJECT}-service-basicauth'
```

## More information

[https://doc.traefik.io/traefik/](https://doc.traefik.io/traefik/)
