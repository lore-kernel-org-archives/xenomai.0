Message-ID: <4F184B4E.9040505@domain.hid>
Date: Thu, 19 Jan 2012 17:56:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] nucleus: Fix relaxed owner check
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Fix a logic inversion introduced by b75cec1938. This both allows the
relaxed-owner check to work again and prevents that we enter an endless
signal storm if XNSWREP happens to be set already at this point (as seen
in the field).

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/nucleus/synch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
index 47bc0c5..8daf7f6 100644
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -1004,7 +1004,7 @@ EXPORT_SYMBOL_GPL(xnsynch_release_all_ownerships);
 void xnsynch_detect_relaxed_owner(struct xnsynch *synch, struct xnthread *sleeper)
 {
 	if (xnthread_test_state(sleeper, XNTRAPSW) &&
-	    xnthread_test_info(sleeper, XNSWREP) &&
+	    !xnthread_test_info(sleeper, XNSWREP) &&
 	    xnthread_test_state(synch->owner, XNRELAX)) {
 		xnthread_set_info(sleeper, XNSWREP);
 		xnshadow_send_sig(sleeper, SIGDEBUG,
-- 
1.7.3.4

