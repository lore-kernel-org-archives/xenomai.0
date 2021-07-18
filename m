From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/1] license: summarize the licensing terms
Date: Sun, 18 Jul 2021 11:23:47 +0200
Message-Id: <20210718092347.473513-2-rpm@xenomai.org>
In-Reply-To: <20210718092347.473513-1-rpm@xenomai.org>
References: <20210718092347.473513-1-rpm@xenomai.org>
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
 COPYING | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 COPYING

diff --git a/COPYING b/COPYING
new file mode 100644
index 000000000..583410189
--- /dev/null
+++ b/COPYING
@@ -0,0 +1,39 @@
+
+Licensing terms
+---------------
+
+Xenomai 3 is composed of a number of libraries, user-space application
+programs, and kernel code. This file summarizes the licenses used for
+the libraries and kernel code. Please refer to the COPYING file in the
+corresponding directory for details. The licensing terms of each
+application program shipped with Xenomai 3 is stated in the
+corresponding source code.
+
+-- Libraries
+
+./lib/boilerplate/COPYING: LGPLv2 + MIT
+./lib/boilerplate/iniparser/LICENSE: MIT
+./lib/trank/COPYING: LGPLv2
+./lib/copperplate/COPYING: LGPLv2
+./lib/cobalt/COPYING: LGPLv2
+./lib/psos/COPYING: LGPLv2
+./lib/smokey/COPYING: LGPLv2
+./lib/vxworks/COPYING: LGPLv2
+./lib/alchemy/COPYING: LGPLv2
+
+-- Kernel code
+
+./kernel/cobalt/posix/COPYING: GPLv2
+./kernel/cobalt/COPYING: GPLv2
+./kernel/cobalt/rtdm/COPYING: GPLv2
+
+Please note that the common Linux licensing rules as stated in the
+document mentioned below apply to all the Xenomai kernel code once
+compiled in the Linux kernel, with no exception:
+
+https://www.kernel.org/doc/html/latest/process/license-rules.html#kernel-licensing
+
+-- Header files, including UAPI (kernel <-> user interface)
+
+./include/COPYING: GPLv2 + exception for additional uses in
+                   user-space application programs.
-- 
2.31.1


