From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 24/31] net/ipv4: route: handle default net route
Date: Tue, 11 May 2021 18:05:28 +0200
Message-Id: <20210511160535.26580-25-jean-baptiste.tredez@alstefgroup.com>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/doc/README.routing    | 22 ++++++++++
 kernel/drivers/net/doc/README.rtnetproxy |  6 ++-
 kernel/drivers/net/stack/ipv4/route.c    | 54 +++++++++++++++++++++---
 3 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/kernel/drivers/net/doc/README.routing b/kernel/drivers/net/doc/README.routing
index f59c3f3f5..674039f91 100644
--- a/kernel/drivers/net/doc/README.routing
+++ b/kernel/drivers/net/doc/README.routing
@@ -115,3 +115,25 @@ the hash-key-based lookup and a potential query of the key-less list of routes.
 RTnet provides by default a pool of 16 network routes. This number can be
 modified in the source code (see ipv4/route.c). Network routes are only
 manually added or removed via rtroute.
+
+4. Default gateway address
+--------------------------
+
+In some cases, it is desirable for the RTnet routing system to fall
+back to a default gateway address for otherwise unresolved
+routes. Typically, such a gateway comes in handy when a rtnetproxy
+device is required for sharing a single physical interface (NIC)
+between the real-time and regular traffic (accepting the implications
+this may have with respect to real-time performance). Both the regular
+and the RTnet routing configurations can define their respective
+default gateway, first to route regular traffic to the proxy, next to
+route such traffic via the gateway assigned to the default RTnet
+route.
+
+A default gateway can be defined by the rtroute command as follows:
+
+# rtroute add default gw <IP_ADDRESS>
+
+Support for the default gateway is available when
+CONFIG_XENO_DRIVERS_NET_RTIPV4_NETROUTING is enabled. A single default
+gateway address is supported.
diff --git a/kernel/drivers/net/doc/README.rtnetproxy b/kernel/drivers/net/doc/README.rtnetproxy
index 647cdb6a9..7d115bbca 100644
--- a/kernel/drivers/net/doc/README.rtnetproxy
+++ b/kernel/drivers/net/doc/README.rtnetproxy
@@ -14,8 +14,10 @@ the network device is "rtproxy".
 
 Setup:
 --------
-Get your RTnet working first! All IP addresses you are interested in have
-to be set via "rtifconfig ethX route solicit IP_ADDRESS"!
+Get your RTnet working first! All IP addresses you are interested in
+have to be set via "rtifconfig ethX route solicit IP_ADDRESS", or a
+default gateway machine should have been set via "rtroute add default
+gw IP_ADDRESS".
 
      insmod rtnetproxy.o
 
diff --git a/kernel/drivers/net/stack/ipv4/route.c b/kernel/drivers/net/stack/ipv4/route.c
index 14a8b2932..e352e39fe 100644
--- a/kernel/drivers/net/stack/ipv4/route.c
+++ b/kernel/drivers/net/stack/ipv4/route.c
@@ -51,7 +51,7 @@ struct net_route {
 	u32 gw_ip;
 };
 
-#if (CONFIG_XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES &                              \
+#if (CONFIG_XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES &	\
      (CONFIG_XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES - 1))
 #error CONFIG_XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES must be power of 2
 #endif
@@ -88,6 +88,7 @@ static struct net_route *free_net_route;
 static int allocated_net_routes;
 static struct net_route *net_hash_tbl[NET_HASH_TBL_SIZE + 1];
 static unsigned int net_hash_key_shift = NET_HASH_KEY_SHIFT;
+static u32 default_gw_ip;
 static DEFINE_RTDM_LOCK(net_table_lock);
 
 module_param(net_hash_key_shift, uint, 0444);
