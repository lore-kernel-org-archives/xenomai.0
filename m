From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt: Fix uclibc build
Message-ID: <c103ee81-d2b6-6289-9869-1d372d9a205f@siemens.com>
Date: Thu, 12 Dec 2019 16:49:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: Steven Seeger <steven.seeger@flightsystems.net>

From: Jan Kiszka <jan.kiszka@siemens.com>

Add missing forward declaration of timex, avoid incorrect alias
creations by COBALT_IMPL due to wrongly defined fputc and putchar.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/stdio.h | 4 ++--
 include/cobalt/time.h  | 2 ++
 lib/cobalt/printf.c    | 2 --
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/stdio.h b/include/cobalt/stdio.h
index 7108ffbc1d..5b9df80069 100644
--- a/include/cobalt/stdio.h
+++ b/include/cobalt/stdio.h
@@ -73,7 +73,7 @@ static inline int __real_putchar(int c)
 int __wrap_putchar(int c);
 int __cobalt_putchar(int c);
 #undef putchar
-#define putchar __wrap_putchar
+#define putchar putchar
 #endif
 
 #ifndef fputc
@@ -86,7 +86,7 @@ static inline int __real_fputc(int c, FILE *stream)
 int __wrap_fputc(int c, FILE *stream);
 int __cobalt_fputc(int c, FILE *stream);
 #undef fputc
-#define fputc __wrap_fputc
+#define fputc fputc
 #endif
 
 COBALT_DECL(size_t,
diff --git a/include/cobalt/time.h b/include/cobalt/time.h
index 9bafe341f7..e3f355c611 100644
--- a/include/cobalt/time.h
+++ b/include/cobalt/time.h
@@ -30,6 +30,8 @@
 extern "C" {
 #endif
 
+struct timex;
+
 COBALT_DECL(int, clock_getres(clockid_t clock_id,
 			      struct timespec *tp));
 
diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
index 261eccbab8..8982ddc937 100644
--- a/lib/cobalt/printf.c
+++ b/lib/cobalt/printf.c
@@ -793,7 +793,6 @@ COBALT_IMPL(int, puts, (const char *s))
 	}
 }
 
-#undef fputc
 COBALT_IMPL(int, fputc, (int c, FILE *stream))
 {
 	if (!cobalt_is_relaxed())
@@ -804,7 +803,6 @@ COBALT_IMPL(int, fputc, (int c, FILE *stream))
 	}
 }
 
-#undef putchar
 COBALT_IMPL(int, putchar, (int c))
 {
 	if (!cobalt_is_relaxed())
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

