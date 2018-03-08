From: Ivid Suvarna <ivid.suvarna@gmail.com>
Date: Thu,  8 Mar 2018 09:49:32 +0530
Message-Id: <1520482772-3311-1-git-send-email-ivid.suvarna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [PATCH] lib/boilerplate: Fix build for mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, rpm@xenomai.org

"commit 9da7bde" introduces rt_print_flush_buffers in ancillaries

Fixes the following error "--with-core=mercury" :

   >> ancillaries.c: In function ‘___panic’:
   >> ancillaries.c:129:2: error: implicit declaration of function ‘rt_print_flush_buffers’
   >>   rt_print_flush_buffers();
   >>   ^

Signed-off-by: Ivid Suvarna <ivid.suvarna@gmail.com>
---
 lib/boilerplate/ancillaries.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
index 7e98141..a0754cb 100644
--- a/lib/boilerplate/ancillaries.c
+++ b/lib/boilerplate/ancillaries.c
@@ -126,7 +126,9 @@ void ___panic(const char *fn, const char *name,
 	if (asprintf(&p, "BUG in %s(): ", fn) < 0)
 		p = "BUG: ";
 	__printout(name, p, fmt, ap);
+#ifdef CONFIG_XENO_COBALT
 	rt_print_flush_buffers();
+#endif /* CONFIG_XENO_COBALT */
 	exit(1);
 }
 
-- 
2.7.4


