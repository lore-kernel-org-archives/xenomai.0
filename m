From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:27 +0200
Message-Id: <f2c6b7b2df771c2197ec976c77f97beec2496009.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 03/24] RTDM: Bump API version and document
	changes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rtdm.h         |    4 ++--
 ksrc/skins/rtdm/API.CHANGES |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/rtdm/rtdm.h b/include/rtdm/rtdm.h
index 6e02083..1e6e41e 100644
--- a/include/rtdm/rtdm.h
+++ b/include/rtdm/rtdm.h
@@ -31,7 +31,7 @@
  * RT/non-RT systems like Xenomai. RTDM conforms to POSIX
  * semantics (IEEE Std 1003.1) where available and applicable.
  *
- * @b API @b Revision: 7
+ * @b API @b Revision: 8
  */
 
 /*!
@@ -76,7 +76,7 @@ typedef struct task_struct rtdm_user_info_t;
  * @anchor api_versioning @name API Versioning
  * @{ */
 /** Common user and driver API version */
-#define RTDM_API_VER			7
+#define RTDM_API_VER			8
 
 /** Minimum API revision compatible with the current release */
 #define RTDM_API_MIN_COMPAT_VER		6
diff --git a/ksrc/skins/rtdm/API.CHANGES b/ksrc/skins/rtdm/API.CHANGES
index ca9012b..84487f7 100644
--- a/ksrc/skins/rtdm/API.CHANGES
+++ b/ksrc/skins/rtdm/API.CHANGES
@@ -5,6 +5,12 @@ Scheduled modifications (unsorted):
  o Support for deferring IRQ line re-enabling from handler to thread context.
  o Support for user-space drivers.
 
+Revision 8:
+ o Added rtdm_rt_capable.
+
+Revision 7:
+ o Added callbacks and services to enable select support.
+
 Revision 6:
  o Added profile_version field to rtdm_device.
  o Requested IRQ lines are now enabled on return of rtdm_irq_request.
-- 
1.6.0.2


