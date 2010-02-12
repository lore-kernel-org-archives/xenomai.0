From: Andreas Glatz <andreasglatz@domain.hid>
Date: Fri, 12 Feb 2010 18:36:26 -0500
Message-ID: <1266017786-26290-4-git-send-email-andreasglatz@domain.hid>
In-Reply-To: <1266017786-26290-3-git-send-email-andreasglatz@domain.hid>
References: <1266017786-26290-1-git-send-email-andreasglatz@domain.hid>
	<1266017786-26290-2-git-send-email-andreasglatz@domain.hid>
	<1266017786-26290-3-git-send-email-andreasglatz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai-help] [PATCH 3/3] native: Removed redundant code in
	rt_intr_delete() which caused xnintr_detach() to be called
	twice on an interrupt object.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Signed-off-by: Andreas Glatz <andreasglatz@domain.hid>
---
 ksrc/skins/native/intr.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/ksrc/skins/native/intr.c b/ksrc/skins/native/intr.c
index f52daff..8abcd27 100644
--- a/ksrc/skins/native/intr.c
+++ b/ksrc/skins/native/intr.c
@@ -362,8 +362,7 @@ int rt_intr_delete(RT_INTR *intr)
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	err = xnintr_detach(&intr->intr_base);
-	xnintr_destroy(&intr->intr_base);
+	err = xnintr_destroy(&intr->intr_base);
 
 	if (rc == XNSYNCH_RESCHED)
 		/* Some task has been woken up as a result of the deletion:
-- 
1.5.6.5


