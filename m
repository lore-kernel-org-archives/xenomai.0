Message-ID: <47CE8483.8030600@domain.hid>
Date: Wed, 05 Mar 2008 12:31:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47CE7FD5.7080602@domain.hid>
In-Reply-To: <47CE7FD5.7080602@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_task_delete of an active task kills main
	program
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Anders Blomdell wrote:
> With the following program:
> 
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/timer.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> 
> 
> 
> static void child(void *arg)
> {
>   int n = (int)arg;
> 
>   printf("start %d, ", n); fflush(stdout);
>   rt_task_sleep(100000000L);
>   printf("exit %d, ", n); fflush(stdout);
> }
> 
> int main(int argc, char *argv[])
> {
>   int i;
>   RT_TASK task_main;
>   RT_TASK task;
> 
>   mlockall(MCL_CURRENT|MCL_FUTURE);
>   rt_task_shadow(&task_main, NULL, 1, T_FPU);
> 
>   for  (i = 20 ; i > 0 ; i--) {
>     if (rt_task_create(&task, NULL, 0, 1, 0)) {
>       fprintf(stderr, "Failed to create  task\n");
>       exit(1);
>     }
>     if (rt_task_start(&task, &child, (void*)i)) {
>       fprintf(stderr, "Failed to start task\n");
>       exit(1);
>     }
>     rt_task_sleep(1000000 + 10000000L * i);
>     printf("delete %d\n", i);
>     rt_task_delete(&task);
>   }
>   exit(0);
> }
> 
> I get this output:
> 
> start 20, exit 20, delete 20
> start 19, exit 19, delete 19
> start 18, exit 18, delete 18
> start 17, exit 17, delete 17
> start 16, exit 16, delete 16
> start 15, exit 15, delete 15
> start 14, exit 14, delete 14
> start 13, exit 13, delete 13
> start 12, exit 12, delete 12
> start 11, exit 11, delete 11
> start 10, exit 10, delete 10
> start 9, delete 9
> Killed
> 
> i.e. rt_task_delete of a [still] running task kills the main program. Is this
> the expected behaviour?

Yes and no. POSIX behaviour kills us sometimes.

 Versions are still:
>

Does this patch fix the issue?

--- ksrc/nucleus/pod.c	(revision 3525)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -1140,9 +1140,11 @@
 	 * 2) Make sure shadow threads are removed from the system on
 	 * behalf of their own context, by sending them a lethal
 	 * signal when it is not the case instead of wiping out their
-	 * TCB. In such a case, the deletion is asynchronous, and
-	 * killed thread will later enter xnpod_delete_thread() from
-	 * the exit notification handler (I-pipe).
+	 * TCB. We only do that whenever the caller is a kernel-based
+	 * Xenomai context. In such a case, the deletion is
+	 * asynchronous, and killed thread will later enter
+	 * xnpod_delete_thread() from the exit notification handler
+	 * (I-pipe).
 	 *
 	 * Sidenote: xnpod_delete_thread() might be called for
 	 * cleaning up a just created shadow task which has not been
@@ -1166,7 +1168,14 @@
 	if (xnthread_user_task(thread) != NULL &&
 	    !xnthread_test_state(thread, XNDORMANT) &&
 	    !xnpod_current_p(thread)) {
-		xnshadow_send_sig(thread, SIGKILL, 1);
+		if (!xnpod_userspace_p())
+			xnshadow_send_sig(thread, SIGKILL, 1);
+		/*
+		 * Otherwise, assume the interface library has issued
+		 * pthread_cancel on the target thread, which should
+		 * cause the current service to be called for
+		 * self-deletion of that thread.
+		 */
 		goto unlock_and_exit;
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */

-- 
Philippe.

