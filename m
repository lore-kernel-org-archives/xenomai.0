From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Subject: [PATCH v4] lib/cobalt: Wrap __open_2/__open64_2 to support
 _FORTIFY_SOURCE
Date: Fri, 11 Sep 2020 09:43:26 +0000
Message-Id: <20200911094326.19942-1-leupold@rsi-elektrotechnik.de>
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

__open_2() and __open64_2() from glibc add runtime precondition tests for the
'oflag' parameter to the functionality of open()/open64(). They may be used when
the macro _FORTIFY_SOURCE is defined when compiling the application code. Added
these wrappers to cover those cases.

If Xenomai itself is not compiled with FORTIFY_SOURCE then the function
declarations for __open_2() and __open64_2() are not available.
__STD(__open_2(...)) will not link in this case (would be a very special
use case anyway?).

Signed-off-by: Jan Leupold <leupold@rsi-elektrotechnik.de>
---
 include/cobalt/fcntl.h     |  4 ++++
 lib/cobalt/cobalt.wrappers |  2 ++
 lib/cobalt/rtdm.c          | 32 ++++++++++++++++++++++++++++++++
 lib/cobalt/wrappers.c      | 12 ++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/include/cobalt/fcntl.h b/include/cobalt/fcntl.h
index d54989389..f1052c28d 100644
--- a/include/cobalt/fcntl.h
+++ b/include/cobalt/fcntl.h
@@ -31,6 +31,10 @@ COBALT_DECL(int, open(const char *path, int oflag, ...));
 
 COBALT_DECL(int, open64(const char *path, int oflag, ...));
 
+COBALT_DECL(int, __open_2(const char *path, int oflag));
+
+COBALT_DECL(int, __open64_2(const char *path, int oflag));
+
 COBALT_DECL(int, fcntl(int fd, int cmd, ...));
 
 #ifdef __cplusplus
diff --git a/lib/cobalt/cobalt.wrappers b/lib/cobalt/cobalt.wrappers
index f63a170f8..0e954764d 100644
--- a/lib/cobalt/cobalt.wrappers
+++ b/lib/cobalt/cobalt.wrappers
@@ -54,6 +54,8 @@
 --wrap mq_notify
 --wrap open
 --wrap open64
+--wrap __open_2
+--wrap __open64_2
 --wrap socket
 --wrap close
 --wrap ioctl
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 9f3dcd25f..f3fb5d411 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -23,6 +23,7 @@
 #include <pthread.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <sys/socket.h>
 #include <sys/mman.h>
 #include <rtdm/rtdm.h>
@@ -94,6 +95,37 @@ COBALT_IMPL(int, open64, (const char *path, int oflag, ...))
 	return do_open(path, oflag | O_LARGEFILE, mode);
 }
 
+COBALT_IMPL(int, __open_2, (const char *path, int oflag))
+{
+	/* __open_2() from glibc adds a runtime precondition test for the 'oflag'
+	 * parameter to the functionality of open(). It may be used when the macro
+	 * _FORTIFY_SOURCE is defined when compiling the application code.
+	 */
+	if (__OPEN_NEEDS_MODE(oflag)) {
+		const char *msg =
+			"invalid open call: O_CREAT or O_TMPFILE without mode\n";
+		ssize_t n = __STD(write(STDERR_FILENO, msg, strlen(msg)));
+		(void)n;
+		abort();
+	}
+
+	return do_open(path, oflag, 0);
+}
+
+COBALT_IMPL(int, __open64_2, (const char *path, int oflag))
+{
+	/* just like __open_2() and open64() */
+	if (__OPEN_NEEDS_MODE(oflag)) {
+		const char *msg =
+			"invalid open64 call: O_CREAT or O_TMPFILE without mode\n";
+		ssize_t n = __STD(write(STDERR_FILENO, msg, strlen(msg)));
+		(void)n;
+		abort();
+	}
+
+	return do_open(path, oflag | O_LARGEFILE, 0);
+}
+
 COBALT_IMPL(int, socket, (int protocol_family, int socket_type, int protocol))
 {
 	int s;
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index ed8fbaf16..860b26020 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -205,6 +205,18 @@ int __real_open64(const char *path, int oflag, ...)
 }
 #endif
 
+#if __USE_FORTIFY_LEVEL > 0
+__weak int __real___open_2(const char *path, int oflag)
+{
+	return __open_2(path, oflag);
+}
+
+__weak int __real___open64_2(const char *path, int oflag)
+{
+	return __open64_2(path, oflag);
+}
+#endif // __USE_FORTIFY_LEVEL > 0
+
 __weak
 int __real_socket(int protocol_family, int socket_type, int protocol)
 {
-- 
2.20.1


-- 
_____________________________________________________________
R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
Fon: +49 8444 9204-0
Fax: +49 8444 9204-50
www.rsi-elektrotechnik.de

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Gesch���ftsf���hrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


