From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
MIME-Version: 1.0
Date: Wed, 16 Dec 2020 09:38:01 +0100
Subject: =?utf-8?q?=5BPatch?==?utf-8?q?_1=2F3=5D?= Problem with upstream
 SPECTRE mitigation found in =?utf-8?q?sendmsg=2Frecvmsg?= syscalls
Message-ID: <1176-5fd9c780-16b-12dbaa60@116805552>
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

This patch has been tested with 4.4.x kernel

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
---
 kernel/drivers/net/stack/packet/af=5Fpacket.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/drivers/net/stack/packet/af=5Fpacket.c b/kernel/dri=
vers/net/stack/packet/af=5Fpacket.c
index b8de8a0..cc74873 100644
--- a/kernel/drivers/net/stack/packet/af=5Fpacket.c
+++ b/kernel/drivers/net/stack/packet/af=5Fpacket.c
@@ -294,7 +294,7 @@ static int rt=5Fpacket=5Fioctl(struct rtdm=5Ffd *fd=
, unsigned int request,
 /***
  *  rt=5Fpacket=5Frecvmsg
  */
-static ssize=5Ft rt=5Fpacket=5Frecvmsg(struct rtdm=5Ffd *fd, struct us=
er=5Fmsghdr *u=5Fmsg,
+static ssize=5Ft rt=5Fpacket=5Frecvmsg(struct rtdm=5Ffd *fd, struct us=
er=5Fmsghdr *msg,
 				 int msg=5Fflags)
 {
 	struct rtsocket *sock =3D rtdm=5Ffd=5Fto=5Fprivate(fd);
@@ -304,14 +304,9 @@ static ssize=5Ft rt=5Fpacket=5Frecvmsg(struct rtdm=
=5Ffd *fd, struct user=5Fmsghdr *u=5Fmsg,
 	struct sockaddr=5Fll sll;
 	int ret, flags;
 	nanosecs=5Frel=5Ft timeout =3D sock->timeout;
-	struct user=5Fmsghdr =5Fmsg, *msg;
 	socklen=5Ft namelen;
 	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
 
-	msg =3D rtnet=5Fget=5Farg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));
-	if (IS=5FERR(msg))
-		return PTR=5FERR(msg);
-
 	if (msg->msg=5Fiovlen < 0)
 		return -EINVAL;
 
@@ -359,7 +354,7 @@ static ssize=5Ft rt=5Fpacket=5Frecvmsg(struct rtdm=5F=
fd *fd, struct user=5Fmsghdr *u=5Fmsg,
 			goto fail;
 
 		namelen =3D sizeof(sll);
-		ret =3D rtnet=5Fput=5Farg(fd, &u=5Fmsg->msg=5Fnamelen, &namelen,
+		ret =3D rtnet=5Fput=5Farg(fd, &msg->msg=5Fnamelen, &namelen,
 				    sizeof(namelen));
 		if (ret)
 			goto fail;
@@ -380,7 +375,7 @@ static ssize=5Ft rt=5Fpacket=5Frecvmsg(struct rtdm=5F=
fd *fd, struct user=5Fmsghdr *u=5Fmsg,
 	if (copy=5Flen > len) {
 		copy=5Flen =3D len;
 		flags =3D msg->msg=5Fflags | MSG=5FTRUNC;
-		ret =3D rtnet=5Fput=5Farg(fd, &u=5Fmsg->msg=5Fflags, &flags,
+		ret =3D rtnet=5Fput=5Farg(fd, &msg->msg=5Fflags, &flags,
 				    sizeof(flags));
 		if (ret)
 			goto fail;
@@ -419,7 +414,6 @@ static ssize=5Ft rt=5Fpacket=5Fsendmsg(struct rtdm=5F=
fd *fd,
 	unsigned char *addr;
 	int ifindex;
 	ssize=5Ft ret;
-	struct user=5Fmsghdr =5Fmsg;
 	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
 
 	if (msg=5Fflags & MSG=5FOOB) /* Mirror BSD error message compatibilit=
y */
@@ -427,10 +421,6 @@ static ssize=5Ft rt=5Fpacket=5Fsendmsg(struct rtdm=
=5Ffd *fd,
 	if (msg=5Fflags & ~MSG=5FDONTWAIT)
 		return -EINVAL;
 
-	msg =3D rtnet=5Fget=5Farg(fd, &=5Fmsg, msg, sizeof(*msg));
-	if (IS=5FERR(msg))
-		return PTR=5FERR(msg);
-
 	if (msg->msg=5Fiovlen < 0)
 		return -EINVAL;


