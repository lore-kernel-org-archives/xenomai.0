From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image PATCH v2 3/5] recipes-kernel: add common config
 fragment file to disable debug
Date: Mon, 26 Jul 2021 20:42:15 -0400
Message-Id: <20210727004217.10892-4-hongzhan.chen@intel.com>
In-Reply-To: <20210727004217.10892-1-hongzhan.chen@intel.com>
References: <20210727004217.10892-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Add common config fragment file to disable debug. For performance
or latency testing and demonstration, debug switches should be off.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 recipes-kernel/linux/files/common_nodbg.cfg | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 recipes-kernel/linux/files/common_nodbg.cfg

diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
new file mode 100644
index 0000000..749799d
--- /dev/null
+++ b/recipes-kernel/linux/files/common_nodbg.cfg
@@ -0,0 +1 @@
+# CONFIG_IPIPE_DEBUG is not set
-- 
2.17.1


