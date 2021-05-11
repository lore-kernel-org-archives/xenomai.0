From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 26/31] net/ipv4: sock: handle SO_REUSEADDR for SOCK_DGRAM
 gracefully
Date: Tue, 11 May 2021 18:05:30 +0200
Message-Id: <20210511160535.26580-27-jean-baptiste.tredez@alstefgroup.com>
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

From: Philippe Gerum <rpm@xenomai.org>

Issuing SO_REUSEADDR for an IP socket before binding it is part of the
boilerplate code of many applications. Handle such request gracefully
like the regular network stack does, returning success without
performing any action since we implement no timed wait state for
SOCK_DGRAM.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/ipv4/ip_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/drivers/net/stack/ipv4/ip_sock.c b/kernel/drivers/net/stack/ipv4/ip_sock.c
index 0349ed1b1..a3f7d1f57 100644
--- a/kernel/drivers/net/stack/ipv4/ip_sock.c
+++ b/kernel/drivers/net/stack/ipv4/ip_sock.c
@@ -35,6 +35,9 @@ int rt_ip_setsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
 	int err = 0;
 	unsigned int _tos, *tos;
 
+	if (level == SOL_SOCKET && optname == SO_REUSEADDR)
+		return 0;
+
 	if (level != SOL_IP)
 		return -ENOPROTOOPT;
 
-- 
2.17.1


