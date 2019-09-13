From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 09/12] drivers/net: udp: Roll back if rtdm_dev_register
 fails
Date: Fri, 13 Sep 2019 18:46:52 +0200
Message-Id: <b9229a896a5ec27e6ee086219c0f6427a99b588c.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 56fc7126aa..5e36797809 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -807,7 +807,8 @@ static struct rtdm_device udp_device = {
  */
 static int __init rt_udp_init(void)
 {
-	int i;
+	int i, err;
+
 	if ((auto_port_start < 0) ||
 	    (auto_port_start >= 0x10000 - RT_UDP_SOCKETS))
 		auto_port_start = 1024;
@@ -819,7 +820,10 @@ static int __init rt_udp_init(void)
 	for (i = 0; i < ARRAY_SIZE(port_hash); i++)
 		INIT_HLIST_HEAD(&port_hash[i]);
 
-	return rtdm_dev_register(&udp_device);
+	err = rtdm_dev_register(&udp_device);
+	if (err)
+		rt_inet_del_protocol(&udp_protocol);
+	return err;
 }
 
 /***
-- 
2.16.4


