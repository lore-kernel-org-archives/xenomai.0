From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
MIME-Version: 1.0
Date: Mon, 07 Dec 2020 11:55:28 +0100
Subject: =?utf-8?q?Fwd=3A?==?utf-8?q?_=5BPatch?==?utf-8?q?_1=2F5=5D?= Problems
 with 
 upstream SPECTRE  mitigation found in =?utf-8?q?sendmsg=2Frecvmsg?= 
 syscalls
Message-ID: <1174-5fce0a00-6b-37e14c00@74918186>
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

Remove the copy of struct struct user=5Fmsghdr onto stack allocated buf=
fer.

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
---
 kernel/cobalt/posix/io.c          | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)
 
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index f35aaf8..85272a5 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -79,18 +79,7 @@ COBALT=5FSYSCALL(write, handover,
 COBALT=5FSYSCALL(recvmsg, handover,
 	       (int fd, struct user=5Fmsghdr =5F=5Fuser *umsg, int flags))
 {
-	struct user=5Fmsghdr m;
-	ssize=5Ft ret;
-
-	ret =3D cobalt=5Fcopy=5Ffrom=5Fuser(&m, umsg, sizeof(m));
-	if (ret)
-		return ret;
-
-	ret =3D rtdm=5Ffd=5Frecvmsg(fd, &m, flags);
-	if (ret < 0)
-		return ret;
-
-	return cobalt=5Fcopy=5Fto=5Fuser(umsg, &m, sizeof(*umsg)) ?: ret;
+	return rtdm=5Ffd=5Frecvmsg(fd, umsg, flags);
 }
 
 static int get=5Ftimespec(struct timespec *ts,
@@ -123,12 +112,7 @@ COBALT=5FSYSCALL(recvmmsg, primary,
 COBALT=5FSYSCALL(sendmsg, handover,
 	       (int fd, struct user=5Fmsghdr =5F=5Fuser *umsg, int flags))
 {
-	struct user=5Fmsghdr m;
-	int ret;
-
-	ret =3D cobalt=5Fcopy=5Ffrom=5Fuser(&m, umsg, sizeof(m));
-
-	return ret ?: rtdm=5Ffd=5Fsendmsg(fd, &m, flags);
+	return rtdm=5Ffd=5Fsendmsg(fd, umsg, flags);
 }
 
 static int put=5Fmmsglen(void =5F=5Fuser **u=5Fmmsg=5Fp, const struct =
mmsghdr *mmsg)


