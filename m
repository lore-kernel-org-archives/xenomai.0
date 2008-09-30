From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 30 Sep 2008 21:48:44 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dKo4I3M1nBpeAy4"
Message-Id: <200809302148.45123.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Updated ksrc/skins/native/snippet/user_irq.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_dKo4I3M1nBpeAy4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

While I struggled to test the Xenomai interrupt handling on my PPC405 system, 
I finally found at least a nice example to see that a few things are indeed 
working fine.

I attach the modified user_irq.c, which I used to add a custom interrupt
handling routine to the ethernet receive interrupt and propagating it
afterwards to the Linux kernel.

I think it is quite a neat example and should be able to run on a variety of 
platforms if the user selects an appropriate IRQ.

Is the attached patch good enough or did I made any mistakes?

Best regards

-- 
NIklaus Giger


--Boundary-00=_dKo4I3M1nBpeAy4
Content-Type: text/x-patch;
  charset="us-ascii";
  name="user_irq.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="user_irq.diff"

Index: ksrc/skins/native/snippets/user_irq.c
===================================================================
--- ksrc/skins/native/snippets/user_irq.c	(Revision 4192)
+++ ksrc/skins/native/snippets/user_irq.c	(Arbeitskopie)
@@ -1,57 +1,111 @@
+/*
+ * (c) 2008 Niklaus Giger, niklaus.giger@domain.hid
+ *
+ * A small example which shows how to use the native xenomai skin to
+ * catch an interrupt and forward it afterwards to the Linux kernel.
+ *
+ * Take some care to choose the interrupt you want to use.
+ * Use one, which shows up in /proc/interrupts and which has quite few
+ * occurences. E.g. I did choose 18 as my /proc/interrupts looked like
+ * 	     CPU0
+ * 16:        194   UIC   Level     serial
+ * 17:       7932   UIC   Level     MAL TX EOB
+ * 18:      12895   UIC   Level     MAL RX EOB
+ * After running the interrupt service routine we will forward the interrupt to
+ * the linux kernel. Therefore no harm should be done by intercepting it.
+ *
+ */
+#define IRQ_NR    18
+
 #include <sys/mman.h>
 #include <native/task.h>
 #include <native/intr.h>
+#include <unistd.h>
+#include <stdlib.h>
 
-#define IRQ_NUMBER 7  /* Intercept interrupt #7 */
 #define TASK_PRIO  99 /* Highest RT priority */
 #define TASK_MODE  0  /* No flags */
 #define TASK_STKSZ 0  /* Stack size (use default one) */
 
+void cleanup (void);
+
 RT_INTR intr_desc;
-
 RT_TASK server_desc;
 
+static int counter;
+
 void irq_server (void *cookie)
-
 {
-    for (;;) {
+	int j;
+	for (;;) {
 
-       /* Wait for the next interrupt on channel #7. */
-       err = rt_intr_wait(&intr_desc,TM_INFINITE);
-
-       if (!err) {
-           /* Process interrupt. */
-       }
-    }
+		/* Wait for the next interrupt. */
+		j = rt_intr_wait(&intr_desc,TM_INFINITE);
+		if (j == -EIDRM) {
+			printf("%s: interrupt descriptor deleted. Exit?\n",
+				__FUNCTION__);
+			return;
+		}
+		if (j<0) {
+			printf("%s: error %d occured. We will exit\n",
+				__FUNCTION__, j);
+			return;
+		}
+		/* j is the nr of times the interrupt occured */
+		counter+= j;
+		/* Process interrupt.
+		 * Do you have any LED where you can see your progress ?
+		 *sysLedSet(counter);
+		 */
+	}
 }
 
 int main (int argc, char *argv[])
-
 {
-    int err;
+	int err;
+	atexit(cleanup);
+	mlockall(MCL_CURRENT|MCL_FUTURE);
 
-    mlockall(MCL_CURRENT|MCL_FUTURE);
-
-    /* ... */
-
-    err = rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,0);
-
-    /* ... */
-
-    err = rt_task_create(&server_desc,
-			 "MyIrqServer",
-			 TASK_STKSZ,
-			 TASK_PRIO,
-			 TASK_MODE);
-    if (!err)
-	rt_task_start(&server_desc,&irq_server,NULL);
-
-    /* ... */
+	/* Do not forget to pass I_PROPAGATE as the last parameter
+	 * or your Linux will hang or not function properly.
+	 * You have be warned!!
+	 */
+	err = rt_intr_create(&intr_desc,"myIrq",IRQ_NR, I_PROPAGATE);
+	if (err == -ENOSYS) {
+		printf("%s: rt_intr_create returned ENOSYS\n", __FUNCTION__);
+		printf("Did your forget to set CONFIG_XENO_OPT_NATIVE_INTR\n");
+		printf("in the kernel config under:\n");
+		printf("Real-Time Subsystem..Interfaces..Native-API..\n");
+		return 2;
+	}
+	if (err) {
+		printf("%s: rt_intr_create failed with error %d\n",
+			__FUNCTION__, err);
+		return 2;
+	}
+	err = rt_task_create(&server_desc,
+				"MyIrqServer",
+				TASK_STKSZ,
+				TASK_PRIO,
+				TASK_MODE);
+	if (err) {
+		printf("%s: rt_task_create failed with error %d\n",
+			__FUNCTION__, err);
+		return 2;
+	}
+	printf("ISR test program: Started successfully the irq task\n");
+	printf("Please generate some interrupts on IRQ %d.\n",
+		IRQ_NR);
+	printf("Number of interrupts serviced will be shown in 10 seconds.\n");
+	err = rt_task_start(&server_desc,&irq_server, 0xbeef);
+	sleep(10); /* or do you prefer pause() to wait for Ctrl-C ? */
+	printf("All okay. Did see %d interrupts\n", counter);
+	return 0;
 }
 
 void cleanup (void)
