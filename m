From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200905041024.27896@domain.hid>
References: <200904301508.29432@domain.hid> <200904301509.13094@domain.hid>
	<1241103352.26544.177.camel@domain.hid> <49F9C374.1040209@domain.hid>
	<200905041024.27896@domain.hid>
Content-Type: text/plain
Date: Mon, 04 May 2009 10:41:41 +0200
Message-Id: <1241426501.26544.277.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-05-04 at 10:24 +0200, Petr Cervenka wrote:
> Gilles Chanteperdrix wrote:
> >Philippe Gerum wrote:
> >> On Thu, 2009-04-30 at 07:09 -0700, Thomas Lockhart wrote:
> >>>> Hello, I have a problem with rtdm_event_timedwait() function. It
> >>>> sometimes ends prematurely with -EINTR error code. It depends on
> >>>> special circumstances (CPU load, resizing console window in X, ...).
> 
> >> 
> >> Just to clarify a few points more:
> >> 
> >> Xenomai always tells the kernel that blocking (Xenomai) syscalls
> >> _should_ be restarted when interrupted by a Linux signal (i.e.
> >> -ERESTARTSYS is passed down to the kernel by the Xenomai core in that
> >> case), and the kernel will actually restart that (Xenomai) syscall if no
> >> handler was installed for such signal, or if SA_RESTART is set in the
> >> sigaction() flags for the signal.
> >> 
> 
> >> 
> >> Additionally, syscalls may be forcibly unblocked via rt_task_unblock(),
> >> which will cause -EINTR to be returned to the caller as well. This is
> >> totally unrelated to Linux signal management though.
>  the case, it means that we have quite a few syscalls to fix...
> >
> 
> It seems that rt_task_unblock is not called, because the rt_event_wait is restarted.
> 
> >Also, from your mail, it is not clear to me, what is Petr problem,
> >rtdm_event_timedwait ? or rt_event_wait.
> >
> 
> I have ported a device driver fragment to rtdm. I have a problem with rtdm_event_timedwait() function that sometimes returns -EINTR.
> In that driver (in IOCTL handling), when a signal is received the -ERESTARTSYS is returned. So the syscall is restarted and takes more time.
> Similar situation is in reading from device (using DMA). But when the signal is received there (instead of waiting for interrupt), error happens.
> So I wanted to find the source of the -EINTR return values. I created a simple example with alternative function (rt_event_wait()) to examine it's behavior.
> 
> I can perhaps fix it by calling rtdm_event_timedwait() again when a signal is received. But do you have any advice how to prevent the signals to happen or what is causing them?
> 

Assuming you are using the native API (the POSIX interface would have to
be adapted the same way), does the following patch help?

diff --git a/include/asm-generic/bits/bind.h b/include/asm-generic/bits/bind.h
index 50db3d3..7a05e81 100644
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -76,7 +76,7 @@ xeno_bind_skin(unsigned skin_magic, const char *skin, const char *module)
 
 	sa.sa_handler = &xeno_handle_mlock_alert;
 	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = 0;
+	sa.sa_flags = SA_RESTART;
 	sigaction(SIGXCPU, &sa, NULL);
 
 	return muxid;
diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index 869a264..368c883 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -58,6 +58,7 @@ static void *rt_task_trampoline(void *cookie)
 	struct rt_task_iargs *iargs = (struct rt_task_iargs *)cookie;
 	void (*entry) (void *cookie);
 	struct sched_param param;
+	struct sigaction sa, osa;
 	struct rt_arg_bulk bulk;
 	long err;
 
@@ -74,7 +75,11 @@ static void *rt_task_trampoline(void *cookie)
 	/* rt_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
-	old_sigharden_handler = signal(SIGHARDEN, &rt_task_sigharden);
+	sa.sa_handler = &rt_task_sigharden;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGHARDEN, &sa, &osa);
+	old_sigharden_handler = osa.sa_handler;
 
 	bulk.a1 = (u_long)iargs->task;
 	bulk.a2 = (u_long)iargs->name;
@@ -168,11 +173,16 @@ int rt_task_shadow(RT_TASK *task, const char *name, int prio, int mode)
 {
 	struct sched_param param;
 	struct rt_arg_bulk bulk;
+	struct sigaction sa, osa;
 
 	/* rt_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
-	old_sigharden_handler = signal(SIGHARDEN, &rt_task_sigharden);
+	sa.sa_handler = &rt_task_sigharden;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGHARDEN, &sa, &osa);
+	old_sigharden_handler = osa.sa_handler;
 
 	if (prio > 0) {
 		/* Make sure the POSIX library caches the right priority. */

> Petr
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



