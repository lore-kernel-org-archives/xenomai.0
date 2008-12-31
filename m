From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 31 Dec 2008 01:20:02 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yqrWJCybYJ6++w8"
Message-Id: <200812310120.02617.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] [PATCH 2/2] RTDM in user mode
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

--Boundary-00=_yqrWJCybYJ6++w8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch 2: examples.

--Boundary-00=_yqrWJCybYJ6++w8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xenomai-rtdm-proposal_p2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xenomai-rtdm-proposal_p2.diff"

 Makefile           |   94 ++++++++++++++++++++++++++++
 test01_task.c      |   62 ++++++++++++++++++
 test02_event_sem.c |  160 +++++++++++++++++++++++++++++++++++++++++++++++
 test03_timer.c     |   60 +++++++++++++++++
 test04_mutex.c     |   86 +++++++++++++++++++++++++
 test05_nrtsig.c    |   82 ++++++++++++++++++++++++
 test06_spinlock.c  |   84 +++++++++++++++++++++++++
 test07_heap.c      |   76 ++++++++++++++++++++++
 test08_device.c    |  131 +++++++++++++++++++++++++++++++++++++++
 test09_driver.c    |  150 ++++++++++++++++++++++++++++++++++++++++++++
 test10_mmap.c      |  177 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 1162 insertions(+)

