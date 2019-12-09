From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/cobalt: Change arg type in fcntl
Message-ID: <28d0e8cb-f5f1-6b91-728b-c5a55e7efcbd@siemens.com>
Date: Mon, 9 Dec 2019 17:52:29 +0100
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
Cc: Norbert Lange <nolange79@gmail.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Make use of the kernel interface change in c20ed9f14ff3 to fix
truncation on 64-bit systems when passing pointers.

Reported-by: Norbert Lange <nolange79@gmail.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I've noticed we still had an issue open...

 lib/cobalt/rtdm.c     | 4 ++--
 lib/cobalt/wrappers.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 2d58b38e66..9f3dcd25ff 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -145,11 +145,11 @@ static int do_ioctl(int fd, unsigned int request, void *arg)
 COBALT_IMPL(int, fcntl, (int fd, int cmd, ...))
 {
 	va_list ap;
-	int arg;
+	long arg;
 	int ret;
 
 	va_start(ap, cmd);
-	arg = va_arg(ap, int);
+	arg = va_arg(ap, long);
 	va_end(ap);
 
 	ret = XENOMAI_SYSCALL3(sc_cobalt_fcntl, fd, cmd, arg);
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 323f60b92e..ed8fbaf161 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -221,10 +221,10 @@ __weak
 int __real_fcntl(int fd, int cmd, ...)
 {
 	va_list ap;
-	int arg;
+	long arg;
 
 	va_start(ap, cmd);
-	arg = va_arg(ap, int);
+	arg = va_arg(ap, long);
 	va_end(ap);
 
 	return fcntl(fd, cmd, arg);
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

