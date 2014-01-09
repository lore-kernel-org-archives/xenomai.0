Message-ID: <52CE6FF8.4080108@xenomai.org>
Date: Thu, 09 Jan 2014 10:46:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKc2Hpb3myvq5SmRuRGa6pmoDDA9NnuA+doijhBARHkHt+PnOg@mail.gmail.com>	<52CD2290.8010107@xenomai.org>
 <CAKc2HpZ50=BeBvDATODZJ=yBS9bd=-SCiFO20Vr1Zjg11Z+8cg@mail.gmail.com>
In-Reply-To: <CAKc2HpZ50=BeBvDATODZJ=yBS9bd=-SCiFO20Vr1Zjg11Z+8cg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge pSOS app hangs on t_suspend + t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>
Cc: xenomai@xenomai.org

On 01/08/2014 01:23 PM, Kim De Mey wrote:
> 2014/1/8 Philippe Gerum <rpm@xenomai.org>:
>> On 01/08/2014 10:25 AM, Kim De Mey wrote:
> 
> Here are the backtraces:
> 
> main thread:
> (gdb) bt
> #0  clock_nanosleep (clock_id=<optimized out>, flags=<optimized out>,
> req=<optimized out>, rem=<optimized out>)
>      at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:51
> #1  0x00b45e10 in threadobj_sleep () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
> #2  0x00b2b618 in tm_wkafter () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
> #3  0x10000b3c in main (argc=1, argv=0x104120e0) at suspend_delete_easy.c:42
> 
> first psos task:
> (gdb) bt
> #0  0x00b6b5c8 in __old_sem_wait (sem=<optimized out>) at
> ../nptl/sysdeps/unix/sysv/linux/sem_wait.c:105
> #1  0x00b45c84 in threadobj_cancel () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
> #2  0x00b2ac44 in t_delete () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
> #3  0x10000a70 in test (a=0, b=0, c=0, d=0) at suspend_delete_easy.c:22
> #4  0x00b2a658 in task_trampoline () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
> #5  0x00b63824 in start_thread (arg=<optimized out>) at pthread_create.c:299
> #6  0x00c7df4c in __thread_start () from
> output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
> 
> second psos task:
> (gdb) bt
> #0  0x00b6cbbc in read () from
> output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libpthread.so.0
> #1  0x00b47bd8 in notifier_wait () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
> #2  0x00b460b0 in notifier_callback () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
> #3  0x00b47d30 in notifier_sighandler () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
> #4  <signal handler called>
> #5  sigcancel_handler (sig=32, si=0x1e03aa8, ctx=0x1e03b28) at init.c:136
> #6  <signal handler called>
> #7  clock_nanosleep (clock_id=<optimized out>, flags=<optimized out>,
> req=<optimized out>, rem=<optimized out>)
>      at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:51
> #8  0x00b45e10 in threadobj_sleep () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
> #9  0x00b2b618 in tm_wkafter () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
> #10 0x100009bc in idle_task (a=0, b=0, c=0, d=0) at suspend_delete_easy.c:9
> #11 0x00b2a658 in task_trampoline () from
> /repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
> #12 0x00b63824 in start_thread (arg=<optimized out>) at pthread_create.c:299
> #13 0x00c7df4c in __thread_start () from
> output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
> 
> 
> Invocation command line was
> 
>    $ ./configure --target=mips64-buildroot-linux-gnu
> --host=mips64-buildroot-linux-gnu --build=x86_64-unknown-linux-gnu
> --prefix=/usr --exec-prefix=/usr --sysconfdir=/etc --program-prefix=
> --disable-gtk-doc --disable-doc --disable-docs --disable-documentation
> --with-xmlto=no --with-fop=no --enable-ipv6 --enable-static
> --enable-shared --with-core=mercury
> --includedir=/usr/include/xenomai-forge --disable-doc-install
> --enable-lores-clock
> 
> 
> Is this what you were asking?

Yes, thanks.

> 
> 
> By the way, I forgot the mention the following test that I did:
> 
> When the application is blocked I've done an "echo 1 > /proc/pid/fd/xx",
> where xx is the file descriptor that is being read from in the notifier_wait().
> This kinda emulates a t_resume.
> 
> After doing this the t_delete gets finalized and the application unblocks.
> 

This should fix the race, until the notifier is reworked.

diff --git a/include/copperplate/threadobj.h b/include/copperplate/threadobj.h
index 184c711..218c274 100644
--- a/include/copperplate/threadobj.h
+++ b/include/copperplate/threadobj.h
@@ -124,6 +124,7 @@ void threadobj_save_timeout(struct threadobj_corespec *corespec,
 #define __THREAD_S_ACTIVE	(1 << 5)	/* Running user code. */
 #define __THREAD_S_SUSPENDED	(1 << 6)	/* Suspended via threadobj_suspend(). */
 #define __THREAD_S_SAFE		(1 << 7)	/* TCB release deferred. */
+#define __THREAD_S_ZOMBIE	(1 << 8)	/* Deletion process ongoing. */
 #define __THREAD_S_DEBUG	(1 << 31)	/* Debug mode enabled. */
 /*
  * threadobj->run_state, locklessly updated by "current", merged
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index a31479c..c54cdf8 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -420,11 +420,13 @@ static void notifier_callback(const struct notifier *nf)
 	 * threadobj_suspend().
 	 */
 	threadobj_lock(current);
-	current->status |= __THREAD_S_SUSPENDED;
-	threadobj_unlock(current);
-	notifier_wait(nf); /* Wait for threadobj_resume(). */
-	threadobj_lock(current);
-	current->status &= ~__THREAD_S_SUSPENDED;
+	if ((current->status & __THREAD_S_ZOMBIE) == 0) {
+		current->status |= __THREAD_S_SUSPENDED;
+		threadobj_unlock(current);
+		notifier_wait(nf); /* Wait for threadobj_resume(). */
+		threadobj_lock(current);
+		current->status &= ~__THREAD_S_SUSPENDED;
+	}
 	threadobj_unlock(current);
 }
 
@@ -488,7 +490,7 @@ static inline void threadobj_run_corespec(struct threadobj *thobj)
 {
 }
 
-static inline void threadobj_cancel_corespec(struct threadobj *thobj)
+static inline void threadobj_cancel_corespec(struct threadobj *thobj) /* thobj->lock held */
 {
 }
 
@@ -872,9 +874,9 @@ void threadobj_init(struct threadobj *thobj,
 
 static void destroy_thread(struct threadobj *thobj)
 {
+	threadobj_cleanup_corespec(thobj);
 	__RT(pthread_cond_destroy(&thobj->barrier));
 	__RT(pthread_mutex_destroy(&thobj->lock));
-	threadobj_cleanup_corespec(thobj);
 }
 
 void threadobj_destroy(struct threadobj *thobj) /* thobj->lock free */
@@ -1089,8 +1091,6 @@ static void cancel_sync(struct threadobj *thobj) /* thobj->lock held */
 	int oldstate, ret = 0;
 	sem_t *sem;
 
-	__threadobj_check_locked(thobj);
-
 	/*
 	 * We have to allocate the cancel sync sema4 in the main heap
 	 * dynamically, so that it always live in valid memory when we
@@ -1106,6 +1106,7 @@ static void cancel_sync(struct threadobj *thobj) /* thobj->lock held */
 		__STD(sem_init(sem, sem_scope_attribute, 0));
 
 	thobj->cancel_sem = sem;
+	thobj->status |= __THREAD_S_ZOMBIE;
 
 	/*
 	 * If the thread to delete is warming up, wait until it

-- 
Philippe.

