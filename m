From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey: Hook gdb into DIST_SUBDIRS
Message-ID: <cbe4d7d3-8429-a3c4-bafd-25d237379d0b@siemens.com>
Date: Thu, 16 Jan 2020 17:52:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index b35b00d82d..81d0941c4b 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -51,6 +51,7 @@ DIST_SUBDIRS = 		\
 	cpu-affinity	\
 	dlopen		\
 	fpu-stress	\
+	gdb		\
 	iddp		\
 	leaks		\
 	memory-coreheap	\
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

