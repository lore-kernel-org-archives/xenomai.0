From: wolfgang.mauerer@domain.hid
Date: Fri,  2 Oct 2009 10:52:35 +0200
Message-Id: <1254473555-11957-2-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1254473555-11957-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1254473555-11957-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH] Document -EWOULDBLOCK for rtdm_event_wait
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

From: Wolfgang Mauerer <wm@domain.hid>

rtdm_event_wait can return -EWOULDBLOCK when a
negative (i.e., non-blocking) timeout has been specified,
but this is not covered in the documentation.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
Reported-by: Michael.Schwertfeger@domain.hid
---
 ksrc/skins/rtdm/drvlib.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
index 69570d0..8177f7d 100644
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -928,6 +928,9 @@ EXPORT_SYMBOL(rtdm_event_wait);
  * - -EPERM @e may be returned if an illegal invocation environment is
  * detected.
  *
+ * - -EWOULDBLOCK is returned if a negative @a timeout (i.e., non-blocking
+ * operation) has been specified.
+ *
  * Environments:
  *
  * This service can be called from:
-- 
1.6.4


