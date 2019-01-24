From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 08/12] net/udp: getfrag: remove direct reference to user memory
Date: Thu, 24 Jan 2019 16:34:24 +0100
Message-Id: <20190124153428.21006-9-rpm@xenomai.org>
In-Reply-To: <20190124153428.21006-1-rpm@xenomai.org>
References: <20190124153428.21006-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

This issue triggers domain violation on ARM, SMAP violation on x86.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index e580dac08..d0d35c324 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -549,7 +549,7 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
                           unsigned int offset, unsigned int fraglen)
 {
     struct udpfakehdr *ufh = (struct udpfakehdr *)p;
-    int i, ret;
+    int ret;
 
 
     // We should optimize this function a bit (copy+csum...)!
@@ -558,18 +558,17 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
 	    return ret < 0 ? ret : 0;
     }
 
-    /* Checksum of the complete data part of the UDP message: */
-    for (i = 0; i < ufh->iovlen; i++) {
-            ufh->wcheck = csum_partial(ufh->iov[i].iov_base, ufh->iov[i].iov_len,
-                                       ufh->wcheck);
-    }
-
     ret = rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen,
 			      to + sizeof(struct udphdr),
 			      fraglen - sizeof(struct udphdr));
     if (ret < 0)
 	    return ret;
 
+    /* Checksum of the complete data part of the UDP message: */
+    ufh->wcheck = csum_partial(to + sizeof(struct udphdr),
+			       fraglen - sizeof(struct udphdr),
+			       ufh->wcheck);
+
     /* Checksum of the udp header: */
     ufh->wcheck = csum_partial((unsigned char *)ufh,
 			       sizeof(struct udphdr), ufh->wcheck);
@@ -684,7 +683,7 @@ ssize_t rt_udp_sendmsg(struct rtdm_fd *fd, const struct user_msghdr *msg, int ms
     ufh.uh.len    = htons(ulen);
     ufh.uh.check  = 0;
     ufh.fd        = fd;
-    ufh.iov       = msg->msg_iov;
+    ufh.iov       = iov;
     ufh.iovlen    = msg->msg_iovlen;
     ufh.wcheck    = 0;
 
-- 
2.17.2


