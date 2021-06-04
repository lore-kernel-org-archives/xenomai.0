From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 03/12] cobalt/build: pipeline: enable Dovetail support if
 detected
Date: Fri,  4 Jun 2021 12:05:13 +0200
Message-Id: <98a1f30115f12eb6626f438d2f37b86b3429c10a.1622801122.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1622801122.git.jan.kiszka@siemens.com>
References: <cover.1622801122.git.jan.kiszka@siemens.com>
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
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/Kconfig.frag | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index 319683369..dd91dc6c9 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -3,6 +3,7 @@ menuconfig XENOMAI
 	bool "Xenomai/cobalt"
 	select IPIPE if HAVE_IPIPE_SUPPORT
 	select IPIPE_WANT_APIREV_2 if IPIPE
+	select DOVETAIL if HAVE_DOVETAIL
 	default y
 	help
 	  Xenomai's Cobalt core is a real-time extension to the Linux
-- 
2.26.2