Index: examples/rtdm/user-api/Makefile
===================================================================
--- examples/rtdm/user-api/Makefile	(revision 0)
+++ examples/rtdm/user-api/Makefile	(revision 0)
@@ -0,0 +1,94 @@
+
+###### CONFIGURATION ######
+
+### List of applications to be build
+APPLICATIONS = test01_task test02_event_sem test03_timer \
+	test04_mutex test05_nrtsig test06_spinlock test07_heap \
+	test08_device test09_driver test10_mmap
+
+### Note: to override the search path for the xeno-config script, use "make XENO=..."
+
+
+### List of modules to be build
+MODULES = 
+
+### Note: to override the kernel source path, use "make KSRC=..."
+
+
+
+###### USER SPACE BUILD (no change required normally) ######
+ifeq ($(KERNELRELEASE),)
+ifneq ($(APPLICATIONS),)
+
+### Default Xenomai installation path
+XENO ?= /usr/xenomai
+
+XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config 2>/dev/null)
+
+### Sanity check
+ifeq ($(XENOCONFIG),)
+all::
+	@echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\" <<<"
+	@echo
+endif
+
+
+CC=$(shell $(XENOCONFIG) --cc)
+
+CFLAGS=$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)
+
+LDFLAGS=$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lrtdm_user
+
+# This includes the library path of given Xenomai into the binary to make live
+# easier for beginners if Xenomai's libs are not in any default search path.
+LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)
+
+all:: $(APPLICATIONS)
+
+clean::
+	$(RM) $(APPLICATIONS) *.o
+
+endif
+endif
+
+
+
+###### KERNEL MODULE BUILD (no change required normally) ######
+ifneq ($(MODULES),)
+
+### Default to sources of currently running kernel
+KSRC ?= /lib/modules/$(shell uname -r)/build
+
+OBJS     := ${patsubst %, %.o, $(MODULES)}
+CLEANMOD := ${patsubst %, .%*, $(MODULES)}
+PWD      := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
+
+### Kernel 2.6
+ifeq ($(findstring 2.6,$(KSRC)),2.6)
+
+obj-m        := $(OBJS)
+EXTRA_CFLAGS := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix $(ADD_CFLAGS)
+
+all::
+	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules
+
+### Kernel 2.4
+else
+
+ARCH    ?= $(shell uname -i)
+INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix
+CFLAGS  += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE)
+
+all:: $(OBJS)
+
+endif
+
+## Target for capturing 2.4 module CFLAGS
+modules:
+	@echo "$(CFLAGS)"
+
+clean::
+	$(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers modules.order
+	$(RM) -R .tmp*
+
+endif
Index: examples/rtdm/user-api/test01_task.c
===================================================================
--- examples/rtdm/user-api/test01_task.c	(revision 0)
+++ examples/rtdm/user-api/test01_task.c	(revision 0)
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+
+#include <rtdm/rtdm_driver.h>
+
+void task_proc(void *arg)
+{
+	int i;
+
+	printf("test01_task[RT]: task started\n");
+	
+	for(i = 0; i < 10; i++) {
+		rtdm_task_sleep(1000000000);
+		printf("test01_task[RT]: task awoken (i=%d)\n", i);
+	}
+
+	printf("test01_task: leaving task\n");	
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_task_t task;
+	int err;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	err = rtdm_task_init(&task, 
+			     "TEST TASK", 
+			     task_proc, NULL, RTDM_TASK_HIGHEST_PRIORITY, 0);
+
+	if(err != 0) {
+		printf("test01_task[main]: task creation failed (err=%d)\n",err);		
+		return err;
+	}
+	
+	printf("test01_task[main]: waiting for the task completion\n");
+
+	rtdm_task_join_nrt(&task, 100);
+
+	printf("test01_task[main]: task destroyed\n");
+
+	return 0;
+}
Index: examples/rtdm/user-api/test02_event_sem.c
===================================================================
--- examples/rtdm/user-api/test02_event_sem.c	(revision 0)
+++ examples/rtdm/user-api/test02_event_sem.c	(revision 0)
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+#include <getopt.h>
+#include <errno.h>
+
+#include <rtdm/rtdm_driver.h>
+
+#define MAX_TASK_COUNT 10
+#define MAX_TASK_NAME 32
+
+static int verbose;
+static int use_sem;
+static struct option test_opts[] = {
+	{"help", no_argument, NULL, 'h'},
+	{"verbose", no_argument, NULL, 'v'},
+	{"semaphore", no_argument, NULL, 's'},
+	{0},
+};
+
+rtdm_event_t evts[MAX_TASK_COUNT];
+rtdm_sem_t sems[MAX_TASK_COUNT];
+
+void task_proc_event(void *arg)
+{
+	int i, idx = (int) arg;
+	int nxt_idx = (idx == MAX_TASK_COUNT - 1) ? 0 : idx + 1;
+
+	printf("test02_event_sem[%d]: task started (nxt=%d)\n", idx, nxt_idx);
+	
+	for(i = 0; i < 10; i++) {
+
+		rtdm_event_wait(&evts[idx]);
+		printf("test02_event_sem[%d]: event received (i=%d)\n", idx, i);
+
+		rtdm_task_sleep(100000000);
+		if(verbose)
+			printf("test02_event_sem[%d]: task awoken (i=%d)\n", idx, i);
+
+		rtdm_event_signal(&evts[nxt_idx]);
+		printf("test02_event_sem[%d]: event sent (i=%d)\n", idx, i);
+	}
+
+	printf("test02_event_sem[%d]: leaving task\n", idx);	
+}
+
+void task_proc_sem(void *arg)
+{
+	int i, idx = (int) arg;
+	int nxt_idx = (idx == MAX_TASK_COUNT - 1) ? 0 : idx + 1;
+
+	printf("test02_event_sem[%d]: task started (nxt=%d)\n", idx, nxt_idx);
+	
+	for(i = 0; i < 10; i++) {
+
+		rtdm_sem_down(&sems[idx]);
+		printf("test02_event_sem[%d]: semaphore taken (i=%d)\n", idx, i);
+
+		rtdm_task_sleep(100000000);
+		if(verbose)
+			printf("test02_event_sem[%d]: task awoken (i=%d)\n", idx, i);
+
+		rtdm_sem_up(&sems[nxt_idx]);
+		printf("test02_event_sem[%d]: semaphore released (i=%d)\n", idx, i);
+	}
+
+	printf("test02_event_sem[%d]: leaving task\n", idx);	
+}
+
+void do_print_usage(void)
+{
+	fprintf(stdout,
+		"usage:\ttest02_event_sem [OPTS]\n");
+	fprintf(stdout, "\tOPTS:\t -v, --verbose: verbose output\n");
+	fprintf(stdout, "\t\t -s, --semaphore: use semaphore instead of event\n");
+	fprintf(stdout, "\t\t -h, --help: print this help\n");	
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_task_t tasks[MAX_TASK_COUNT];
+	char task_name[MAX_TASK_NAME];
+	int c, i, err;
+
+	/* Computes arguments */
+	while ((c =
+		getopt_long(argc, argv, "hvs", test_opts, NULL)) >= 0) {
+		switch (c) {
+		case 'v':
+			verbose = 1;
+			break;
+		case 's':
+			use_sem = 1;
+			break;
+		case 'h':
+		default:
+			do_print_usage();
+			return -EINVAL;
+		}
+	}
+		
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	for(i = 0; i < MAX_TASK_COUNT; i++) {
+
+		sprintf(task_name, "TEST TASK %d", i);
+
+		rtdm_event_init(&evts[i], 0);
+		rtdm_sem_init(&sems[i], 0);
+
+		err = rtdm_task_init(&tasks[i], 
+				     task_name, 
+				     use_sem ? task_proc_sem : task_proc_event, 
+				     (void *)i, RTDM_TASK_HIGHEST_PRIORITY, 0);
+
+		if(err != 0) {
+			printf("test02_event_sem: task creation failed (err=%d)\n",err);		
+			return err;
+		}	
+	}
+
+	if(verbose)
+		printf("test02_event_sem[main]: using %s as inter-task synch tools\n",
+		       use_sem ? "semaphores" : "events");
+	
+
+	printf("test02_event_sem[main]: awaking the first task \n");
+	rtdm_event_signal(&evts[0]);
+	rtdm_sem_up(&sems[0]);
+
+	if(verbose)
+		printf("test02_event_sem[main]: waiting for the task completion\n");
+	rtdm_task_join_nrt(&tasks[MAX_TASK_COUNT - 1], 100);
+	
+	if(verbose)
+		printf("test02_event_sem[main]: tasks destroyed\n");
+
+	/* The events / semaphores are not destroyed on purpose;
+	   this test expects the skin callback to clean them */
+
+	return 0;
+}
Index: examples/rtdm/user-api/test03_timer.c
===================================================================
--- examples/rtdm/user-api/test03_timer.c	(revision 0)
+++ examples/rtdm/user-api/test03_timer.c	(revision 0)
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include <rtdm/rtdm_driver.h>
+
+void timer_handler(rtdm_timer_t *timer)
+{
+	printf("test03_timer[handler]: timer occurence\n");
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_timer_t timer;
+	int err;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	err = rtdm_timer_init(&timer, timer_handler, "TEST TIMER");
+	if(err < 0) {
+		printf("test03_timer[main]: rtdm_timer_init failed (err=%d)\n",
+		       err);
+		return err;
+	}
+	
+	err = rtdm_timer_start(&timer, 1000000, 1000000000, RTDM_TIMERMODE_RELATIVE);
+	if(err < 0) {
+		printf("test03_timer[main]: rtdm_timer_init failed (err=%d)\n",
+		       err);
+		goto out;
+	}	
+	
+	sleep(10);
+
+	rtdm_timer_stop(&timer);
+
+out:
+	rtdm_timer_destroy(&timer);
+
+	return err;
+}
Index: examples/rtdm/user-api/test04_mutex.c
===================================================================
--- examples/rtdm/user-api/test04_mutex.c	(revision 0)
+++ examples/rtdm/user-api/test04_mutex.c	(revision 0)
@@ -0,0 +1,86 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+
+#include <rtdm/rtdm_driver.h>
+
+#define MAX_TASK_COUNT 2
+#define MAX_TASK_NAME 32
+
+rtdm_mutex_t mutex;
+
+void task_proc(void *arg)
+{
+	int i, idx = (int) arg;
+
+	printf("test04_mutex[%d]: task started\n", idx);	
+
+	for(i = 0; i < 10; i++) {
+
+		rtdm_mutex_lock(&mutex);
+		printf("test04_mutex[%d]: mutex locked (i=%d)\n", idx, i);	
+
+		rtdm_task_sleep(100000000);
+		printf("test04_mutex[%d]: task awoken (i=%d)\n", idx, i);
+
+		rtdm_mutex_unlock(&mutex);
+		printf("test04_mutex[%d]: mutex unlocked (i=%d)\n", idx, i);
+	}
+
+	printf("test04_mutex[%d]: leaving task\n", idx);
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_task_t tasks[MAX_TASK_COUNT];
+	char task_name[MAX_TASK_NAME];
+	int i, err;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	rtdm_mutex_init(&mutex);
+
+	for(i = 0; i < MAX_TASK_COUNT; i++) {
+
+		sprintf(task_name, "TEST TASK %d", i);
+		
+		err = rtdm_task_init(&tasks[i], 
+				     task_name, 
+				     task_proc, 
+				     (void *)i, RTDM_TASK_HIGHEST_PRIORITY, 0);
+
+		if(err != 0) {
+			printf("test04_mutex: task creation failed (err=%d)\n",err);
+			return err;
+		}		
+	}
+
+	printf("test04_mutex[main]: waiting for the task completion\n");
+
+	rtdm_task_join_nrt(&tasks[MAX_TASK_COUNT - 1], 100);
+
+	printf("test04_mutex[main]: tasks destroyed\n");		
+
+	/* The mutex is x not destroyed on purpose;
+	   this test expects the skin callback to clean them */
+
+	return 0;
+}
Index: examples/rtdm/user-api/test05_nrtsig.c
===================================================================
--- examples/rtdm/user-api/test05_nrtsig.c	(revision 0)
+++ examples/rtdm/user-api/test05_nrtsig.c	(revision 0)
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+
+#include <rtdm/rtdm_driver.h>
+
+void task_proc(void *arg)
+{
+	rtdm_nrtsig_t *nrt_sig = (rtdm_nrtsig_t *)arg;
+	int i;
+
+	for(i = 0; i < 10; i++) {
+
+		printf("test05_nrtsig[RT]:: launching NRT signal (i=%d)\n", i);
+		rtdm_nrtsig_pend(nrt_sig);
+
+		rtdm_task_sleep(100000000);
+		printf("test05_nrtsig[RT]:: task awoken (i=%d)\n", i);
+	}
+
+	printf("test05_nrtsig[RT]: leaving task\n");
+}
+
+void nrtsig_handler(unsigned int virq, void *arg)
+{
+	printf("test05_nrtsig[NRT]: handler called\n");
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_task_t task;
+	rtdm_nrtsig_t nrt_sig;
+	int err;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	err = rtdm_nrtsig_init(&nrt_sig, nrtsig_handler, NULL);
+
+	if(err != 0) {
+		printf("test05_nrtsig[main]: NRT signal creation failed (err=%d)\n",
+		       err);
+		return err;
+	}
+
+	err = rtdm_task_init(&task, 
+			     "TEST TASK", 
+			     task_proc, &nrt_sig, RTDM_TASK_HIGHEST_PRIORITY, 0);
+
+	if(err != 0) {
+		printf("test05_nrtsig[main]: task creation failed (err=%d)\n",err);
+		return err;
+	}
+
+	printf("test05_nrtsig[main]: waiting for the task completion\n");
+
+	rtdm_task_join_nrt(&task, 100);
+
+	printf("test05_nrtsig[main]: task destroyed\n");		
+
+	/* The NRT signal is not destroyed on purpose;
+	   this test expects the skin callback to clean it */
+
+	return 0;
+}
Index: examples/rtdm/user-api/test06_spinlock.c
===================================================================
--- examples/rtdm/user-api/test06_spinlock.c	(revision 0)
+++ examples/rtdm/user-api/test06_spinlock.c	(revision 0)
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+
+#include <rtdm/rtdm_driver.h>
+
+#define MAX_TASK_COUNT 2
+#define MAX_TASK_NAME 32
+
+rtdm_lock_t spinlock = RTDM_LOCK_UNLOCKED;
+
+void task_proc(void *arg)
+{
+	int i, idx = (int) arg;
+	rtdm_lockctx_t context;
+
+	printf("test06_spinlock[%d]: task started\n", idx);	
+
+	for(i = 0; i < 10; i++) {
+
+		rtdm_lock_get_irqsave(&spinlock, context);
+		printf("test06_spinlock[%d]: spinlock locked (i=%d)\n", idx, i);	
+
+		rtdm_lock_put_irqrestore(&spinlock, context);
+		printf("test06_spinlock[%d]: spinlock unlocked (i=%d)\n", idx, i);
+
+		rtdm_task_sleep(100000000);
+		printf("test06_spinlock[%d]: task awoken (i=%d)\n", idx, i);
+	}
+
+	printf("test06_spinlock[%d]: leaving task\n", idx);
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_task_t tasks[MAX_TASK_COUNT];
+	char task_name[MAX_TASK_NAME];
+	int i, err;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	for(i = 0; i < MAX_TASK_COUNT; i++) {
+
+		sprintf(task_name, "TEST TASK %d", i);
+		
+		err = rtdm_task_init(&tasks[i], 
+				     task_name, 
+				     task_proc, 
+				     (void *)i, RTDM_TASK_HIGHEST_PRIORITY, 0);
+
+		if(err != 0) {
+			printf("test06_spinlock: task creation failed (err=%d)\n",err);
+			return err;
+		}		
+	}
+
+	printf("test06_spinlock[main]: waiting for the task completion\n");
+
+	rtdm_task_join_nrt(&tasks[MAX_TASK_COUNT - 1], 100);
+
+	printf("test06_spinlock[main]: tasks destroyed\n");		
+
+	/* No need to destroy the spinlock */
+
+	return 0;
+}
Index: examples/rtdm/user-api/test07_heap.c
===================================================================
--- examples/rtdm/user-api/test07_heap.c	(revision 0)
+++ examples/rtdm/user-api/test07_heap.c	(revision 0)
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+#include <string.h>
+
+#include <rtdm/rtdm_driver.h>
+
+void task_proc(void *arg)
+{
+	int i;
+	void *block;
+
+	printf("test07_heap[RT]: task started\n");
+	
+	for(i = 0; i < 10; i++) {
+
+		block = rtdm_malloc(sizeof(rtdm_task_t));
+
+		printf("test07_heap[RT]: allocated block = 0x%x (i=%d)\n", block, i);
+
+		memset(block, 0, sizeof(rtdm_task_t));
+
+		rtdm_task_sleep(1000000000);
+
+		if(i % 2 == 0) {
+			rtdm_free(block);
+			printf("test07_heap[RT]: freed block = 0x%x (i=%d)\n", 
+			       block, i);			
+		}
+	}
+
+	printf("test07_heap[RT]: leaving task\n");	
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_task_t task;
+	int err;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	err = rtdm_task_init(&task, 
+			     "TEST TASK", 
+			     task_proc, NULL, RTDM_TASK_HIGHEST_PRIORITY, 0);
+
+	if(err != 0) {
+		printf("test07_heap[main]: task creation failed (err=%d)\n",err);		
+		return err;
+	}
+	
+	printf("test07_heap[main]: waiting for the task completion\n");
+
+	rtdm_task_join_nrt(&task, 100);
+
+	printf("test07_heap[main]: task destroyed\n");
+
+	return 0;
+}
Index: examples/rtdm/user-api/test08_device.c
===================================================================
--- examples/rtdm/user-api/test08_device.c	(revision 0)
+++ examples/rtdm/user-api/test08_device.c	(revision 0)
@@ -0,0 +1,131 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+#include <string.h>
+
+#include <rtdm/rtdm_driver.h>
+
+struct dummy_context {
+	int nouse;
+};
+
+int test_dev_open(struct rtdm_dev_context *context,
+		  rtdm_user_info_t * user_info, int flags)
+{
+	rtdm_printk("test08_device[DRV]: test_dev_open called\n");
+	return 0;
+}
+
+int test_dev_close(struct rtdm_dev_context *context, rtdm_user_info_t * user_info)
+{
+	rtdm_printk("test08_device[DRV]: test_dev_close called\n");
+	return 0;
+}
+
+ssize_t test_dev_read(struct rtdm_dev_context * context,
+		      rtdm_user_info_t * user_info, void *buf, size_t nbytes)
+{
+	rtdm_printk("test08_device[DRV]: test_dev_read called\n");
+	return 0;
+}
+
+ssize_t test_dev_write(struct rtdm_dev_context * context,
+		       rtdm_user_info_t * user_info, 
+		       const void *buf, size_t nbytes)
+{
+	rtdm_printk("test08_device[DRV]: test_dev_write called\n");
+	return 0;
+}
+
+int test_dev_ioctl(struct rtdm_dev_context *context,
+		   rtdm_user_info_t * user_info, unsigned int request, void *arg)
+{
+	rtdm_printk("test08_device[DRV]: test_dev_ioctl called\n");
+	return 0;
+}
+
+static struct rtdm_device test_dev = {
+	.struct_version = RTDM_DEVICE_STRUCT_VER,
+	.device_flags = RTDM_NAMED_DEVICE,
+	.context_size = sizeof(struct dummy_context),
+	.device_name = "test_dev",
+	.open_rt = test_dev_open,
+	
+	.ops = {
+		.close_rt = test_dev_close,
+		.ioctl_rt = test_dev_ioctl,
+		.read_rt = test_dev_read,
+		.write_rt = test_dev_write,
+	},
+
+	.device_class = RTDM_CLASS_EXPERIMENTAL,
+	.driver_name = "Test user driver",
+	.driver_version = RTDM_DRIVER_VER(0, 0, 1),
+
+	.peripheral_name = "Test user device",
+};
+
+void task_proc(void *arg)
+{
+	int fd;
+
+	rtdm_printk("test08_device[RT]: task started\n");
+	
+	fd = rt_dev_open("test_dev", 0);
+
+	rt_dev_read(fd, NULL, 0);
+
+	rt_dev_write(fd, NULL, 0);
+
+	rt_dev_close(fd);
+
+	rtdm_printk("test08_device[RT]: leaving task\n");	
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_task_t task;
+	int err;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	err = rtdm_dev_register(&test_dev);
+
+	err = rtdm_task_init(&task, 
+			     "TEST TASK", 
+			     task_proc, NULL, RTDM_TASK_HIGHEST_PRIORITY, 0);
+
+	if(err != 0) {
+		rtdm_printk("test08_device[main]: task creation failed (err=%d)\n",
+			    err);		
+		return err;
+	}
+	
+	rtdm_printk("test08_device[main]: waiting for the task completion\n");
+
+	rtdm_task_join_nrt(&task, 100);
+
+	rtdm_printk("test08_device[main]: task destroyed\n");
+
+	err = rtdm_dev_unregister(&test_dev, 0);
+
+	return 0;
+}
Index: examples/rtdm/user-api/test09_driver.c
===================================================================
--- examples/rtdm/user-api/test09_driver.c	(revision 0)
+++ examples/rtdm/user-api/test09_driver.c	(revision 0)
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+#include <string.h>
+
+#include <rtdm/rtdm_driver.h>
+
+struct dummy_context {
+	int nouse;
+};
+
+int test_drv_open(struct rtdm_dev_context *context,
+		  rtdm_user_info_t * user_info, int flags)
+{
+	rtdm_printk("test09_driver[DRV]: test_drv_open called\n");
+	return 0;
+}
+
+int test_drv_close(struct rtdm_dev_context *context, rtdm_user_info_t * user_info)
+{
+	rtdm_printk("test09_driver[DRV]: test_drv_close called\n");
+	return 0;
+}
+
+ssize_t test_drv_read(struct rtdm_dev_context * context,
+		      rtdm_user_info_t * user_info, void *buf, size_t nbytes)
+{
+	unsigned char _b[8] = { 0xa, 0x5, 0xa, 0x5, 0xa, 0x5, 0xa, 0x5 };
+	unsigned int _count = nbytes > 8 ? 8 : nbytes;
+
+	rtdm_printk("test09_driver[DRV]: test_drv_read called\n");	
+
+	return rtdm_safe_copy_to_user(user_info, buf, _b, _count);
+}
+
+ssize_t test_drv_write(struct rtdm_dev_context * context,
+		       rtdm_user_info_t * user_info, 
+		       const void *buf, size_t nbytes)
+{
+	unsigned char _b[8];
+	unsigned int i, _count = nbytes > 8 ? 8 : nbytes;
+
+	rtdm_printk("test09_driver[DRV]: test_drv_write called\n");
+
+	if(rtdm_safe_copy_from_user(user_info, _b, buf, _count) < 0)
+		return -EFAULT;
+	   
+	rtdm_printk("test09_driver[DRV]: data = { ");
+
+	for(i = 0; i < _count; i++)
+		rtdm_printk("0x%x, ", _b[i]);
+
+	rtdm_printk("}\n");
+
+	return 0;
+}
+
+int test_drv_ioctl(struct rtdm_dev_context *context,
+		   rtdm_user_info_t * user_info, unsigned int request, void *arg)
+{
+	rtdm_printk("test09_driver[DRV]: test_drv_ioctl called\n");
+	return 0;
+}
+
+static struct rtdm_device test_drv = {
+	.struct_version = RTDM_DEVICE_STRUCT_VER,
+	.device_flags = RTDM_NAMED_DEVICE,
+	.context_size = sizeof(struct dummy_context),
+	.device_name = "test_drv",
+	.open_rt = test_drv_open,
+	
+	.ops = {
+		.close_rt = test_drv_close,
+		.ioctl_rt = test_drv_ioctl,
+		.read_rt = test_drv_read,
+		.write_rt = test_drv_write,
+	},
+
+	.device_class = RTDM_CLASS_EXPERIMENTAL,
+	.driver_name = "Test user driver",
+	.driver_version = RTDM_DRIVER_VER(0, 0, 1),
+
+	.peripheral_name = "Test user device",
+};
+
+void task_proc(void *arg)
+{
+	int fd;
+	unsigned char buf[8];
+
+	rtdm_printk("test09_driver[RT]: task started\n");
+	
+	fd = rt_dev_open("test_drv", 0);
+
+	rt_dev_read(fd, buf, 8);
+
+	rt_dev_write(fd, buf, 8);
+
+	rt_dev_close(fd);
+
+	rtdm_printk("test09_driver[RT]: leaving task\n");	
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_task_t task;
+	int err;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	err = rtdm_dev_register(&test_drv);
+
+	err = rtdm_task_init(&task, 
+			     "TEST TASK", 
+			     task_proc, NULL, RTDM_TASK_HIGHEST_PRIORITY, 0);
+
+	if(err != 0) {
+		rtdm_printk("test09_driver[main]: task creation failed (err=%d)\n",
+			    err);		
+		return err;
+	}
+	
+	rtdm_printk("test09_driver[main]: waiting for the task completion\n");
+
+	rtdm_task_join_nrt(&task, 100);
+
+	rtdm_printk("test09_driver[main]: task destroyed\n");
+
+	err = rtdm_dev_unregister(&test_drv, 0);
+
+	return 0;
+}
Index: examples/rtdm/user-api/test10_mmap.c
===================================================================
--- examples/rtdm/user-api/test10_mmap.c	(revision 0)
+++ examples/rtdm/user-api/test10_mmap.c	(revision 0)
@@ -0,0 +1,177 @@
+/*
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
+ * Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+#include <string.h>
+
+#include <rtdm/rtdm_driver.h>
+
+#define TEST_IO 'c'
+#define TEST_MAP_IOCTL _IOWR(TEST_IO, 0, unsigned int)
+
+#define TEST_MAP_BUF_SIZE 0x100
+
+struct map_context {
+	void *buf;
+};
+
+void test_vm_open(struct vm_area_struct *area)
+{
+	void *priv = (unsigned long *)area->vm_private_data;
+	rtdm_printk("test10_mmap[DRV]: test_vm_open called (priv=0x%x)\n", priv);
+}
+
+void test_vm_close(struct vm_area_struct *area)
+{
+	void *priv = (unsigned long *)area->vm_private_data;
+	rtdm_printk("test10_mmap[DRV]: test_vm_close called (priv=0x%x)\n", priv);
+}
+
+static struct vm_operations_struct test_map_ops = {
+      .open = test_vm_open,
+      .close = test_vm_close,
+};
+
+int test_map_open(struct rtdm_dev_context *context,
+		  rtdm_user_info_t * user_info, int flags)
+{
+	struct map_context *cxt = (struct map_context *)context->dev_private;
+
+	rtdm_printk("test10_mmap[DRV]: test_map_open called\n");
+
+	cxt->buf = rtdm_malloc(TEST_MAP_BUF_SIZE);
+	if(cxt->buf == NULL)
+		return -ENOMEM;
+
+	memset(cxt->buf, 0xa5, TEST_MAP_BUF_SIZE);
+
+	return 0;
+}
+
+int test_map_close(struct rtdm_dev_context *context, rtdm_user_info_t * user_info)
+{
+	struct map_context *cxt = (struct map_context *)context->dev_private;
+
+	rtdm_printk("test10_mmap[DRV]: test_map_close called\n");
+
+	if(cxt->buf != NULL)
+		rtdm_free(cxt->buf);
+
+	return 0;
+}
+
+int test_map_ioctl(struct rtdm_dev_context *context,
+		   rtdm_user_info_t * user_info, unsigned int request, void *arg)
+{
+	struct map_context *cxt = (struct map_context *)context->dev_private;
+	int err;
+	void *ptr;
+
+	rtdm_printk("test10_mmap[DRV]: test_map_ioctl called\n");
+
+	if(request != TEST_MAP_IOCTL)
+		return -EINVAL;
+
+	err = rtdm_mmap_to_user(user_info, 
+				cxt->buf, 
+				TEST_MAP_BUF_SIZE, 
+				PROT_READ | PROT_WRITE, &ptr, &test_map_ops, NULL);
+	
+	return rtdm_safe_copy_to_user(user_info, arg, &ptr, sizeof(unsigned long));
+}
+
+static struct rtdm_device test_map = {
+	.struct_version = RTDM_DEVICE_STRUCT_VER,
+	.device_flags = RTDM_NAMED_DEVICE,
+	.context_size = sizeof(struct map_context),
+	.device_name = "test_map",
+	.open_rt = test_map_open,
+	
+	.ops = {
+		.close_rt = test_map_close,
+		.ioctl_rt = test_map_ioctl,
+	},
+
+	.device_class = RTDM_CLASS_EXPERIMENTAL,
+	.driver_name = "Test user driver",
+	.driver_version = RTDM_DRIVER_VER(0, 0, 1),
+
+	.peripheral_name = "Test user device",
+};
+
+void task_proc(void *arg)
+{
+	int fd, err, i;
+	unsigned char *map_base;
+	unsigned char buf[8];
+
+	rtdm_printk("test10_mmap[RT]: task started\n");
+	
+	fd = rt_dev_open("test_map", 0);
+	if(fd < 0)
+		return;
+	
+	err = rt_dev_ioctl(fd, TEST_MAP_IOCTL, &map_base);
+	if(err < 0)
+		goto out_task;
+
+	for(i = 0; i < TEST_MAP_BUF_SIZE; i++) {
+		rtdm_printk("0x%x", map_base[i]);
+		if((i + 1) % 8 == 0)
+			rtdm_printk("\n");
+		else
+			rtdm_printk(", ");
+	}
+
+out_task:
+	rt_dev_close(fd);
+
+	rtdm_printk("test10_mmap[RT]: leaving task\n");	
+}
+
+int main(int argc, char *argv[])
+{
+	rtdm_task_t task;
+	int err;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	err = rtdm_dev_register(&test_map);
+
+	err = rtdm_task_init(&task, 
+			     "TEST TASK", 
+			     task_proc, NULL, RTDM_TASK_HIGHEST_PRIORITY, 0);
+
+	if(err != 0) {
+		rtdm_printk("test10_mmap[main]: task creation failed (err=%d)\n",
+			    err);		
+		return err;
+	}
+	
+	rtdm_printk("test10_mmap[main]: waiting for the task completion\n");
+
+	rtdm_task_join_nrt(&task, 100);
+
+	rtdm_printk("test10_mmap[main]: task destroyed\n");
+
+	err = rtdm_dev_unregister(&test_map, 0);
+
+	return 0;
+}

--Boundary-00=_yqrWJCybYJ6++w8--


