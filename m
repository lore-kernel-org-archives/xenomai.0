From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-images 5/7] recipes-kernel: add config fragment file to
 disable debug for arm
Date: Thu, 22 Jul 2021 23:18:09 -0400
Message-Id: <20210723031811.19290-6-hongzhan.chen@intel.com>
In-Reply-To: <20210723031811.19290-1-hongzhan.chen@intel.com>
References: <20210723031811.19290-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Add config fragment file to disable debug for arm. For performance
or latency testing and demonstration, debug switches should be off.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 recipes-kernel/linux/files/armhf_nodbg.cfg | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 recipes-kernel/linux/files/armhf_nodbg.cfg

diff --git a/recipes-kernel/linux/files/armhf_nodbg.cfg b/recipes-kernel/linux/files/armhf_nodbg.cfg
new file mode 100644
index 0000000..749799d
--- /dev/null
+++ b/recipes-kernel/linux/files/armhf_nodbg.cfg
@@ -0,0 +1 @@
+# CONFIG_IPIPE_DEBUG is not set
-- 
2.17.1


