From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Wed, 16 Dec 2020 09:43:23 +0100
Subject: =?utf-8?q?=5BPatch?==?utf-8?q?_2=2F3=5D?= Problem with upstream
 SPECTRE mitigation found in =?utf-8?q?sendmsg=2Frecvmsg?= syscalls
Message-ID: <1176-5fd9c880-16f-12dbaa60@116805618>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>

The RTNET sendmsg/recvmsg protocol handlers used to call copy=5Fto/from=
=5Fuser on the struct user=5Fmsghdr argument. The syscall entry code al=
ready does this copy, so calling again the copy=5Fto/from=5Fuser in han=
dlers triggers SPECTRE mitigation protection. This patch removes the ca=
lls in the handlers

This patch has not been tested

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c     | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/n=
et/stack/ipv4/udp/udp.c
index c26b4bd..546b358 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -386,7 +386,7 @@ int rt=5Fudp=5Fioctl(struct rtdm=5Ffd *fd, unsigned=
 int request, void =5F=5Fuser *arg)
 /***
  *  rt=5Fudp=5Frecvmsg
  */
-ssize=5Ft rt=5Fudp=5Frecvmsg(struct rtdm=5Ffd *fd, struct user=5Fmsghd=
r *u=5Fmsg,
+ssize=5Ft rt=5Fudp=5Frecvmsg(struct rtdm=5Ffd *fd, struct user=5Fmsghd=
r *msg,
 		       int msg=5Fflags)
 {
 	struct rtsocket *sock =3D rtdm=5Ffd=5Fto=5Fprivate(fd);
@@ -400,14 +400,9 @@ ssize=5Ft rt=5Fudp=5Frecvmsg(struct rtdm=5Ffd *fd,=
 struct user=5Fmsghdr *u=5Fmsg,
 	struct sockaddr=5Fin sin;
 	nanosecs=5Frel=5Ft timeout =3D sock->timeout;
 	int ret, flags;
-	struct user=5Fmsghdr =5Fmsg, *msg;
 	socklen=5Ft namelen;
 	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
 
-	msg =3D rtnet=5Fget=5Farg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));
-	if (IS=5FERR(msg))
-		return PTR=5FERR(msg);
-
 	if (msg->msg=5Fiovlen < 0)
 		return -EINVAL;
 
@@ -450,7 +445,7 @@ ssize=5Ft rt=5Fudp=5Frecvmsg(struct rtdm=5Ffd *fd, =
struct user=5Fmsghdr *u=5Fmsg,
 			goto fail;
 
 		namelen =3D sizeof(sin);
-		ret =3D rtnet=5Fput=5Farg(fd, &u=5Fmsg->msg=5Fnamelen, &namelen,
+		ret =3D rtnet=5Fput=5Farg(fd, &msg->msg=5Fnamelen, &namelen,
 				    sizeof(namelen));
 		if (ret)
 			goto fail;
@@ -494,7 +489,7 @@ ssize=5Ft rt=5Fudp=5Frecvmsg(struct rtdm=5Ffd *fd, =
struct user=5Fmsghdr *u=5Fmsg,
 		flags |=3D MSG=5FTRUNC;
 
 	if (flags !=3D msg->msg=5Fflags) {
-		ret =3D rtnet=5Fput=5Farg(fd, &u=5Fmsg->msg=5Fflags, &flags,
+		ret =3D rtnet=5Fput=5Farg(fd, &msg->msg=5Fflags, &flags,
 				    sizeof(flags));
 		if (ret)
 			goto fail;
@@ -588,7 +583,6 @@ ssize=5Ft rt=5Fudp=5Fsendmsg(struct rtdm=5Ffd *fd, =
const struct user=5Fmsghdr *msg,
 	u16 dport;
 	int err;
 	rtdm=5Flockctx=5Ft context;
-	struct user=5Fmsghdr =5Fmsg;
 	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
 
 	if (msg=5Fflags & MSG=5FOOB) /* Mirror BSD error message compatibilit=
y */
@@ -597,10 +591,6 @@ ssize=5Ft rt=5Fudp=5Fsendmsg(struct rtdm=5Ffd *fd,=
 const struct user=5Fmsghdr *msg,
 	if (msg=5Fflags & ~(MSG=5FDONTROUTE | MSG=5FDONTWAIT))
 		return -EINVAL;
 
-	msg =3D rtnet=5Fget=5Farg(fd, &=5Fmsg, msg, sizeof(*msg));
-	if (IS=5FERR(msg))
-		return PTR=5FERR(msg);
-
 	if (msg->msg=5Fiovlen < 0)
 		return -EINVAL;


