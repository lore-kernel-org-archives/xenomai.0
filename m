From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200706071049.32906.ngustavson@domain.hid>
References: <200706071049.32906.ngustavson@domain.hid>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 19:03:06 +0200
Message-Id: <1181235786.4998.108.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Fwd: can't use message pipe - Cannot
	allocate	memory
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: NZG <ngustavson@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-06-07 at 10:49 -0500, NZG wrote:
> I'm trying to pass a message from user space to Xenomai and it doesn't seem
>  to be working. I keep getting an error when attempting to write to the pipe
>  in user space.
> 
> rt_pipe_write error
> 
> : Cannot allocate memory
> 

Issue confirmed here when passing a non-zero poolsize. Passing 0 does
not seem to exhibit the problem. Could you re-check that both cases
actually fail on your side?

I have crafted a quick and dirty demo showing the problem. Until a
non-zero value is passed to rt_pipe_create() to specify a local pool,
everything is ok. (note: we could have used rt_pipe_write/rt_pipe_read
indifferently, they both end up calling rt_pipe_send/receive).

I'll have a look at this asap.

--- /dev/null	2006-05-31 03:15:07.000000000 +0200
+++ pipe/module/module.c	2007-06-07 18:48:00.000000000 +0200
@@ -0,0 +1,90 @@
+#include <native/task.h>
+#include <native/pipe.h>
+
+static RT_TASK task;
+
+static RT_PIPE pipe;
+
+#define ACK_STR "OK"
+
+static void test_task(void *cookie)
+{
+	RT_PIPE_MSG *msg, *ack;
+	ssize_t sz;
+	int s;
+
+	printk("Pipe open: waiting...\n");
+
+	for (;;) {
+		sz = rt_pipe_receive(&pipe, &msg, TM_INFINITE);
+
+		if (sz < 0)
+			break;
+
+		printk("Read %d bytes => %.*s\n", sz, sz, P_MSGPTR(msg));
+
+		s = rt_pipe_free(&pipe, msg);
+
+		if (s) {
+			printk("pipe free: failed %d\n", s);
+			goto fail;
+		}
+
+		ack = rt_pipe_alloc(&pipe, 3);
+
+		if (!ack) {
+			printk("pipe alloc: failed\n");
+			goto fail;
+		}
+
+		strcpy(P_MSGPTR(ack), ACK_STR);
+
+		sz = rt_pipe_send(&pipe, ack, 3, 0);	/* with \0 */
+
+		if (sz != sizeof(ACK_STR)) {
+			printk("pipe write: failed %d\n", sz);
+			goto fail;
+		}
+	}
+
+      fail:
+
+	return;
+}
+
+int test_init_module(void)
+{
+	int s;
+
+	s = rt_pipe_create(&pipe, "test", P_MINOR_AUTO, 0);
+
+	if (s) {
+		printk("pipe open: failed %d\n", s);
+		goto fail;
+	}
+
+	s = rt_task_create(&task, "pipe_task", 0, 1, 0);
+
+	if (s)
+		printk("task create: failed %d\n", s);
+	else {
+		s = rt_task_start(&task, &test_task, NULL);
+
+		if (s)
+			printk("task start: failed %d\n", s);
+	}
+
+ fail:
+	return s;
+}
+
+void test_cleanup_module(void)
+{
+	rt_pipe_delete(&pipe);
+	rt_task_delete(&task);
+}
+
+module_init(test_init_module);
+module_exit(test_cleanup_module);
+
+MODULE_LICENSE("GPL");
--- /dev/null	2006-05-31 03:15:07.000000000 +0200
+++ pipe/module/Makefile	2007-06-07 18:08:57.000000000 +0200
@@ -0,0 +1,5 @@
+EXTRA_CFLAGS += -Iinclude/xenomai
+
+obj-m += module_rt.o
+
+module_rt-objs := module.o
--- /dev/null	2006-05-31 03:15:07.000000000 +0200
+++ pipe/pipe.c	2007-06-07 18:49:25.000000000 +0200
@@ -0,0 +1,37 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+
+main()
+{
+	char buf[16];
+	int fd, n;
+    
+	fd = open("/proc/xenomai/registry/native/pipes/test", O_RDWR);
+
+	if (fd < 0) {
+		fprintf(stderr, "open(): %m\n");
+		exit(1);
+	}
+    
+	printf("open(): %m, fd: %d\n", fd);
+
+	n = write(fd, "Hello World", 11);
+
+	if (n != 11) {
+		perror("write");
+		exit(1);
+	}
+
+	n = read(fd, buf, sizeof(buf));
+
+	if (n < 0) {
+		perror("write");
+		exit(1);
+	}
+
+	printf("Received %.*s, n=%d\n", n, buf, n);
+
+	exit(0);
+}


-- 
Philippe.



