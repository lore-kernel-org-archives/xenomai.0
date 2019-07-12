From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH] cobalt: remove call to sigprocmask
Date: Fri, 12 Jul 2019 13:18:49 +0200
Message-Id: <20190712111849.25670-1-norbert.lange@andritz.com>
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

sigprocmask should not be used in multithreaded applications,
doing so is "unspecified".

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 lib/cobalt/printf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
index 7426f2bda..80db9516a 100644
--- a/lib/cobalt/printf.c
+++ b/lib/cobalt/printf.c
@@ -647,7 +647,7 @@ static void spawn_printer_thread(void)
 	sigfillset(&sset);
 	pthread_sigmask(SIG_BLOCK, &sset, &oset);
 	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
-	sigprocmask(SIG_SETMASK, &oset, NULL);
+	pthread_sigmask(SIG_SETMASK, &oset, NULL);
 	pthread_setname_np(printer_thread, "cobalt_printf");
 }
 
-- 
2.20.1


