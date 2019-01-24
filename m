From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 07/12] net/udp: getfrag: fix frag preparation status
Date: Thu, 24 Jan 2019 16:34:23 +0100
Message-Id: <20190124153428.21006-8-rpm@xenomai.org>
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

This fixes a regression introduced by #a69c4ac5d, making the UDP stack
basically unusable since no xmit could ever take place due to the
wrong return value.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 8e80d3e0b..e580dac08 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -553,8 +553,10 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
 
 
     // We should optimize this function a bit (copy+csum...)!
-    if (offset)
-	    return rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen, to, fraglen);
+    if (offset) {
+	    ret = rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen, to, fraglen);
+	    return ret < 0 ? ret : 0;
+    }
 
     /* Checksum of the complete data part of the UDP message: */
     for (i = 0; i < ufh->iovlen; i++) {
@@ -565,7 +567,7 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
     ret = rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen,
 			      to + sizeof(struct udphdr),
 			      fraglen - sizeof(struct udphdr));
-    if (ret)
+    if (ret < 0)
 	    return ret;
 
     /* Checksum of the udp header: */
-- 
2.17.2


