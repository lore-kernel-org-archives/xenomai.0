From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 08/31] net/udp sendmsg: do not return an error if dest addr is
 null
Date: Tue, 11 May 2021 18:05:12 +0200
Message-Id: <20210511160535.26580-9-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index beceb28cf..2ff2febda 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -687,6 +687,9 @@ ssize_t rt_udp_sendmsg(struct rtdm_fd *fd, const struct user_msghdr *msg,
 
 	rtdm_lock_put_irqrestore(&udp_socket_base_lock, context);
 
+	if (daddr == 0)
+		return 0;
+
 	if ((daddr | dport) == 0) {
 		err = -EINVAL;
 		goto out;
-- 
2.17.1


