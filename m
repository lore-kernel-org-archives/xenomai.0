From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image 3/3] recipes-kernel: disable more debugs for common
 nodbg fragment
Date: Tue, 27 Jul 2021 22:21:24 -0400
Message-Id: <20210728022124.23466-4-hongzhan.chen@intel.com>
In-Reply-To: <20210728022124.23466-1-hongzhan.chen@intel.com>
References: <20210728022124.23466-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Disable more debugs for common nodbg fragment to improve performance

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 recipes-kernel/linux/files/common_nodbg.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
index 749799d..d7d87c5 100644
--- a/recipes-kernel/linux/files/common_nodbg.cfg
+++ b/recipes-kernel/linux/files/common_nodbg.cfg
@@ -1 +1,2 @@
 # CONFIG_IPIPE_DEBUG is not set
+# CONFIG_XENO_OPT_DEBUG is not set
-- 
2.17.1


