Message-ID: <499AF3C9.2040502@domain.hid>
Date: Tue, 17 Feb 2009 18:28:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20090217170418.1425.56126.stgit@domain.hid>
	<20090217170419.1425.15313.stgit@domain.hid>
	<499AF09F.8040402@domain.hid>
In-Reply-To: <499AF09F.8040402@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2 1/4] POSIX: Fix SCHED_RR thread
	creation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> @@ -192,6 +192,9 @@ static void *__pthread_trampoline(void *arg)
>>  
>>  	param.sched_priority = iargs->prio;
>>  	policy = iargs->policy;
>> +	if (policy == SCHED_RR)
>> +		/* Restrict round-robin scheduling to the Xenomai domain. */
>> +		policy = SCHED_FIFO;
> 
> Should not there be the same thing in __wrap_pthread_setschedparam ?

Yes, and setschedparam_ex, here we go:

--------->

SCHED_RR threads created via pthread_create do not receive the
round-robin property at kernel side. Fix this by pushing the policy as
an additional argument to __pse51_thread_create down to the kernel.
Moreover, enforce SCHED_FIFO for the Linux part of those threads.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 0 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 99c2a16..3480142 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -167,7 +167,7 @@ static int __pthread_create(struct pt_regs *regs)
 	   calling context. */
 
 	pthread_attr_init(&attr);
-	attr.policy = p->policy;
+	attr.policy = __xn_reg_arg2(regs);
 	attr.detachstate = PTHREAD_CREATE_DETACHED;
 	attr.schedparam_ex.sched_priority = p->rt_priority;
 	attr.fp = 1;
@@ -179,7 +179,7 @@ static int __pthread_create(struct pt_regs *regs)
 		return -err;	/* Conventionally, our error codes are negative. */
 
 	err = xnshadow_map(&k_tid->threadbase, NULL,
-			   (unsigned long __user *)__xn_reg_arg2(regs));
+			   (unsigned long __user *)__xn_reg_arg3(regs));
 
 	if (!err && !__pthread_hash(&hkey, k_tid))
 		err = -ENOMEM;
diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
index f32c7e1..1593eea 100644
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -61,8 +61,13 @@ int __wrap_pthread_setschedparam(pthread_t thread,
 				 __pse51_thread_setschedparam,
 				 thread, policy, param, mode_buf, &promoted);
 
-	if (err == EPERM)
+	if (err == EPERM) {
+		if (policy == SCHED_RR)
+			/* Restrict round-robin scheduling to the Xenomai
+			   domain. */
+			policy = SCHED_FIFO;
 		return __real_pthread_setschedparam(thread, policy, param);
+	}
 
 	if (!err && promoted) {
 		sigshadow_install_once();
@@ -104,6 +109,10 @@ int pthread_setschedparam_ex(pthread_t thread,
 
 	if (err == EPERM) {
 		short_param.sched_priority = param->sched_priority;
+		if (policy == SCHED_RR)
+			/* Restrict round-robin scheduling to the Xenomai
+			   domain. */
+			policy = SCHED_FIFO;
 		return __real_pthread_setschedparam(thread, policy, &short_param);
 	}
 
@@ -192,6 +201,9 @@ static void *__pthread_trampoline(void *arg)
 
 	param.sched_priority = iargs->prio;
 	policy = iargs->policy;
+	if (policy == SCHED_RR)
+		/* Restrict round-robin scheduling to the Xenomai domain. */
+		policy = SCHED_FIFO;
 	parent_prio = iargs->parent_prio;
 	mode_buf = xeno_init_current_mode();
 
@@ -203,8 +215,8 @@ static void *__pthread_trampoline(void *arg)
 
 	/* Do _not_ inline the call to pthread_self() in the syscall
 	   macro: this trashes the syscall regs on some archs. */
-	err = XENOMAI_SKINCALL2(__pse51_muxid, __pse51_thread_create, tid,
-				mode_buf);
+	err = XENOMAI_SKINCALL3(__pse51_muxid, __pse51_thread_create, tid,
+				iargs->policy, mode_buf);
 	iargs->ret = -err;
 
 	/* We must save anything we'll need to use from *iargs on our own
@@ -221,9 +233,7 @@ static void *__pthread_trampoline(void *arg)
 	__real_sem_post(&iargs->sync);
 
 	if (!err) {
-		/* Broken pthread libs ignore some of the thread attribute specs
-		   passed to pthread_create(3), so we force the scheduling policy
-		   once again here. */
+		/* Adjust to final Linux policy and priority. */
 		__real_pthread_setschedparam(tid, policy, &param);
 
 		/* If the thread running pthread_create runs with the same

