From: Norbert Lange <nolange79@gmail.com>
Date: Tue, 16 Oct 2018 12:34:50 +0200
Message-Id: <20181016103450.3189-1-norbert.lange@andritz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [PATCH] cobalt: fcntl uses void* instead of int
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

this is consistent with glibc internals,
and fixes truncation when passing 64bit pointers
---
 lib/cobalt/rtdm.c     | 4 ++--
 lib/cobalt/wrappers.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 6b8898e70..a01752cdd 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -139,11 +139,11 @@ static int do_ioctl(int fd, unsigned int request, void *arg)
 COBALT_IMPL(int, fcntl, (int fd, int cmd, ...))
 {
 	va_list ap;
-	int arg;
+	void *arg;
 	int ret;
 
 	va_start(ap, cmd);
-	arg = va_arg(ap, int);
+	arg = va_arg(ap, void *);
 	va_end(ap);
 
 	ret = XENOMAI_SYSCALL3(sc_cobalt_fcntl, fd, cmd, arg);
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 20ad63a61..2540e3c50 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -216,10 +216,10 @@ __weak
 int __real_fcntl(int fd, int cmd, ...)
 {
 	va_list ap;
-	int arg;
+	void *arg;
 
 	va_start(ap, cmd);
-	arg = va_arg(ap, int);
+	arg = va_arg(ap, void *);
 	va_end(ap);
 
 	return fcntl(fd, cmd, arg);
-- 
2.19.1


