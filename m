From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b709f916-7c1e-8adb-bae7-60ce388fc8fc@siemens.com>
Date: Fri, 9 Feb 2018 17:54:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] lib/boilerplate: Prevent migration to secondary
 mode for __printout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: "Hartmann, Wolfgang" <wolfgang.hartmann@siemens.com>

From: Wolfgang Hartmann <wolfgang.hartmann@siemens.com>

Use the __RT versions of the stdio function calls to avoid migration to
secondary mode. In case of ___panic, flush the printer before exiting to
avoid losing messages.

Signed-off-by: Wolfgang Hartmann <wolfgang.hartmann@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/boilerplate/ancillaries.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
index 13d7fafa4..225e44995 100644
--- a/lib/boilerplate/ancillaries.c
+++ b/lib/boilerplate/ancillaries.c
@@ -52,15 +52,14 @@ static void __do_printout(const char *name, const char *header,
 {
 	FILE *fp = stderr;
 
-	fprintf(fp, "%4u\"%.3u.%.3u| ", ms / 1000, ms % 1000, us);
+	__RT(fprintf(fp, "%4u\"%.3u.%.3u| ", ms / 1000, ms % 1000, us));
 
 	if (header)
-		fputs(header, fp);
+		__RT(fputs(header, fp));
 
-	fprintf(fp, "[%s] ", name ?: "main");
-	vfprintf(fp, fmt, ap);
-	fputc('\n', fp);
-	fflush(fp);
+	__RT(fprintf(fp, "[%s] ", name ?: "main"));
+	__RT(vfprintf(fp, fmt, ap));
+	__RT(fputc('\n', fp));
 }
 
 void __printout(const char *name, const char *header,
@@ -110,6 +109,7 @@ void ___panic(const char *fn, const char *name,
 	if (asprintf(&p, "BUG in %s(): ", fn) < 0)
 		p = "BUG: ";
 	__printout(name, p, fmt, ap);
+	rt_print_flush_buffers();
 	exit(1);
 }
 
-- 
2.13.6

