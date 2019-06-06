From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH] net/ip_sock: ioctl: fix unsafe accesses from/to userspace
Date: Thu,  6 Jun 2019 14:42:37 +0200
Message-Id: <20190606124237.5206-1-sebastian.smolorz@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com
Cc: xenomai@xenomai.org

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
=2D--
 kernel/drivers/net/stack/ipv4/ip_sock.c | 127 ++++++++++++++++--------
 1 file changed, 88 insertions(+), 39 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/ip_sock.c b/kernel/drivers/net/=
stack/ipv4/ip_sock.c
index 20f27feff..1ae3a9eeb 100644
=2D-- a/kernel/drivers/net/stack/ipv4/ip_sock.c
+++ b/kernel/drivers/net/stack/ipv4/ip_sock.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2003       Hans-Peter Bock <hpbock@avaapgh.de>
  *                2004, 2005 Jan Kiszka <jan.kiszka@web.de>
+ *                2019       Sebastian Smolorz <sebastian.smolorz@gmx.de>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -28,11 +29,11 @@
 #include <rtnet_socket.h>


-int rt_ip_setsockopt(struct rtsocket *s, int level, int optname,
-		     const void *optval, socklen_t optlen)
+int rt_ip_setsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
+		     int optname, const void __user *optval, socklen_t optlen)
 {
     int err =3D 0;
-
+    unsigned int _tos, *tos;

     if (level !=3D SOL_IP)
 	return -ENOPROTOOPT;
@@ -42,7 +43,11 @@ int rt_ip_setsockopt(struct rtsocket *s, int level, int=
 optname,

     switch (optname) {
 	case IP_TOS:
-	    s->prot.inet.tos =3D *(unsigned int *)optval;
+	    tos =3D rtnet_get_arg(fd, &_tos, optval, sizeof(_tos));
+	    if (IS_ERR(tos))
+		return PTR_ERR(tos);
+	    else
+		s->prot.inet.tos =3D *tos;
 	    break;

 	default:
@@ -55,19 +60,29 @@ int rt_ip_setsockopt(struct rtsocket *s, int level, in=
t optname,



-int rt_ip_getsockopt(struct rtsocket *s, int level, int optname,
-		     void *optval, socklen_t *optlen)
+int rt_ip_getsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
+		     int optname, void __user *optval,
+		     socklen_t __user *optlen)
 {
     int err =3D 0;
+    unsigned int tos;
+    socklen_t _len, *len;

+    len =3D rtnet_get_arg(fd, &_len, optlen, sizeof(_len));
+    if (IS_ERR(len))
+	return PTR_ERR(len);

-    if (*optlen < sizeof(unsigned int))
+    if (*len < sizeof(unsigned int))
 	return -EINVAL;

     switch (optname) {
 	case IP_TOS:
-	    *(unsigned int *)optval =3D s->prot.inet.tos;
-	    *optlen =3D sizeof(unsigned int);
+	    tos =3D s->prot.inet.tos;
+	    err =3D rtnet_put_arg(fd, optval, &tos, sizeof(tos));
+	    if (!err) {
+		*len =3D sizeof(unsigned int);
+		err =3D rtnet_put_arg(fd, optlen, len, sizeof(socklen_t));
+	    }
 	    break;

 	default:
@@ -80,72 +95,106 @@ int rt_ip_getsockopt(struct rtsocket *s, int level, i=
nt optname,



-int rt_ip_getsockname(struct rtsocket *s, struct sockaddr *addr,
-		      socklen_t *addrlen)
+int rt_ip_getsockname(struct rtdm_fd *fd, struct rtsocket *s,
+		      struct sockaddr __user *addr,
+		      socklen_t __user *addrlen)
 {
-    struct sockaddr_in *usin =3D (struct sockaddr_in *)addr;
+    struct sockaddr_in _sin;
+    socklen_t *len, _len;
+    int ret;

+    len =3D rtnet_get_arg(fd, &_len, addrlen, sizeof(_len));
+    if (IS_ERR(len))
+	return PTR_ERR(len);

-    if (*addrlen < sizeof(struct sockaddr_in))
+    if (*len < sizeof(struct sockaddr_in))
 	return -EINVAL;

-    usin->sin_family      =3D AF_INET;
-    usin->sin_addr.s_addr =3D s->prot.inet.saddr;
-    usin->sin_port        =3D s->prot.inet.sport;
-
-    memset(usin->sin_zero, 0, sizeof(usin->sin_zero));
+    _sin.sin_family      =3D AF_INET;
+    _sin.sin_addr.s_addr =3D s->prot.inet.saddr;
+    _sin.sin_port        =3D s->prot.inet.sport;
+    memset(&_sin.sin_zero, 0, sizeof(_sin.sin_zero));
+    ret =3D rtnet_put_arg(fd, addr, &_sin, sizeof(_sin));
+    if (ret)
+	return ret;

-    *addrlen =3D sizeof(struct sockaddr_in);
+    *len =3D sizeof(struct sockaddr_in);
+    ret =3D rtnet_put_arg(fd, addrlen, len, sizeof(socklen_t));

-    return 0;
+    return ret;
 }



-int rt_ip_getpeername(struct rtsocket *s, struct sockaddr *addr,
-		      socklen_t *addrlen)
+int rt_ip_getpeername(struct rtdm_fd *fd, struct rtsocket *s,
+		      struct sockaddr __user *addr,
+		      socklen_t __user *addrlen)
 {
-    struct sockaddr_in *usin =3D (struct sockaddr_in *)addr;
+    struct sockaddr_in _sin;
+    socklen_t *len, _len;
+    int ret;

+    len =3D rtnet_get_arg(fd, &_len, addrlen, sizeof(_len));
+    if (IS_ERR(len))
+	return PTR_ERR(len);

-    if (*addrlen < sizeof(struct sockaddr_in))
+    if (*len < sizeof(struct sockaddr_in))
 	return -EINVAL;

-    usin->sin_family      =3D AF_INET;
-    usin->sin_addr.s_addr =3D s->prot.inet.daddr;
-    usin->sin_port        =3D s->prot.inet.dport;
+    _sin.sin_family      =3D AF_INET;
+    _sin.sin_addr.s_addr =3D s->prot.inet.daddr;
+    _sin.sin_port        =3D s->prot.inet.dport;
+    memset(&_sin.sin_zero, 0, sizeof(_sin.sin_zero));
+    ret =3D rtnet_put_arg(fd, addr, &_sin, sizeof(_sin));
+    if (ret)
+	return ret;

-    memset(usin->sin_zero, 0, sizeof(usin->sin_zero));
+    *len =3D sizeof(struct sockaddr_in);
+    ret =3D rtnet_put_arg(fd, addrlen, len, sizeof(socklen_t));

-    *addrlen =3D sizeof(struct sockaddr_in);
-
-    return 0;
+    return ret;
 }



-int rt_ip_ioctl(struct rtdm_fd *fd, int request, void *arg)
+int rt_ip_ioctl(struct rtdm_fd *fd, int request, void __user *arg)
 {
     struct rtsocket *sock =3D rtdm_fd_to_private(fd);
-    struct _rtdm_getsockaddr_args   *getaddr =3D arg;
-    struct _rtdm_getsockopt_args    *getopt  =3D arg;
-    struct _rtdm_setsockopt_args    *setopt  =3D arg;
+    struct _rtdm_getsockaddr_args   _getaddr, *getaddr;
+    struct _rtdm_getsockopt_args    _getopt, *getopt;
+    struct _rtdm_setsockopt_args    _setopt, *setopt;


     switch (request) {
 	case _RTIOC_SETSOCKOPT:
-	    return rt_ip_setsockopt(sock, setopt->level, setopt->optname,
+	    setopt =3D rtnet_get_arg(fd, &_setopt, arg, sizeof(_setopt));
+	    if (IS_ERR(setopt))
+		return PTR_ERR(setopt);
+
+	    return rt_ip_setsockopt(fd, sock, setopt->level, setopt->optname,
 				    setopt->optval, setopt->optlen);

 	case _RTIOC_GETSOCKOPT:
-	    return rt_ip_getsockopt(sock, getopt->level, getopt->optname,
+	    getopt =3D rtnet_get_arg(fd, &_getopt, arg, sizeof(_getopt));
+	    if (IS_ERR(getopt))
+		return PTR_ERR(getopt);
+
+	    return rt_ip_getsockopt(fd, sock, getopt->level, getopt->optname,
 				    getopt->optval, getopt->optlen);

 	case _RTIOC_GETSOCKNAME:
-	    return rt_ip_getsockname(sock, getaddr->addr, getaddr->addrlen);
+	    getaddr =3D rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
+	    if (IS_ERR(getaddr))
+		return PTR_ERR(getaddr);
+
+	    return rt_ip_getsockname(fd, sock, getaddr->addr, getaddr->addrlen);

 	case _RTIOC_GETPEERNAME:
-	    return rt_ip_getpeername(sock, getaddr->addr, getaddr->addrlen);
+	    getaddr =3D rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
+	    if (IS_ERR(getaddr))
+		return PTR_ERR(getaddr);
+
+	    return rt_ip_getpeername(fd, sock, getaddr->addr, getaddr->addrlen);

 	default:
 	    return rt_socket_if_ioctl(fd, request, arg);
=2D-
2.19.1


