From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH 2/2] lib/cobalt: set name for printf thread to help debugging
Date: Fri, 14 Jun 2019 12:23:49 +0200
Message-Id: <20190614102349.22912-2-norbert.lange@andritz.com>
In-Reply-To: <20190614102349.22912-1-norbert.lange@andritz.com>
References: <20190614102349.22912-1-norbert.lange@andritz.com>
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

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 lib/cobalt/printf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
index 33ff7f9ac..7426f2bda 100644
--- a/lib/cobalt/printf.c
+++ b/lib/cobalt/printf.c
@@ -648,6 +648,7 @@ static void spawn_printer_thread(void)
 	pthread_sigmask(SIG_BLOCK, &sset, &oset);
 	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
 	sigprocmask(SIG_SETMASK, &oset, NULL);
+	pthread_setname_np(printer_thread, "cobalt_printf");
 }
 
 void cobalt_print_init_atfork(void)
-- 
2.20.1


