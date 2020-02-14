From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 04/11] recipes-kernel/linux: Add 4.4
Date: Fri, 14 Feb 2020 08:32:54 +0100
Message-Id: <20200214073259.1769-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
References: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
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

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add recipe for linux 4.4.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 opt-linux-4.4.yml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 opt-linux-4.4.yml

diff --git a/opt-linux-4.4.yml b/opt-linux-4.4.yml
new file mode 100644
index 0000000..bb24a04
--- /dev/null
+++ b/opt-linux-4.4.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+local_conf_header:
+  linux-xenomai-latest: |
+    PREFERRED_VERSION_linux-xenomai = "4.4%"
-- 
2.20.1


