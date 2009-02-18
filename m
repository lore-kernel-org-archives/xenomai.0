Message-ID: <499BBE15.3030605@domain.hid>
Date: Wed, 18 Feb 2009 08:51:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20090217170418.1425.56126.stgit@domain.hid>	<20090217170419.1425.15313.stgit@domain.hid>	<499AF09F.8040402@domain.hid>
	<499AF3C9.2040502@domain.hid>	<499AF5DC.6010602@domain.hid>
	<499AF82A.20406@domain.hid>	<499AF8E7.5000304@domain.hid>
	<499AFA8D.3080302@domain.hid>	<499AFF38.5030509@domain.hid>
	<499AFFC6.1030207@domain.hid>	<499B0028.2090402@domain.hid>
	<499B04CA.3020509@domain.hid> <499B4CC0.9000803@domain.hid>
In-Reply-To: <499B4CC0.9000803@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD8F4A777C3CBEA07DE16E3FA"
Sender: jan.kiszka@domain.hid
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8F4A777C3CBEA07DE16E3FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> I played with it, but raising a signal from xnshadow_map is no good
> idea: If we inject the signal before the migration, xnshadow_map fails
> due to the pending signal, we exit to user space, run the signal,
> restart the call, raise the signal, and so on. If we raise after
> migration, we immediately force the new thread into secondary mode
> again, definitely causing problems when the mode switch warning is
> active, but also risking other regressions for xnshadow_map users that
> expect to find themselves in primary mode on return.
>=20

