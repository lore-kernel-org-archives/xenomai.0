Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4AE2B519.5030602@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sat, 24 Oct 2009 10:03:04 +0200
Message-ID: <20091024080304.22784.63463.stgit@domain.hid>
In-Reply-To: <20091024080304.22784.46688.stgit@domain.hid>
References: <20091024080304.22784.46688.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/2] Syslog extension of rt_print
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Oliver Schlenker <oliver.schlenker@domain.hid>

From: Oliver Schlenker <oliver.schlenker@domain.hid>

Extension of rt_print library with rt_syslog() and rt_vsyslog() to print
messages rt-safe directly to syslog.

Signed-off-by: Oliver Schlenker <oliver.schlenker@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/rtdk.h      |    2 ++
 src/rtdk/rt_print.c |   39 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/rtdk.h b/include/rtdk.h
index 981bfda..9129ccb 100644
--- a/include/rtdk.h
+++ b/include/rtdk.h
@@ -52,6 +52,8 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args);
 int rt_vprintf(const char *format, va_list args);
 int rt_fprintf(FILE *stream, const char *format, ...);
 int rt_printf(const char *format, ...);
+void rt_syslog(int priority, char *format, ...);
+void rt_vsyslog(int priority, char *format, va_list args);
 
 int rt_print_init(size_t buffer_size, const char *name);
 void rt_print_cleanup(void);
diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index dca9689..c6b5c55 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <syslog.h>
 
 #include <rtdk.h>
 #include <asm/xenomai/system.h>
@@ -37,9 +38,12 @@
 
 #define RT_PRINT_LINE_BREAK		256
 
+#define RT_PRINT_SYSLOG_STREAM		NULL
+
 struct entry_head {
 	FILE *dest;
 	uint32_t seq_no;
+	int priority;
 	char text[1];
 } __attribute__((packed));
 
@@ -76,7 +80,8 @@ static void print_buffers(void);
 
 /* *** rt_print API *** */
 
-int rt_vfprintf(FILE *stream, const char *format, va_list args)
+static int print_to_buffer(FILE *stream, int priority, const char *format,
+			   va_list args)
 {
 	struct print_buffer *buffer = pthread_getspecific(buffer_key);
 	off_t write_pos, read_pos;
@@ -115,6 +120,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
 			/* Write out empty entry */
 			head = buffer->ring + write_pos;
 			head->seq_no = seq_no;
+			head->priority = 0;
 			head->text[0] = 0;
 
 			/* Forward to the ring buffer start */
@@ -148,6 +154,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
 	/* If we were able to write some text, finalise the entry */
 	if (len > 0) {
 		head->seq_no = ++seq_no;
+		head->priority = priority;
 		head->dest = stream;
 
 		/* Move forward by text and head length */
@@ -160,6 +167,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
 		/* An empty entry marks the wrap-around */
 		head = buffer->ring + write_pos;
 		head->seq_no = seq_no;
+		head->priority = priority;
 		head->text[0] = 0;
 
 		write_pos = 0;
@@ -173,6 +181,11 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
 	return res;
 }
 
+int rt_vfprintf(FILE *stream, const char *format, va_list args)
+{
+	return print_to_buffer(stream, 0, format, args);
+}
+
 int rt_vprintf(const char *format, va_list args)
 {
 	return rt_vfprintf(stdout, format, args);
@@ -202,6 +215,20 @@ int rt_printf(const char *format, ...)
 	return n;
 }
 
+void rt_syslog(int priority, char *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+	print_to_buffer(RT_PRINT_SYSLOG_STREAM, priority, format, args);
+	va_end(args);
+}
+
+void rt_vsyslog(int priority, char *format, va_list args)
+{
+	print_to_buffer(RT_PRINT_SYSLOG_STREAM, priority, format, args);
+}
+
 static void set_buffer_name(struct print_buffer *buffer, const char *name)
 {
 	int n;
@@ -311,7 +338,6 @@ const char *rt_print_buffer_name(void)
 	return buffer->name;
 }
 
-
 /* *** Deferred Output Management *** */
 
 static void cleanup_buffer(struct print_buffer *buffer)
@@ -384,7 +410,14 @@ static void print_buffers(void)
 
 		if (len) {
 			/* Print out non-empty entry and proceed */
-			fprintf(head->dest, "%s", head->text);
+			/* Check if output goes to syslog */
+			if (head->dest == RT_PRINT_SYSLOG_STREAM) {
+				syslog(head->priority, "%s", head->text);
+			} else {
+				/* Output goes to specified stream */
+				fprintf(head->dest, "%s", head->text);
+			}
+
 			read_pos += sizeof(*head) + len;
 		} else {
 			/* Emptry entries mark the wrap-around */