-
 {
-    rt_intr_delete(&intr_desc);
-    rt_task_delete(&server_desc);
+	rt_intr_delete(&intr_desc);
+	rt_task_delete(&server_desc);
+	printf("Cleaning up. Did see %d interrupts\n", counter);
 }

--Boundary-00=_dKo4I3M1nBpeAy4
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="user_irq.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="user_irq.c"

/*
 * (c) 2008 Niklaus Giger, niklaus.giger@domain.hid
 *
 * A small example which shows how to use the native xenomai skin to
 * catch an interrupt and forward it afterwards to the Linux kernel.
 *
 * Take some care to choose the interrupt you want to use.
 * Use one, which shows up in /proc/interrupts and which has quite few
 * occurences. E.g. I did choose 18 as my /proc/interrupts looked like
 * 	     CPU0
 * 16:        194   UIC   Level     serial
 * 17:       7932   UIC   Level     MAL TX EOB
 * 18:      12895   UIC   Level     MAL RX EOB
 * After running the interrupt service routine we will forward the interrupt to
 * the linux kernel. Therefore no harm should be done by intercepting it.
 *
 */
#define IRQ_NR    18

#include <sys/mman.h>
#include <native/task.h>
#include <native/intr.h>
#include <unistd.h>
#include <stdlib.h>

#define TASK_PRIO  99 /* Highest RT priority */
#define TASK_MODE  0  /* No flags */
#define TASK_STKSZ 0  /* Stack size (use default one) */

void cleanup (void);

RT_INTR intr_desc;
RT_TASK server_desc;

static int counter;

void irq_server (void *cookie)
{
	int j;
	for (;;) {

		/* Wait for the next interrupt. */
		j = rt_intr_wait(&intr_desc,TM_INFINITE);
		if (j == -EIDRM) {
			printf("%s: interrupt descriptor deleted. Exit?\n",
				__FUNCTION__);
			return;
		}
		if (j<0) {
			printf("%s: error %d occured. We will exit\n",
				__FUNCTION__, j);
			return;
		}
		/* j is the nr of times the interrupt occured */
		counter+= j;
		/* Process interrupt.
		 * Do you have any LED where you can see your progress ?
		 *sysLedSet(counter);
		 */
	}
}

int main (int argc, char *argv[])
{
	int err;
	atexit(cleanup);
	mlockall(MCL_CURRENT|MCL_FUTURE);

	/* Do not forget to pass I_PROPAGATE as the last parameter
	 * or your Linux will hang or not function properly.
	 * You have be warned!!
	 */
	err = rt_intr_create(&intr_desc,"myIrq",IRQ_NR, I_PROPAGATE);
	if (err == -ENOSYS) {
		printf("%s: rt_intr_create returned ENOSYS\n", __FUNCTION__);
		printf("Did your forget to set CONFIG_XENO_OPT_NATIVE_INTR\n");
		printf("in the kernel config under:\n");
		printf("Real-Time Subsystem..Interfaces..Native-API..\n");
		return 2;
	}
	if (err) {
		printf("%s: rt_intr_create failed with error %d\n",
			__FUNCTION__, err);
		return 2;
	}
	err = rt_task_create(&server_desc,
				"MyIrqServer",
				TASK_STKSZ,
				TASK_PRIO,
				TASK_MODE);
	if (err) {
		printf("%s: rt_task_create failed with error %d\n",
			__FUNCTION__, err);
		return 2;
	}
	printf("ISR test program: Started successfully the irq task\n");
	printf("Please generate some interrupts on IRQ %d.\n",
		IRQ_NR);
	printf("Number of interrupts serviced will be shown in 10 seconds.\n");
	err = rt_task_start(&server_desc,&irq_server, 0xbeef);
	sleep(10); /* or do you prefer pause() to wait for Ctrl-C ? */
	printf("All okay. Did see %d interrupts\n", counter);
	return 0;
}

void cleanup (void)
{
	rt_intr_delete(&intr_desc);
	rt_task_delete(&server_desc);
	printf("Cleaning up. Did see %d interrupts\n", counter);
}

--Boundary-00=_dKo4I3M1nBpeAy4--

