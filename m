Message-ID: <491805AE.1060809@domain.hid>
Date: Mon, 10 Nov 2008 10:58:06 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090508020705090306050405"
Subject: [Xenomai-help] Mode switch when using RT heap on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090508020705090306050405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I realized that accessing memory allocated with rt_heap_alloc() causes
mode switches on ARM i.mx31. The attached patch provides a demo program
to demonstrate the problem, which actually does *not* show up on my
PowerPC TQM5200 board.

Wolfgang.

--------------090508020705090306050405
Content-Type: text/x-diff;
 name="example-rtheap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="example-rtheap.patch"

---
 examples/native/Makefile |    4 -
 examples/native/rtheap.c |  164 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+), 1 deletion(-)

Index: xenomai-2.4.x/examples/native/rtheap.c
===================================================================
--- /dev/null
+++ xenomai-2.4.x/examples/native/rtheap.c
@@ -0,0 +1,164 @@
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include <native/task.h>
+#include <native/timer.h>
+#include <native/heap.h>
+
+#define USE_HEAP
+//#define USE_SIGXCPU
+
+#define HEAP_SIZE (1024*1024)
+#define HEAP_MODE 0		/* Local heap. */
+
+RT_HEAP heap_desc;
+RT_TASK demo_task;
+
+
+static int block_sizes[] = {16, 20, 90, 150, 310, 800, 1000};
+
+/* NOTE: error handling omitted. */
+
+void demo(void *arg)
+{
+	RTIME now, previous;
+	void *block;
+	int sizes = sizeof(block_sizes) / sizeof(int);
+	int count = 0;
+	int size, err;
+	int *ptr;
+
+#ifdef USE_SIGXCPU
+	/* Ask Xenomai to warn us upon switches to secondary mode. */
+	rt_task_set_mode(0, T_WARNSW, NULL);
+#endif
+
+	/*
+	 * Arguments: &task (NULL=self),
+	 *            start time,
+	 *            period (here: 1 s)
+	 */
+	rt_task_set_periodic(NULL, TM_NOW, 10000000);
+	previous = rt_timer_read();
+
+	while (1) {
+		rt_task_wait_period(NULL);
+		now = rt_timer_read();
+
+		size = block_sizes[count % sizes];
+#ifdef USE_HEAP
+		/*
+		 * Request a 16-bytes block, asking for a non-blocking call
+		 * since only Xenomai tasks may block.
+		 */
+		err = rt_heap_alloc(&heap_desc, size, TM_NONBLOCK, &block);
+		if (err) {
+			printf("rt_heap_alloc() failed with %d\n", err);
+			break;
+		}
+
+		ptr = (int *)block;
+		*ptr = 0xdeadbeef;
+		if (*ptr != 0xdeadbeef) {
+			printf("Write/read test to heap failed\n");
+			break;
+		}
+
+		ptr = (int *)(block + size - sizeof(int));
+		*ptr = 0xbeefface;
+		if (*ptr != 0xbeefface) {
+			printf("Write/read test to heap failed\n");
+			break;
+		}
+
+		/* Free the block: */
+		rt_heap_free(&heap_desc, block);
+#endif
+
+		/*
+		 * NOTE: printf may have unexpected impact on the timing of
+		 *       your program. It is used here in the critical loop
+		 *       only for demonstration purposes.
+		 */
+		if ((count % 100) == 9) {
+			rt_printf("%d: Time since last turn: %ld.%06ld ms\n",
+				  count,
+				  (long)(now - previous) / 1000000,
+				  (long)(now - previous) % 1000000);
+			previous = now;
+		}
+		count++;
+	}
+}
+
+void catch_signal(int sig)
+{
+	printf("%s: sig=%d\n", __func__, sig);
+}
+
+#ifdef USE_SIGXCPU
+void catch_signal_msw(int sig)
+{
+	void *bt[32];
+	int nentries;
+		
+	rt_printf("%s: sig=%d\n", __func__, sig);
+
+	/* Dump a backtrace of the frame which caused the switch to
+	   secondary mode: */
+	nentries = backtrace(bt,sizeof(bt) / sizeof(bt[0]));
+	backtrace_symbols_fd(bt,nentries,fileno(stdout));
+}
+#endif
+
+int main(int argc, char* argv[])
+{
+	void *block;
+	int err;
+
+	signal(SIGTERM, catch_signal);
+	signal(SIGINT, catch_signal);
+#ifdef USE_SIGXCPU
+	signal(SIGXCPU, catch_signal_msw);
+#endif
+
+	/* Avoids memory swapping for this program */
+	mlockall(MCL_CURRENT | MCL_FUTURE);
+
+	/*
+	 * Create a 256Kb heap usable for dynamic memory allocation of
+	 * variable-size blocks in kernel space.
+	 */
+
+	err = rt_heap_create(&heap_desc, "MyHeapName", HEAP_SIZE, HEAP_MODE);
+	if (err)
+		return err;
+
+	/* Perform auto-init of rt_print buffers if the task doesn't do so */
+	rt_print_auto_init(1);
+
+	/* Initialise the rt_print buffer for this task explicitly */
+	rt_print_init(4096, "Task 1");
+
+	/*
+	 * Arguments: &task,
+	 *            name,
+	 *            stack size (0=default),
+	 *            priority,
+	 *            mode (FPU, start suspended, ...)
+	 */
+	rt_task_create(&demo_task, "trivial", 0, 99, 0);
+
+	/*
+	 * Arguments: &task,
+	 *            task function,
+	 *            function argument
+	 */
+	rt_task_start(&demo_task, &demo, NULL);
+
+	pause();
+
+	rt_task_delete(&demo_task);
+}
Index: xenomai-2.4.x/examples/native/Makefile
===================================================================
--- xenomai-2.4.x.orig/examples/native/Makefile
+++ xenomai-2.4.x/examples/native/Makefile
@@ -1,7 +1,7 @@
 ###### CONFIGURATION ######
 
 ### List of applications to be build
-APPLICATIONS = trivial-periodic sigxcpu rtprint
+APPLICATIONS = trivial-periodic sigxcpu rtprint rtheap
 
 ### Note: to override the search path for the xeno-config script, use "make XENO=..."
 
@@ -54,6 +54,8 @@ endif
 rtprint: rtprint.c
 	$(CC) $(CFLAGS) $? $(LDFLAGS) -lrtdk -o $@
 
+rtheap: rtheap.c
+	$(CC) $(CFLAGS) $? $(LDFLAGS) -lrtdk -o $@
 
 
 ###### KERNEL MODULE BUILD (no change required normally) ######

--------------090508020705090306050405--

