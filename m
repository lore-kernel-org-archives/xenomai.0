From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 5/6] drivers/net: icmp: remove variable-length array
Date: Sat, 27 Mar 2021 11:14:27 +0100
Message-Id: <20210327101428.2291095-6-rpm@xenomai.org>
In-Reply-To: <20210327101428.2291095-1-rpm@xenomai.org>
References: <20210327101428.2291095-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/icmp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
index 0671cbc93..c3563595e 100644
--- a/kernel/drivers/net/stack/ipv4/icmp.c
+++ b/kernel/drivers/net/stack/ipv4/icmp.c
@@ -313,8 +313,17 @@ static int rt_icmp_send_request(u32 daddr, struct icmp_bxm *icmp_param)
 int rt_icmp_send_echo(u32 daddr, u16 id, u16 sequence, size_t msg_size)
 {
 	struct icmp_bxm icmp_param;
-	unsigned char pattern_buf[msg_size];
+	unsigned char *pattern_buf;
 	off_t pos;
+	int ret;
+
+	/*
+	 * This is ping, exec time is not that critical, so
+	 * rtdm_malloc() is ok for the purpose of echoing.
+	 */
+	pattern_buf = rtdm_malloc(msg_size);
+	if (pattern_buf == NULL)
+		return -ENOMEM;
 
 	/* first purge any potentially pending ICMP fragments */
 	rt_ip_frag_invalidate_socket(icmp_socket);
@@ -343,7 +352,10 @@ int rt_icmp_send_echo(u32 daddr, u16 id, u16 sequence, size_t msg_size)
 	}
 	icmp_param.data.buf = pattern_buf;
 
-	return rt_icmp_send_request(daddr, &icmp_param);
+	ret = rt_icmp_send_request(daddr, &icmp_param);
+	rtdm_free(pattern_buf);
+
+	return ret;
 }
 
 /***
-- 
2.29.2


