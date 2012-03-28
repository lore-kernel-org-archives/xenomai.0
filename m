From: Paul Janzen <pcj@domain.hid>
Date: Tue, 27 Mar 2012 22:39:04 -0700
In-Reply-To: <1331579565.394426122@domain.hid> (Doug Brunner's message
	of "Mon, 12 Mar 2012 12:12:45 -0700 (PDT)")
Message-ID: <oqzkb19tdz.fsf@domain.hid>
References: <1331579565.394426122@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai-core] [PATCH] Mask signals in rt_print:printer_loop()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

common/rt_print: Use sigfillset to actually mask all signals for
logging thread.  Fixes commit a6dceeb9.

Signed-off-by: Paul Janzen <pcj@domain.hid>
---
 src/skins/common/rt_print.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c
index e1c828a..272a4ba 100644
--- a/src/skins/common/rt_print.c
+++ b/src/skins/common/rt_print.c
@@ -615,7 +615,7 @@ static void *printer_loop(void *arg)
 {
        sigset_t mask;
 
-       sigemptyset(&mask);
+       sigfillset(&mask);
        pthread_sigmask(SIG_BLOCK, &mask, NULL);
 
        while (1) {
-- 
1.7.1

