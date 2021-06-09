From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/pipe: Add support for compat_ioctl
Message-ID: <0c98b3ff-18b1-959a-2e48-02bb19e6eb14@siemens.com>
Date: Wed, 9 Jun 2021 10:01:26 +0200
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
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

There are only two pipe IOCTLs that take arguments and both are int
pointers. Therefore, use the compat_ptr_ioctl pattern, just open-coding
it for support of kernels < 5.4.4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/pipe.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
index 9465fb2da..19064ea69 100644
--- a/kernel/cobalt/pipe.c
+++ b/kernel/cobalt/pipe.c
@@ -1052,6 +1052,16 @@ static long xnpipe_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
+/*
+ * Could be replaced with compat_ptr_ioctl if support for kernels < 5.4 is
+ * dropped.
+ */
+static long xnpipe_compat_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
+{
+	return xnpipe_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+
 static int xnpipe_fasync(int fd, struct file *file, int on)
 {
 	struct xnpipe_state *state = file->private_data;
@@ -1112,6 +1122,7 @@ static struct file_operations xnpipe_fops = {
 	.write = xnpipe_write,
 	.poll = xnpipe_poll,
 	.unlocked_ioctl = xnpipe_ioctl,
+	.compat_ioctl = xnpipe_compat_ioctl,
 	.open = xnpipe_open,
 	.release = xnpipe_release,
 	.fasync = xnpipe_fasync
-- 
2.26.2

