From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Wed, 16 Dec 2020 09:45:29 +0100
Subject: =?utf-8?q?=5BPatch?==?utf-8?q?_3=2F3=5D?= Problem with upstream
 SPECTRE mitigation found in =?utf-8?q?sendmsg=2Frecvmsg?= syscalls
Message-ID: <1175-5fd9c900-12b-25a5a500@199049733>
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
 kernel/drivers/net/stack/ipv4/tcp/tcp.c     | 10 ----------
 1 file changed, 0 insertions(+), 10 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/n=
et/stack/ipv4/tcp/tcp.c
index b8263e5..d8c189c 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -2137,7 +2137,6 @@ static ssize=5Ft rt=5Ftcp=5Frecvmsg(struct rtdm=5F=
fd *fd, struct user=5Fmsghdr *msg,
 			      int msg=5Fflags)
 {
 	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
-	struct user=5Fmsghdr =5Fmsg;
 	ssize=5Ft ret;
 	size=5Ft len;
 	void *buf;
@@ -2145,10 +2144,6 @@ static ssize=5Ft rt=5Ftcp=5Frecvmsg(struct rtdm=5F=
fd *fd, struct user=5Fmsghdr *msg,
 	if (msg=5Fflags)
 		return -EOPNOTSUPP;
 
-	msg =3D rtnet=5Fget=5Farg(fd, &=5Fmsg, msg, sizeof(*msg));
-	if (IS=5FERR(msg))
-		return PTR=5FERR(msg);
-
 	/* loop over all vectors to be implemented */
 	if (msg->msg=5Fiovlen !=3D 1)
 		return -EOPNOTSUPP;
@@ -2175,17 +2170,12 @@ static ssize=5Ft rt=5Ftcp=5Fsendmsg(struct rtdm=
=5Ffd *fd, const struct user=5Fmsghdr *msg,
 			      int msg=5Fflags)
 {
 	struct iovec iov=5Ffast[RTDM=5FIOV=5FFASTMAX], *iov;
-	struct user=5Fmsghdr =5Fmsg;
 	ssize=5Ft ret;
 	size=5Ft len;
 
 	if (msg=5Fflags)
 		return -EOPNOTSUPP;
 
-	msg =3D rtnet=5Fget=5Farg(fd, &=5Fmsg, msg, sizeof(*msg));
-	if (IS=5FERR(msg))
-		return PTR=5FERR(msg);
-
 	/* loop over all vectors to be implemented */
 	if (msg->msg=5Fiovlen !=3D 1)
 		return -EOPNOTSUPP;