Meditating over it again, I realized that there is actually no need to
raise the renice signal if we migrate in xnshadow_map. This case will be
handled automatically on next relax. That pattern seems to work and
allows indeed a few cleanups (just uitron still needs
pthread_setschedparam). This is just a first draft, needs more testing:

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 8c679ad..f0f6801 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1250,6 +1250,12 @@ int xnshadow_map(xnthread_t *thread, xncompletion_=
t __user *u_completion,
 	thread->u_mode =3D u_mode;
=20
 	if (u_completion) {
+		/*
+		 * Send the renice signal if we are not migrating so that user
+		 * space will immediately align Linux sched policy and prio.
+		 */
+		xnshadow_renice(thread);
+
  		/*
 		 * We still have the XNDORMANT bit set, so we can't
  		 * link to the RPI queue which only links _runnable_
diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 99c2a16..16303b3 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -167,9 +167,9 @@ static int __pthread_create(struct pt_regs *regs)
 	   calling context. */
=20
 	pthread_attr_init(&attr);
-	attr.policy =3D p->policy;
+	attr.policy =3D __xn_reg_arg2(regs);
 	attr.detachstate =3D PTHREAD_CREATE_DETACHED;
-	attr.schedparam_ex.sched_priority =3D p->rt_priority;
+	attr.schedparam_ex.sched_priority =3D __xn_reg_arg3(regs);
 	attr.fp =3D 1;
 	attr.name =3D p->comm;
=20
@@ -179,7 +179,7 @@ static int __pthread_create(struct pt_regs *regs)
 		return -err;	/* Conventionally, our error codes are negative. */
=20
 	err =3D xnshadow_map(&k_tid->threadbase, NULL,
-			   (unsigned long __user *)__xn_reg_arg2(regs));
+			   (unsigned long __user *)__xn_reg_arg4(regs));
=20
 	if (!err && !__pthread_hash(&hkey, k_tid))
 		err =3D -ENOMEM;
diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index 7bcc49c..190dc4b 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -55,21 +55,10 @@ static void *rt_task_trampoline(void *cookie)
 {
 	struct rt_task_iargs *iargs =3D (struct rt_task_iargs *)cookie;
 	void (*entry) (void *cookie);
-	struct sched_param param;
 	struct rt_arg_bulk bulk;
 	RT_TASK *task;
 	long err;
=20
-	if (iargs->prio > 0) {
-		/*
-		 * Re-apply sched params here as some libpthread
-		 * implementations fail doing this via pthread_create.
-		 */
-		memset(&param, 0, sizeof(param));
-		param.sched_priority =3D iargs->prio;
-		__real_pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
-	}
-
 	/* rt_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
=20
@@ -178,7 +167,6 @@ int rt_task_start(RT_TASK *task, void (*entry) (void =
*cookie), void *cookie)
=20
 int rt_task_shadow(RT_TASK *task, const char *name, int prio, int mode)
 {
-	struct sched_param param;
 	struct rt_arg_bulk bulk;
 	RT_TASK task_desc;
 	int err;
@@ -190,13 +178,6 @@ int rt_task_shadow(RT_TASK *task, const char *name, =
int prio, int mode)
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 	sigshadow_install_once();
=20
-	if (prio > 0) {
-		/* Make sure the POSIX library caches the right priority. */
-		memset(&param, 0, sizeof(param));
-		param.sched_priority =3D prio;
-		__real_pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
-	}
-
 	bulk.a1 =3D (u_long)task;
 	bulk.a2 =3D (u_long)name;
 	bulk.a3 =3D (u_long)prio;
diff --git a/src/skins/native/wrappers.c b/src/skins/native/wrappers.c
index 8421456..4463f6f 100644
--- a/src/skins/native/wrappers.c
+++ b/src/skins/native/wrappers.c
@@ -33,13 +33,6 @@
  */
=20
 __attribute__ ((weak))
-int __real_pthread_setschedparam(pthread_t thread,
-				 int policy, const struct sched_param *param)
-{
-	return pthread_setschedparam(thread, policy, param);
-}
-
-__attribute__ ((weak))
 int __real_pthread_create(pthread_t *tid,
 			  const pthread_attr_t * attr,
 			  void *(*start) (void *), void *arg)
diff --git a/src/skins/native/wrappers.h b/src/skins/native/wrappers.h
index f2125a4..99568a9 100644
--- a/src/skins/native/wrappers.h
+++ b/src/skins/native/wrappers.h
@@ -8,9 +8,6 @@ int __real_pthread_create(pthread_t *tid,
 			  const pthread_attr_t * attr,
 			  void *(*start) (void *), void *arg);
=20
-int __real_pthread_setschedparam(pthread_t thread,
-				 int policy, const struct sched_param *param);
-
 int __real_pthread_kill(pthread_t tid, int sig);
=20
 int __real_open(const char *path, int oflag, ...);
diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
index f32c7e1..e8c50bd 100644
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -203,8 +203,8 @@ static void *__pthread_trampoline(void *arg)
=20
 	/* Do _not_ inline the call to pthread_self() in the syscall
 	   macro: this trashes the syscall regs on some archs. */
-	err =3D XENOMAI_SKINCALL2(__pse51_muxid, __pse51_thread_create, tid,
-				mode_buf);
+	err =3D XENOMAI_SKINCALL4(__pse51_muxid, __pse51_thread_create, tid,
+				iargs->policy, iargs->prio, mode_buf);
 	iargs->ret =3D -err;
=20
 	/* We must save anything we'll need to use from *iargs on our own
@@ -221,11 +221,6 @@ static void *__pthread_trampoline(void *arg)
 	__real_sem_post(&iargs->sync);
=20
 	if (!err) {
-		/* Broken pthread libs ignore some of the thread attribute specs
-		   passed to pthread_create(3), so we force the scheduling policy
-		   once again here. */
-		__real_pthread_setschedparam(tid, policy, &param);
-
 		/* If the thread running pthread_create runs with the same
 		   priority as us, we should leave it running, as if there never
 		   was a synchronization with a semaphore. */
diff --git a/src/skins/psos+/task.c b/src/skins/psos+/task.c
index 265eab2..1bf3565 100644
--- a/src/skins/psos+/task.c
+++ b/src/skins/psos+/task.c
@@ -63,13 +63,8 @@ static void *psos_task_trampoline(void *cookie)
 	void (*entry)(u_long, u_long, u_long, u_long);
 	u_long dummy_args[4] =3D { 0, 0, 0, 0 }, *targs;
 	struct psos_arg_bulk bulk;
-	struct sched_param param;
-	int policy;
 	long err;
=20
-	policy =3D psos_task_set_posix_priority(iargs->prio, &param);
-	pthread_setschedparam(pthread_self(), policy, &param);
-
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 	sigshadow_install_once();
=20
diff --git a/src/skins/vrtx/task.c b/src/skins/vrtx/task.c
index 1b16f68..184c948 100644
--- a/src/skins/vrtx/task.c
+++ b/src/skins/vrtx/task.c
@@ -73,8 +73,6 @@ static void *vrtx_task_trampoline(void *cookie)
 	struct vrtx_task_iargs *iargs =3D
 	    (struct vrtx_task_iargs *)cookie, _iargs;
 	struct vrtx_arg_bulk bulk;
-	struct sched_param param;
-	int policy;
 	long err;
 #ifndef HAVE___THREAD
 	TCB *tcb;
@@ -83,13 +81,6 @@ static void *vrtx_task_trampoline(void *cookie)
 	/* Backup the arg struct, it might vanish after completion. */
 	memcpy(&_iargs, iargs, sizeof(_iargs));
=20
-	/*
-	 * Apply sched params here as some libpthread implementations
-	 * fail doing this properly via pthread_create.
-	 */
-	policy =3D vrtx_task_set_posix_priority(iargs->prio, &param);
-	pthread_setschedparam(pthread_self(), policy, &param);
-
 	/* vrtx_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
=20
diff --git a/src/skins/vxworks/taskLib.c b/src/skins/vxworks/taskLib.c
index 1ba193e..3249bfc 100644
--- a/src/skins/vxworks/taskLib.c
+++ b/src/skins/vxworks/taskLib.c
@@ -86,21 +86,12 @@ static void *wind_task_trampoline(void *cookie)
 	struct wind_task_iargs *iargs =3D
 	    (struct wind_task_iargs *)cookie, _iargs;
 	struct wind_arg_bulk bulk;
-	struct sched_param param;
 	WIND_TCB *pTcb;
-	int policy;
 	long err;
=20
 	/* Backup the arg struct, it might vanish after completion. */
 	memcpy(&_iargs, iargs, sizeof(_iargs));
=20
-	/*
-	 * Apply sched params here as some libpthread implementations
-	 * fail doing this properly via pthread_create.
-	 */
-	policy =3D wind_task_set_posix_priority(iargs->prio, &param);
-	__real_pthread_setschedparam(pthread_self(), policy, &param);
-
 	/* wind_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 	sigshadow_install_once();
diff --git a/src/skins/vxworks/wrappers.c b/src/skins/vxworks/wrappers.c
index 394ea51..ab50d77 100644
--- a/src/skins/vxworks/wrappers.c
+++ b/src/skins/vxworks/wrappers.c
@@ -33,13 +33,6 @@
  */
=20
 __attribute__ ((weak))
-int __real_pthread_setschedparam(pthread_t thread,
-				 int policy, const struct sched_param *param)
-{
-	return pthread_setschedparam(thread, policy, param);
-}
-
-__attribute__ ((weak))
 int __real_pthread_create(pthread_t *tid,
 			  const pthread_attr_t * attr,
 			  void *(*start) (void *), void *arg)
diff --git a/src/skins/vxworks/wrappers.h b/src/skins/vxworks/wrappers.h
index 919309a..e20da86 100644
--- a/src/skins/vxworks/wrappers.h
+++ b/src/skins/vxworks/wrappers.h
@@ -8,9 +8,6 @@ int __real_pthread_create(pthread_t *tid,
 			  const pthread_attr_t * attr,
 			  void *(*start) (void *), void *arg);
=20
-int __real_pthread_setschedparam(pthread_t thread,
-				 int policy, const struct sched_param *param);
-
 int __real_pthread_kill(pthread_t tid, int sig);
=20
 int __real_open(const char *path, int oflag, ...);


--------------enigD8F4A777C3CBEA07DE16E3FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmbvhgACgkQniDOoMHTA+kwLQCff4dQaGaNyP8PhC43ZcJaM49o
JdsAmgJn9rLXdnCgd+VDxldvtwxWGEuq
=VPMU
-----END PGP SIGNATURE-----

--------------enigD8F4A777C3CBEA07DE16E3FA--

