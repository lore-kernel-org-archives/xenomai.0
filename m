From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH 2/4] cobalt/registry: Share xnregistry_vfreg_ops with
 other compile units
Date: Wed, 18 Aug 2021 13:24:05 +0200
Message-Id: <20210818112407.12264-3-florian.bezdeka@siemens.com>
In-Reply-To: <20210818112407.12264-1-florian.bezdeka@siemens.com>
References: <20210818112407.12264-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
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

Allows re-using xnregistry_vfreg_ops. All other file options were
already available.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/registry.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/cobalt/kernel/registry.h b/include/cobalt/kernel/registry.h
index 624db5a78..a459da503 100644
--- a/include/cobalt/kernel/registry.h
+++ b/include/cobalt/kernel/registry.h
@@ -195,6 +195,8 @@ extern struct xnpnode_ops xnregistry_vfsnap_ops;
 
 extern struct xnpnode_ops xnregistry_vlink_ops;
 
+extern struct xnpnode_ops xnregistry_vfreg_ops;
+
 /** @} */
 
 #endif /* !_COBALT_KERNEL_REGISTRY_H */
-- 
2.30.2


