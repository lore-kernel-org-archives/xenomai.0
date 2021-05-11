From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 23/31] net/ipv4: route: fix counting of allocated net routes
Date: Tue, 11 May 2021 18:05:27 +0200
Message-Id: <20210511160535.26580-24-jean-baptiste.tredez@alstefgroup.com>
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
 kernel/drivers/net/stack/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/ipv4/route.c b/kernel/drivers/net/stack/ipv4/route.c
index d9a9c8b9b..14a8b2932 100644
--- a/kernel/drivers/net/stack/ipv4/route.c
+++ b/kernel/drivers/net/stack/ipv4/route.c
@@ -745,7 +745,7 @@ static inline void rt_free_net_route(struct net_route *rt)
 {
 	rt->next = free_net_route;
 	free_net_route = rt;
-	allocated_host_routes--;
+	allocated_net_routes--;
 }
 
 /***
-- 
2.17.1


