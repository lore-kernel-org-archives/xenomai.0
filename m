From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Fri,  2 Jul 2010 13:49:08 +0200
Message-Id: <1278071353-13836-3-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 2/7] nucleus: Sanity check for vdso.h
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Including the file only makes sense when support for pervasive
rt is enabled, so add a corresponding check.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/nucleus/vdso.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/nucleus/vdso.h b/include/nucleus/vdso.h
index c431f88..2343e5d 100644
--- a/include/nucleus/vdso.h
+++ b/include/nucleus/vdso.h
@@ -23,6 +23,10 @@
  * 02111-1307, USA.
  */
 
+#if defined(__KERNEL__) && !defined(CONFIG_XENO_OPT_PERVASIVE)
+#error "vdso.h included in a kernel configuration without pervasive rt support!"
+#endif
+
 #include <nucleus/types.h>
 
 /*
-- 
1.6.4


