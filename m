From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
MIME-Version: 1.0
Date: Mon, 07 Dec 2020 12:02:50 +0100
Subject: =?utf-8?q?=5BPatch?==?utf-8?q?_5=2F5=5D?= Problems with upstream
 SPECTRE mitigation found in =?utf-8?q?sendmsg=2Frecvmsg?=  syscalls
Message-ID: <1174-5fce0c00-7b-37e14c00@74953859>
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

Add rtipc=5Fget=5Farg (copy=5Ffrom=5Fser) call on struct user=5Fmsghdr.=


Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
---
 kernel/drivers/ipc/xddp.c         | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
 
diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
index 57275d0..8d52720 100644
--- a/kernel/drivers/ipc/xddp.c
+++ b/kernel/drivers/ipc/xddp.c
@@ -335,12 +335,17 @@ out:
 }
 
 static ssize=5Ft xddp=5Frecvmsg(struct rtdm=5Ffd *fd,
-			    struct user=5Fmsghdr *msg, int flags)
+			    struct user=5Fmsghdr *u=5Fmsg, int flags)
 {
 	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
 	struct sockaddr=5Fipc saddr;
+	struct user=5Fmsghdr =5Fmsg, *msg =3D & =5Fmsg;
 	ssize=5Ft ret;
 
+	ret =3D rtipc=5Fget=5Farg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));
+	if (ret)
+		return -ret;
+
 	if (flags & ~MSG=5FDONTWAIT)
 		return -EINVAL;
 
@@ -590,14 +595,19 @@ done:
 }
 
 static ssize=5Ft xddp=5Fsendmsg(struct rtdm=5Ffd *fd,
-			    const struct user=5Fmsghdr *msg, int flags)
+			    const struct user=5Fmsghdr *u=5Fmsg, int flags)
 {
 	struct rtipc=5Fprivate *priv =3D rtdm=5Ffd=5Fto=5Fprivate(fd);
 	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
 	struct xddp=5Fsocket *sk =3D priv->state;
 	struct sockaddr=5Fipc daddr;
+	struct user=5Fmsghdr =5Fmsg, *msg =3D & =5Fmsg;
 	ssize=5Ft ret;
 
+	ret =3D rtipc=5Fget=5Farg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));
+	if (ret)
+		return -ret;
+
 	/*
 	 * We accept MSG=5FDONTWAIT, but do not care about it, since
 	 * writing to the real-time endpoint of a message pipe must be


