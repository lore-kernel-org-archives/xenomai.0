References: <b709f916-7c1e-8adb-bae7-60ce388fc8fc@siemens.com>
 <5c284b6e-b5e4-0054-805e-af4f7c15ee04@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2723c58b-7375-ee8d-9b34-6643b6569bf1@siemens.com>
Date: Mon, 26 Feb 2018 18:45:29 +0100
MIME-Version: 1.0
In-Reply-To: <5c284b6e-b5e4-0054-805e-af4f7c15ee04@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH v2] lib/boilerplate: Prevent migration to
 secondary mode for __printout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>
Cc: "Hartmann, Wolfgang" <wolfgang.hartmann@siemens.com>

From: Wolfgang Hartmann <wolfgang.hartmann@siemens.com>

Use the __RT versions of the stdio function calls to avoid migration to
secondary mode. In case of ___panic, flush the printer before exiting to
avoid losing messages.

Signed-off-by: Wolfgang Hartmann <wolfgang.hartmann@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - handle early print via standard calls

 lib/boilerplate/ancillaries.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
index 13d7fafa4..7e98141ce 100644
--- a/lib/boilerplate/ancillaries.c
+++ b/lib/boilerplate/ancillaries.c
@@ -52,14 +52,30 @@ static void __do_printout(const char *name, const char *header,
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
+	__RT(fprintf(fp, "[%s] ", name ?: "main"));
+	__RT(vfprintf(fp, fmt, ap));
+	__RT(fputc('\n', fp));
+}
+
+static void __do_early_printout(const char *name, const char *header,
+			  unsigned int ms, unsigned int us,
+			  const char *fmt, va_list ap)
+{
+	FILE *fp = stderr;
+
+	__STD(fprintf(fp, "%4u\"%.3u.%.3u| ", ms / 1000, ms % 1000, us));
+
+	if (header)
+		__STD(fputs(header, fp));
+
+	__STD(fprintf(fp, "[%s] ", name ?: "main"));
+	__STD(vfprintf(fp, fmt, ap));
+	__STD(fputc('\n', fp));
 	fflush(fp);
 }
 
@@ -77,7 +93,7 @@ void __printout(const char *name, const char *header,
 	 * uncontended.
 	 */
 	if (!init_done) {
-		__do_printout(name, header, 0, 0, fmt, ap);
+		__do_early_printout(name, header, 0, 0, fmt, ap);
 		return;
 	}
 	
@@ -110,6 +126,7 @@ void ___panic(const char *fn, const char *name,
 	if (asprintf(&p, "BUG in %s(): ", fn) < 0)
 		p = "BUG: ";
 	__printout(name, p, fmt, ap);
+	rt_print_flush_buffers();
 	exit(1);
 }
 

