Message-ID: <521CE0CC.6060200@siemens.com>
Date: Tue, 27 Aug 2013 19:24:28 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH][forge] kconfig: Make Xenomai a menuconfig
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Avoid polluting the main menu.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/Kconfig.frag | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index 26714e7..e905a9f 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -1,4 +1,4 @@
-config XENOMAI
+menuconfig XENOMAI
 	depends on X86_TSC || !X86
 	bool "Xenomai"
 	select IPIPE
-- 
1.8.1.1.298.ge7eed54

