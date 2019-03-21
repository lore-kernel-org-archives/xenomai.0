From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 07/16] net/udp sendmsg: do not return an error if dest addr is
 null
Date: Thu, 21 Mar 2019 18:13:21 +0100
Message-Id: <20190321171330.2073-8-rpm@xenomai.org>
In-Reply-To: <20190321171330.2073-1-rpm@xenomai.org>
References: <20190321171330.2073-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 8539fe87a..57b642e5c 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -701,6 +701,9 @@ ssize_t rt_udp_sendmsg(struct rtdm_fd * fd, const struct user_msghdr * msg,
 
 	rtdm_lock_put_irqrestore(&udp_socket_base_lock, context);
 
+	if (daddr == 0)
+		return 0;
+
 	if ((daddr | dport) == 0) {
 		err = -EINVAL;
 		goto out;
-- 
2.20.1


