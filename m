From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
MIME-Version: 1.0
Date: Mon, 07 Dec 2020 11:58:35 +0100
Subject: =?utf-8?q?=5BPatch?==?utf-8?q?_2=2F5=5D?= Problems with upstream
 SPECTRE mitigation found in =?utf-8?q?sendmsg=2Frecvmsg?=  syscalls
Message-ID: <1174-5fce0b00-6d-37e14c00@74918219>
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

Add copy=5Ffrom=5Fuser call on struct user=5Fmsghdr in case fd is a use=
r fd.

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
---
 kernel/drivers/can/rtcan=5Fraw.c    | 37 +++++++++++++++++++++++++++++=
--------
 1 file changed, 29 insertions(+), 8 deletions(-)
 
diff --git a/kernel/drivers/can/rtcan=5Fraw.c b/kernel/drivers/can/rtca=
n=5Fraw.c
index 693b927..ef05ae2 100644
--- a/kernel/drivers/can/rtcan=5Fraw.c
+++ b/kernel/drivers/can/rtcan=5Fraw.c
@@ -527,12 +527,12 @@ do {									\
 } while (0)
 
 ssize=5Ft rtcan=5Fraw=5Frecvmsg(struct rtdm=5Ffd *fd,
-			  struct user=5Fmsghdr *msg, int flags)
+			  struct user=5Fmsghdr *u=5Fmsg, int flags)
 {
     struct rtcan=5Fsocket *sock =3D rtdm=5Ffd=5Fto=5Fprivate(fd);
     struct sockaddr=5Fcan scan;
     nanosecs=5Frel=5Ft timeout;
-    struct iovec *iov =3D (struct iovec *)msg->msg=5Fiov;
+    struct iovec *iov;
     struct iovec iov=5Fbuf;
     can=5Fframe=5Ft frame;
     nanosecs=5Fabs=5Ft timestamp =3D 0;
@@ -543,8 +543,17 @@ ssize=5Ft rtcan=5Fraw=5Frecvmsg(struct rtdm=5Ffd *=
fd,
     size=5Ft first=5Fpart=5Fsize;
     size=5Ft payload=5Fsize;
     rtdm=5Flockctx=5Ft lock=5Fctx;
+	struct user=5Fmsghdr =5Fmsg, *msg;
     int ret;
 
+    if (rtdm=5Ffd=5Fis=5Fuser(fd)) {
+        if ((ret =3D rtdm=5Fcopy=5Ffrom=5Fuser(fd, & =5Fmsg, u=5Fmsg, =
sizeof (struct user=5Fmsghdr))) !=3D 0)
+            return -ret;
+        else
+            msg =3D & =5Fmsg;
+    } else
+        msg =3D u=5Fmsg;
+
     /* Clear frame memory location */
     memset(&frame, 0, sizeof(can=5Fframe=5Ft));
 
@@ -582,7 +591,8 @@ ssize=5Ft rtcan=5Fraw=5Frecvmsg(struct rtdm=5Ffd *f=
d,
 	    return -EFAULT;
 
 	iov =3D &iov=5Fbuf;
-    }
+    } else
+        iov =3D (struct iovec *)msg->msg=5Fiov;
 
     /* Check size of buffer */
     if (iov->iov=5Flen < sizeof(can=5Fframe=5Ft))
@@ -763,12 +773,12 @@ ssize=5Ft rtcan=5Fraw=5Frecvmsg(struct rtdm=5Ffd =
*fd,
 
 
 ssize=5Ft rtcan=5Fraw=5Fsendmsg(struct rtdm=5Ffd *fd,
-			  const struct user=5Fmsghdr *msg, int flags)
+			  const struct user=5Fmsghdr *u=5Fmsg, int flags)
 {
     struct rtcan=5Fsocket *sock =3D rtdm=5Ffd=5Fto=5Fprivate(fd);
-    struct sockaddr=5Fcan *scan =3D (struct sockaddr=5Fcan *)msg->msg=5F=
name;
+    struct sockaddr=5Fcan *scan;
     struct sockaddr=5Fcan scan=5Fbuf;
-    struct iovec *iov =3D (struct iovec *)msg->msg=5Fiov;
+    struct iovec *iov;
     struct iovec iov=5Fbuf;
     can=5Fframe=5Ft *frame;
     can=5Fframe=5Ft frame=5Fbuf;
@@ -776,10 +786,19 @@ ssize=5Ft rtcan=5Fraw=5Fsendmsg(struct rtdm=5Ffd =
*fd,
     nanosecs=5Frel=5Ft timeout =3D 0;
     struct tx=5Fwait=5Fqueue tx=5Fwait;
     struct rtcan=5Fdevice *dev;
+	struct user=5Fmsghdr =5Fmsg;
+	const struct user=5Fmsghdr *msg;
     int ifindex =3D 0;
     int ret  =3D 0;
     spl=5Ft s;
 
+    if (rtdm=5Ffd=5Fis=5Fuser(fd)) {
+        if ((ret =3D rtdm=5Fcopy=5Ffrom=5Fuser(fd, & =5Fmsg, u=5Fmsg, =
sizeof (struct user=5Fmsghdr))) !=3D 0)
+            return -ret;
+        else
+            msg =3D & =5Fmsg;
+    } else
+        msg =3D u=5Fmsg;
 
     if (flags & MSG=5FOOB)   /* Mirror BSD error message compatibility=
 */
 	return -EOPNOTSUPP;
@@ -821,7 +840,8 @@ ssize=5Ft rtcan=5Fraw=5Fsendmsg(struct rtdm=5Ffd *f=
d,
 		return -EFAULT;
 
 	    scan =3D &scan=5Fbuf;
-	}
+	} else
+        scan =3D (struct sockaddr=5Fcan *)msg->msg=5Fname;
 
 	/* Check address family */
 	if (scan->can=5Ffamily !=3D AF=5FCAN)
@@ -839,7 +859,8 @@ ssize=5Ft rtcan=5Fraw=5Fsendmsg(struct rtdm=5Ffd *f=
d,
 	    return -EFAULT;
 
 	iov =3D &iov=5Fbuf;
-    }
+    } else
+        iov =3D (struct iovec *)msg->msg=5Fiov;
 
     /* Check size of buffer */
     if (iov->iov=5Flen !=3D sizeof(can=5Fframe=5Ft))