@@ -376,7 +377,15 @@ static int rtnet_ipv4_net_route_next(struct xnvfile_snapshot_iterator *it,
 	struct rtnet_ipv4_net_route_data *p = data;
 
 	if (priv->entry_ptr == NULL) {
-		if (++priv->key >= NET_HASH_TBL_SIZE + 1)
+		if (++priv->key == 0 && default_gw_ip != INADDR_ANY) {
+			p->key = NET_HASH_TBL_SIZE;
+			p->dest_net_ip = INADDR_ANY;
+			p->dest_net_mask = INADDR_ANY;
+			p->gw_ip = default_gw_ip;
+			return 1;
+		}
+
+		if (priv->key >= NET_HASH_TBL_SIZE + 1)
 			return 0;
 
 		priv->entry_ptr = net_hash_tbl[priv->key];
@@ -410,12 +419,16 @@ static int rtnet_ipv4_net_route_show(struct xnvfile_snapshot_iterator *it,
 			       "\t\t%u.%u.%u.%-3u\n",
 			       p->key, NIPQUAD(p->dest_net_ip),
 			       NIPQUAD(p->dest_net_mask), NIPQUAD(p->gw_ip));
-	else
+	else if (p->dest_net_ip != INADDR_ANY)
 		xnvfile_printf(it,
 			       "*\t%u.%u.%u.%-3u\t%u.%u.%u.%-3u\t\t"
 			       "%u.%u.%u.%-3u\n",
 			       NIPQUAD(p->dest_net_ip),
 			       NIPQUAD(p->dest_net_mask), NIPQUAD(p->gw_ip));
+	else
+		xnvfile_printf(it,
+			"*\t%-11s\t0.0.0.0\t\t\t%u.%u.%u.%-3u\n",
+			"default", NIPQUAD(p->gw_ip));
 
 	return 0;
 }
@@ -760,6 +773,17 @@ int rt_ip_route_add_net(u32 addr, u32 mask, u32 gw_addr)
 	unsigned int key;
 	u32 shifted_mask;
 
+	rtdm_lock_get_irqsave(&net_table_lock, context);
+
+	if (addr == INADDR_ANY) {
+		default_gw_ip = gw_addr;
+		allocated_net_routes++;
+		rtdm_lock_put_irqrestore(&net_table_lock, context);
+		return 0;
+	}
+
+	rtdm_lock_put_irqrestore(&net_table_lock, context);
+
 	addr &= mask;
 
 	if ((new_route = rt_alloc_net_route()) != NULL) {
@@ -823,6 +847,17 @@ int rt_ip_route_del_net(u32 addr, u32 mask)
 	unsigned int key;
 	u32 shifted_mask;
 
+	rtdm_lock_get_irqsave(&net_table_lock, context);
+
+	if (addr == INADDR_ANY) {
+		default_gw_ip = INADDR_ANY;
+		allocated_net_routes--;
+		rtdm_lock_put_irqrestore(&net_table_lock, context);
+		return 0;
+	}
+
+	rtdm_lock_put_irqrestore(&net_table_lock, context);
+
 	addr &= mask;
 
 	shifted_mask = NET_HASH_KEY_MASK << net_hash_key_shift;
@@ -856,6 +891,7 @@ int rt_ip_route_del_net(u32 addr, u32 mask)
 
 	return -ENOENT;
 }
+
 #endif /* CONFIG_XENO_DRIVERS_NET_RTIPV4_NETROUTING */
 
 /***
@@ -915,8 +951,9 @@ restart:
 	else
 		while (host_rt != NULL) {
 			if ((host_rt->dest_host.ip == daddr) &&
-			    (host_rt->dest_host.rtdev->local_ip == saddr))
+				(host_rt->dest_host.rtdev->local_ip == saddr)) {
 				goto host_route_found;
+			}
 			host_rt = host_rt->next;
 		}
 
@@ -947,7 +984,7 @@ restart:
 
 		rtdm_lock_put_irqrestore(&net_table_lock, context);
 
-		/* last try: no hash key */
+		/* no hash key */
 		rtdm_lock_get_irqsave(&net_table_lock, context);
 
 		net_rt = net_hash_tbl[NET_HASH_TBL_SIZE];
@@ -966,6 +1003,13 @@ restart:
 			net_rt = net_rt->next;
 		}
 
+		/* last try: use default route if any. */
+		if (default_gw_ip != INADDR_ANY) {
+			daddr = default_gw_ip;
+			rtdm_lock_put_irqrestore(&net_table_lock, context);
+			goto restart;
+		}
+
 		rtdm_lock_put_irqrestore(&net_table_lock, context);
 	}
 #endif /* CONFIG_XENO_DRIVERS_NET_RTIPV4_NETROUTING */
-- 
2.17.1


