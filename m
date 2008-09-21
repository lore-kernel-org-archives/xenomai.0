Message-ID: <48D68D6D.9070909@domain.hid>
Date: Sun, 21 Sep 2008 20:07:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CE7BD7.6060504@domain.hid> <48D620DB.2070101@domain.hid>
	<48D688EE.7010404@domain.hid>
In-Reply-To: <48D688EE.7010404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig94B70FA7EC204536D9B7EBC4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH] Factor out xnsynch_acquire/release
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94B70FA7EC204536D9B7EBC4
Content-Type: multipart/mixed;
 boundary="------------000707060601060904080901"

This is a multi-part message in MIME format.
--------------000707060601060904080901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Slowly moving on toward generic fast mutex support for Xenomai, this
>>> patch is a proposal to address the increasing divergence of
>>> owner-tracking vs. owner-less xnsynch objects.
>>>
>>> The services dealing with the former will likely include a new, lockl=
ess
>>> prologues for the mutex fastpath. At the the same time, this addition=
al
>>> code should not disturb too much in those cases where we do not track=

>>> ownership (condition variables, events, semaphores etc.). Moreover, I=

>>> noticed that some of the existing code assumes XNSYNCH_NOPIP means no=

>>> ownership, which is surely not true. The already visible effect is th=
at
>>> lock stealing is needlessly restricted to XNSYNCH_PIP.
>>>
>>> Going through the API, I dug out three diverging services and replace=
d
>>> them with two new ones:
>>>
>>> Owner-less xnsynch objects:
>>> - xnsynch_sleep_on
>>> - xnsynch_wakeup_one_sleeper
>>> - xnsynch_wakeup_this_sleeper
>>>
>>> Owner-tracking xnsynch objects:
>>> - xnsynch_acquire
>>> - xnsynch_release
>>>
>>> The latter type of objects are marked with the new flag XNSYNCH_OWNER=
,
>>> used only for debugging and code documentation purposes in the curren=
t
>>> implementation.
>> Any comments on this? I plan to resume the work on fast xnsynch once
>> this building block is clarified (or replaced by an alternative).
>=20
> I have to admit that I have to dig into my e-mails to find back all the=

> patches to which I have not answered, and this is hard. Is it easy for
> you to repost all of them in a unique thread ?

Find them here [1]. The second one is rebased in by local tree, likely
only a trivial refresh. However, I attached the base (1..4) for reference=
=2E

That said, the concrete implementation itself is not that important for
me now. More interesting are comments on the general direction.

Jan

[1]http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/5412/focus=
=3D5405

--------------000707060601060904080901
Content-Type: text/x-patch;
 name="always-put-xnthread-base-into-registry.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="always-put-xnthread-base-into-registry.patch"

---
 ksrc/skins/native/syscall.c  |   56 +++++++++++++++++++++++++-----------=
-------
 ksrc/skins/native/task.c     |    2 -
 ksrc/skins/psos+/syscall.c   |   14 +++++-----
 ksrc/skins/psos+/task.c      |    7 +++--
 ksrc/skins/vxworks/syscall.c |   28 +++++++++++----------
 ksrc/skins/vxworks/taskLib.c |    4 +--
 6 files changed, 63 insertions(+), 48 deletions(-)

Index: b/ksrc/skins/native/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -52,7 +52,8 @@ int __native_muxid;
 static int __rt_bind_helper(struct task_struct *p,
 			    struct pt_regs *regs,
 			    xnhandle_t *handlep,
-			    unsigned magic, void **objaddrp)
+			    unsigned magic, void **objaddrp,
+			    unsigned long objoffs)
 {
 	char name[XNOBJECT_NAME_LEN];
 	RTIME timeout;
@@ -82,7 +83,7 @@ static int __rt_bind_helper(struct task_
=20
 	/* Also validate the type of the bound object. */
=20
-	if (xeno_test_magic(objaddr, magic)) {
+	if (xeno_test_magic(objaddr + objoffs, magic)) {
 		if (objaddrp)
 			*objaddrp =3D objaddr;
 	} else
@@ -223,7 +224,9 @@ static int __rt_task_bind(struct pt_regs
 	RT_TASK_PLACEHOLDER ph;
 	int err;
=20
-	err =3D __rt_bind_helper(p, regs, &ph.opaque, XENO_TASK_MAGIC, NULL);
+	err =3D
+	    __rt_bind_helper(p, regs, &ph.opaque, XENO_TASK_MAGIC, NULL,
+			     -offsetof(RT_TASK, thread_base));
=20
 	if (err)
 		return err;
@@ -253,7 +256,7 @@ static int __rt_task_start(struct pt_reg
 				     sizeof(ph)))
 		return -EFAULT;
=20
-	task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+	task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
=20
 	if (!task)
 		return -ESRCH;
@@ -279,7 +282,7 @@ static int __rt_task_suspend(struct pt_r
 					     sizeof(ph)))
 			return -EFAULT;
=20
-		task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task =3D __rt_task_current(p);
=20
@@ -302,7 +305,7 @@ static int __rt_task_resume(struct pt_re
 				     sizeof(ph)))
 		return -EFAULT;
=20
-	task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+	task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
=20
 	if (!task)
 		return -ESRCH;
@@ -326,7 +329,7 @@ static int __rt_task_delete(struct pt_re
 					     sizeof(ph)))
 			return -EFAULT;
=20
-		task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task =3D __rt_task_current(p);
=20
@@ -364,7 +367,7 @@ static int __rt_task_set_periodic(struct
 					     sizeof(ph)))
 			return -EFAULT;
=20
-		task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task =3D __rt_task_current(p);
=20
@@ -418,7 +421,7 @@ static int __rt_task_set_priority(struct
 					     sizeof(ph)))
 			return -EFAULT;
=20
-		task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task =3D __rt_task_current(p);
=20
@@ -473,7 +476,7 @@ static int __rt_task_unblock(struct pt_r
 				     sizeof(ph)))
 		return -EFAULT;
=20
-	task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+	task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
=20
 	if (!task)
 		return -ESRCH;
@@ -500,7 +503,7 @@ static int __rt_task_inquire(struct pt_r
 					     sizeof(ph)))
 			return -EFAULT;
=20
-		task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task =3D __rt_task_current(p);
=20
@@ -541,7 +544,7 @@ static int __rt_task_notify(struct pt_re
 					     sizeof(ph)))
 			return -EFAULT;
=20
-		task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task =3D __rt_task_current(p);
=20
@@ -627,7 +630,7 @@ static int __rt_task_slice(struct pt_reg
 					     sizeof(ph)))
 			return -EFAULT;
=20
-		task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task =3D __rt_task_current(current);
=20
@@ -667,7 +670,7 @@ static int __rt_task_send(struct pt_regs
 					     sizeof(ph)))
 			return -EFAULT;
=20
-		task =3D (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task =3D thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task =3D __rt_task_current(current);
=20
@@ -1104,7 +1107,9 @@ static int __rt_sem_bind(struct pt_regs
 	RT_SEM_PLACEHOLDER ph;
 	int err;
=20
-	err =3D __rt_bind_helper(current, regs, &ph.opaque, XENO_SEM_MAGIC, NUL=
L);
+	err =3D
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_SEM_MAGIC,
+			     NULL, 0);
=20
 	if (err)
 		return err;
@@ -1324,7 +1329,8 @@ static int __rt_event_bind(struct pt_reg
 	int err;
=20
 	err =3D
-	    __rt_bind_helper(current, regs, &ph.opaque, XENO_EVENT_MAGIC, NULL)=
;
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_EVENT_MAGIC,
+			     NULL, 0);
=20
 	if (err)
 		return err;
@@ -1567,7 +1573,8 @@ static int __rt_mutex_bind(struct pt_reg
 	int err;
=20
 	err =3D
-	    __rt_bind_helper(current, regs, &ph.opaque, XENO_MUTEX_MAGIC, NULL)=
;
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_MUTEX_MAGIC,
+			     NULL, 0);
=20
 	if (err)
 		return err;
@@ -1758,7 +1765,8 @@ static int __rt_cond_bind(struct pt_regs
 	int err;
=20
 	err =3D
-	    __rt_bind_helper(current, regs, &ph.opaque, XENO_COND_MAGIC, NULL);=

+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_COND_MAGIC,
+			     NULL, 0);
=20
 	if (err)
 		return err;
@@ -2008,7 +2016,7 @@ static int __rt_queue_bind(struct pt_reg
=20
 	err =3D
 	    __rt_bind_helper(p, regs, &ph.opaque, XENO_QUEUE_MAGIC,
-			     (void **)&q);
+			     (void **)&q, 0);
=20
 	if (err)
 		goto unlock_and_exit;
@@ -2507,7 +2515,7 @@ static int __rt_heap_bind(struct pt_regs
=20
 	err =3D
 	    __rt_bind_helper(p, regs, &ph.opaque, XENO_HEAP_MAGIC,
-			     (void **)&heap);
+			     (void **)&heap, 0);
=20
 	if (err)
 		goto unlock_and_exit;
@@ -3018,7 +3026,7 @@ static int __rt_intr_bind(struct pt_regs
 	RT_INTR_PLACEHOLDER ph;
 	int err;
=20
-	err =3D __rt_bind_helper(p, regs, &ph.opaque, XENO_INTR_MAGIC, NULL);
+	err =3D __rt_bind_helper(p, regs, &ph.opaque, XENO_INTR_MAGIC, NULL, 0)=
;
=20
 	if (err)
 		return err;
@@ -3275,7 +3283,7 @@ static int __rt_pipe_bind(struct pt_regs
 	RT_PIPE_PLACEHOLDER ph;
 	int err;
=20
-	err =3D __rt_bind_helper(p, regs, &ph.opaque, XENO_PIPE_MAGIC, NULL);
+	err =3D __rt_bind_helper(p, regs, &ph.opaque, XENO_PIPE_MAGIC, NULL, 0)=
;
=20
 	if (err)
 		return err;
@@ -3551,7 +3559,9 @@ static int __rt_buffer_bind(struct pt_re
 	RT_BUFFER_PLACEHOLDER ph;
 	int ret;
=20
-	ret =3D __rt_bind_helper(current, regs, &ph.opaque, XENO_BUFFER_MAGIC, =
NULL);
+	ret =3D
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_BUFFER_MAGIC,
+			     NULL, 0);
 	if (ret)
 		return ret;
=20
Index: b/ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -292,7 +292,7 @@ int rt_task_create(RT_TASK *task,
=20
 	if (name) {
 		err =3D xnregistry_enter(task->rname,
-				       task,
+				       &task->thread_base,
 				       &xnthread_handle(&task->thread_base),
 				       NULL);
 		if (err)
Index: b/ksrc/skins/psos+/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/psos+/syscall.c
+++ b/ksrc/skins/psos+/syscall.c
@@ -131,7 +131,7 @@ static int __t_start(struct pt_regs *reg
 	psostask_t *task;
=20
 	handle =3D __xn_reg_arg1(regs);
-	task =3D (psostask_t *)xnregistry_fetch(handle);
+	task =3D thread2psostask((xnthread_t *)xnregistry_fetch(handle));
=20
 	if (!task)
 		return ERR_OBJID;
@@ -162,7 +162,7 @@ static int __t_delete(struct pt_regs *re
 	handle =3D __xn_reg_arg1(regs);
=20
 	if (handle)
-		task =3D (psostask_t *)xnregistry_fetch(handle);
+		task =3D thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task =3D __psos_task_current(current);
=20
@@ -182,7 +182,7 @@ static int __t_suspend(struct pt_regs *r
 	psostask_t *task;
=20
 	if (handle)
-		task =3D (psostask_t *)xnregistry_fetch(handle);
+		task =3D thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task =3D __psos_task_current(current);
=20
@@ -202,7 +202,7 @@ static int __t_resume(struct pt_regs *re
 	psostask_t *task;
=20
 	if (handle)
-		task =3D (psostask_t *)xnregistry_fetch(handle);
+		task =3D thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task =3D __psos_task_current(current);
=20
@@ -284,7 +284,7 @@ static int __t_setpri(struct pt_regs *re
 	psostask_t *task;
=20
 	if (handle)
-		task =3D (psostask_t *)xnregistry_fetch(handle);
+		task =3D thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task =3D __psos_task_current(current);
=20
@@ -314,7 +314,7 @@ static int __ev_send(struct pt_regs *reg
 	u_long events;
=20
 	if (handle)
-		task =3D (psostask_t *)xnregistry_fetch(handle);
+		task =3D thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task =3D __psos_task_current(current);
=20
@@ -1317,7 +1317,7 @@ static int __as_send(struct pt_regs *reg
 	psostask_t *task;
=20
 	if (handle)
-		task =3D (psostask_t *)xnregistry_fetch(handle);
+		task =3D thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task =3D __psos_task_current(current);
=20
Index: b/ksrc/skins/psos+/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/psos+/task.c
+++ b/ksrc/skins/psos+/task.c
@@ -161,8 +161,11 @@ u_long t_create(const char *name,
=20
 #ifdef CONFIG_XENO_OPT_REGISTRY
 	{
-		u_long err =3D xnregistry_enter(task->name,
-					      task, &xnthread_handle(&task->threadbase), NULL);
+		u_long err =3D
+			xnregistry_enter(task->name,
+					 &task->threadbase,
+					 &xnthread_handle(&task->threadbase),
+					 NULL);
 		if (err) {
 			t_delete((u_long)task);
 			return err;
Index: b/ksrc/skins/vxworks/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/vxworks/syscall.c
+++ b/ksrc/skins/vxworks/syscall.c
@@ -146,7 +146,8 @@ out:
=20
 static int __wind_task_activate(struct pt_regs *regs)
 {
-	WIND_TCB *pTcb =3D (WIND_TCB *)xnregistry_fetch(__xn_reg_arg1(regs));
+	WIND_TCB *pTcb =3D thread2wind_task(
+		(xnthread_t *)xnregistry_fetch(__xn_reg_arg1(regs)));
=20
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -167,7 +168,7 @@ static int __wind_task_deleteforce(struc
 	WIND_TCB *pTcb;
=20
 	if (handle)
-		pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb =3D __wind_task_current(current);
=20
@@ -190,7 +191,7 @@ static int __wind_task_delete(struct pt_
 	WIND_TCB *pTcb;
=20
 	if (handle)
-		pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb =3D __wind_task_current(current);
=20
@@ -213,7 +214,7 @@ static int __wind_task_suspend(struct pt
 	WIND_TCB *pTcb;
=20
 	if (handle)
-		pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb =3D __wind_task_current(current);
=20
@@ -232,7 +233,8 @@ static int __wind_task_suspend(struct pt
=20
 static int __wind_task_resume(struct pt_regs *regs)
 {
-	WIND_TCB *pTcb =3D (WIND_TCB *)xnregistry_fetch(__xn_reg_arg1(regs));
+	WIND_TCB *pTcb =3D thread2wind_task(
+		(xnthread_t *)xnregistry_fetch(__xn_reg_arg1(regs)));
=20
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -275,7 +277,7 @@ static int __wind_task_priorityset(struc
 	WIND_TCB *pTcb;
=20
 	if (handle)
-		pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb =3D __wind_task_current(current);
=20
@@ -299,7 +301,7 @@ static int __wind_task_priorityget(struc
 	int prio;
=20
 	if (handle)
-		pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb =3D __wind_task_current(current);
=20
@@ -374,7 +376,7 @@ static int __wind_task_verifyid(struct p
 	xnhandle_t handle =3D __xn_reg_arg1(regs);
 	WIND_TCB *pTcb;
=20
-	pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb =3D (thread2wind_task((xnthread_t *)xnregistry_fetch(handle)));
=20
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -574,7 +576,7 @@ static int __wind_taskinfo_name(struct p
 	const char *name;
 	WIND_TCB *pTcb;
=20
-	pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
=20
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -618,7 +620,7 @@ static int __wind_taskinfo_status(struct
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
=20
 	if (!pTcb || pTcb->magic !=3D WIND_TASK_MAGIC) {
 		xnlock_put_irqrestore(&nklock, s);
@@ -643,7 +645,7 @@ static int __wind_taskinfo_get(struct pt
 	WIND_TCB *pTcb;
 	int err;
=20
-	pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
=20
@@ -673,7 +675,7 @@ static int __wind_errno_taskset(struct p
  		return 0;
  	}
 =20
- 	pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+ 	pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
=20
@@ -696,7 +698,7 @@ static int __wind_errno_taskget(struct p
  	if (!handle)
  		errcode =3D wind_errnoget();
  	else {
- 		pTcb =3D (WIND_TCB *)xnregistry_fetch(handle);
+ 		pTcb =3D thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
  		if (!pTcb)
  			return S_objLib_OBJ_ID_ERROR;
 =20
Index: b/ksrc/skins/vxworks/taskLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/vxworks/taskLib.c
+++ b/ksrc/skins/vxworks/taskLib.c
@@ -171,8 +171,8 @@ STATUS taskInit(WIND_TCB *pTcb,
 	xnlock_put_irqrestore(&nklock, s);
=20
 #ifdef CONFIG_XENO_OPT_REGISTRY
-	if (xnregistry_enter(pTcb->name,
-			     pTcb, &xnthread_handle(&pTcb->threadbase), NULL)) {
+	if (xnregistry_enter(pTcb->name, &pTcb->threadbase,
+			     &xnthread_handle(&pTcb->threadbase), NULL)) {
 		wind_errnoset(S_objLib_OBJ_ID_ERROR);
 		taskDeleteForce((TASK_ID) pTcb);
 		return ERROR;

--------------000707060601060904080901
Content-Type: text/x-patch;
 name="handle-based-xn_sys_current.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="handle-based-xn_sys_current.patch"

---
 include/asm-generic/bits/bind.h    |    9 ++++-
 include/asm-generic/bits/current.h |    5 +-
 include/nucleus/types.h            |   13 +++++++
 ksrc/nucleus/shadow.c              |   17 ++++++++-
 ksrc/skins/native/Kconfig          |    1=20
 ksrc/skins/native/task.c           |   14 +++-----
 ksrc/skins/posix/Kconfig           |    1=20
 ksrc/skins/posix/cb_lock.h         |   15 ++++++--
 ksrc/skins/posix/cond.c            |   12 ++++--
 ksrc/skins/posix/mutex.c           |   21 +++++++-----
 ksrc/skins/posix/mutex.h           |   64 ++++++++++++++++++++++++------=
-------
 ksrc/skins/posix/syscall.c         |   11 +++---
 ksrc/skins/posix/thread.c          |   16 +++++++++
 ksrc/skins/psos+/Kconfig           |    2 -
 ksrc/skins/rtai/Kconfig            |    1=20
 ksrc/skins/rtai/task.c             |   12 ++++++
 ksrc/skins/uitron/Kconfig          |    1=20
 ksrc/skins/uitron/task.c           |   11 ++++++
 ksrc/skins/vrtx/Kconfig            |    2 -
 ksrc/skins/vrtx/task.c             |   20 ++++++++++-
 ksrc/skins/vxworks/Kconfig         |    2 -
 src/skins/posix/mutex.c            |   27 ++++++++-------
 22 files changed, 201 insertions(+), 76 deletions(-)

Index: b/include/asm-generic/bits/current.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/bits/current.h
+++ b/include/asm-generic/bits/current.h
@@ -2,14 +2,15 @@
 #define _XENO_ASM_GENERIC_CURRENT_H
=20
 #include <pthread.h>
+#include <nucleus/types.h>
=20
 extern pthread_key_t xeno_current_key;
=20
 extern void xeno_set_current(void);
=20
-static inline void *xeno_get_current(void)
+static inline xnhandle_t xeno_get_current(void)
 {
-	return pthread_getspecific(xeno_current_key);
+	return (xnhandle_t)pthread_getspecific(xeno_current_key);
 }
=20
 #endif /* _XENO_ASM_GENERIC_CURRENT_H */
Index: b/include/nucleus/types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/nucleus/types.h
+++ b/include/nucleus/types.h
@@ -61,6 +61,19 @@ typedef unsigned long xnhandle_t;
=20
 #define XN_NO_HANDLE ((xnhandle_t)0)
=20
+#define XN_HANDLE_SPARE0	((xnhandle_t)0x10000000)
+#define XN_HANDLE_SPARE1	((xnhandle_t)0x20000000)
+#define XN_HANDLE_SPARE2	((xnhandle_t)0x40000000)
+#define XN_HANDLE_SPARE3	((xnhandle_t)0x80000000)
+#define XN_HANDLE_SPARE_MASK	((xnhandle_t)0xf0000000)
+
+#define xnhandle_mask_spare(handle)  ((handle) & ~XN_HANDLE_SPARE_MASK)
+#define xnhandle_test_spare(handle, bits)  (!!((handle) & (bits)))
+#define xnhandle_set_spare(handle, bits) \
+	do { (handle) |=3D (bits); } while (0)
+#define xnhandle_clear_spare(handle, bits) \
+	do { (handle) &=3D ~(bits); } while (0)
+
 struct xnintr;
=20
 typedef int (*xnisr_t)(struct xnintr *intr);
Index: b/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -52,6 +52,7 @@
 #include <nucleus/trace.h>
 #include <nucleus/stat.h>
 #include <nucleus/sys_ppd.h>
+#include <nucleus/registry.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
 #include <asm/xenomai/bits/shadow.h>
@@ -1908,13 +1909,21 @@ static int xnshadow_sys_sem_heap(struct
 	return __xn_safe_copy_to_user(us_hinfo, &hinfo, sizeof(*us_hinfo));
 }
=20
+#ifdef CONFIG_XENO_OPT_REGISTRY
 static int xnshadow_sys_current(struct pt_regs *regs)
 {
-	xnthread_t * __user *us_current, *cur =3D xnshadow_thread(current);
-	us_current =3D (xnthread_t *__user *) __xn_reg_arg1(regs);
+	xnthread_t *cur =3D xnshadow_thread(current);
+	xnhandle_t __user *us_handle;
=20
-	return __xn_safe_copy_to_user(us_current, &cur, sizeof(*us_current));
+	if (!cur)
+		return -EPERM;
+
+	us_handle =3D (xnhandle_t __user *) __xn_reg_arg1(regs);
+
+	return __xn_safe_copy_to_user(us_handle, &xnthread_handle(cur),
+				      sizeof(*us_handle));
 }
+#endif /* CONFIG_XENO_OPT_REGISTRY */
=20
 static xnsysent_t __systab[] =3D {
 	[__xn_sys_migrate] =3D {&xnshadow_sys_migrate, __xn_exec_current},
@@ -1925,7 +1934,9 @@ static xnsysent_t __systab[] =3D {
 	[__xn_sys_barrier] =3D {&xnshadow_sys_barrier, __xn_exec_lostage},
 	[__xn_sys_trace] =3D {&xnshadow_sys_trace, __xn_exec_any},
 	[__xn_sys_sem_heap] =3D {&xnshadow_sys_sem_heap, __xn_exec_any},
+#ifdef CONFIG_XENO_OPT_REGISTRY
 	[__xn_sys_current] =3D {&xnshadow_sys_current, __xn_exec_any},
+#endif /* CONFIG_XENO_OPT_REGISTRY */
 };
=20
 static void *xnshadow_sys_event(int event, void *data)
Index: b/ksrc/skins/posix/cb_lock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/cb_lock.h
+++ b/ksrc/skins/posix/cb_lock.h
@@ -3,15 +3,22 @@
=20
 #include <asm/xenomai/atomic.h>
 #include <nucleus/compiler.h>
+#include <nucleus/types.h>
=20
 #ifndef __KERNEL__
 typedef void xnthread_t;
 #endif /* __KERNEL__ */
=20
-#define test_claimed(owner) ((long) (owner) & 1)
-#define clear_claimed(owner) ((xnthread_t *) ((long) (owner) & ~1))
-#define set_claimed(owner, bit) \
-        ((xnthread_t *) ((long) clear_claimed(owner) | !!(bit)))
+#define __CLAIMED_BIT		XN_HANDLE_SPARE3
+
+#define test_claimed(owner)	xnhandle_test_spare(owner, __CLAIMED_BIT)
+#define clear_claimed(owner)	xnhandle_mask_spare(owner)
+#define set_claimed(owner, bit) ({ \
+	xnhandle_t __tmp =3D xnhandle_mask_spare(owner); \
+	if (bit) \
+		xnhandle_set_spare(__tmp, __CLAIMED_BIT); \
+	__tmp; \
+})
=20
 #ifdef CONFIG_XENO_FASTSEM
=20
Index: b/ksrc/skins/posix/cond.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/cond.c
+++ b/ksrc/skins/posix/cond.c
@@ -230,18 +230,20 @@ static inline int mutex_save_count(xnthr
=20
 	mutex =3D shadow->mutex;
=20
-	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) !=3D cur)
+	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=3D
+	    xnthread_handle(cur))
 		return EPERM;
=20
 	*count_ptr =3D shadow->lockcnt;
=20
-	if (likely(xnarch_atomic_intptr_cmpxchg(mutex->owner, cur, NULL) =3D=3D=
 cur))
+	if (likely(xnarch_atomic_cmpxchg(mutex->owner, cur, XN_NO_HANDLE) =3D=3D=

+		   xnthread_handle(cur)))
 		return 0;
=20
 	owner =3D xnsynch_wakeup_one_sleeper(&mutex->synchbase);
-	xnarch_atomic_intptr_set
-		(mutex->owner,
-		 set_claimed(owner,xnsynch_nsleepers(&mutex->synchbase)));
+	xnarch_atomic_set(mutex->owner,
+			  set_claimed(xnthread_handle(owner),
+				      xnsynch_nsleepers(&mutex->synchbase)));
=20
 	/* Do not reschedule here, releasing the mutex and suspension must be
 	   done atomically in pthread_cond_*wait. */
Index: b/ksrc/skins/posix/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -82,7 +82,7 @@ int pse51_mutex_check_init(struct __shad
=20
 int pse51_mutex_init_internal(struct __shadow_mutex *shadow,
 			      pse51_mutex_t *mutex,
-			      xnarch_atomic_intptr_t *ownerp,
+			      xnarch_atomic_t *ownerp,
 			      const pthread_mutexattr_t *attr)
 {
 	xnflags_t synch_flags =3D XNSYNCH_PRIO | XNSYNCH_NOPIP;
@@ -118,7 +118,7 @@ int pse51_mutex_init_internal(struct __s
 	mutex->owner =3D ownerp;
 	mutex->owningq =3D kq;
 	mutex->sleepers =3D 0;
-	xnarch_atomic_intptr_set(ownerp, NULL);
+	xnarch_atomic_set(ownerp, XN_NO_HANDLE);
=20
 	xnlock_get_irqsave(&nklock, s);
 	appendq(&kq->mutexq, &mutex->link);
@@ -159,7 +159,7 @@ int pthread_mutex_init(pthread_mutex_t *
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
 	DECLARE_CB_LOCK_FLAGS(s);
 	pse51_mutex_t *mutex;
-	xnarch_atomic_intptr_t *ownerp;
+	xnarch_atomic_t *ownerp;
 	int err;
=20
 	if (!attr)
@@ -185,9 +185,9 @@ int pthread_mutex_init(pthread_mutex_t *
 	if (!mutex)
 		return ENOMEM;
=20
-	ownerp =3D (xnarch_atomic_intptr_t *)
+	ownerp =3D (xnarch_atomic_t *)
 		xnheap_alloc(&xnsys_ppd_get(attr->pshared)->sem_heap,
-			     sizeof(xnarch_atomic_intptr_t));
+			     sizeof(xnarch_atomic_t));
 	if (!ownerp) {
 		xnfree(mutex);
 		return EAGAIN;
@@ -266,7 +266,7 @@ int pthread_mutex_destroy(pthread_mutex_
 		return EPERM;
 	}
=20
-	if (xnarch_atomic_intptr_get(mutex->owner)) {
+	if (xnarch_atomic_get(mutex->owner)) {
 		cb_write_unlock(&shadow->lock, s);
 		return EBUSY;
 	}
@@ -290,6 +290,10 @@ int pse51_mutex_timedlock_break(struct _
 	spl_t s;
 	int err;
=20
+	/* We need a valid thread handle for the fast lock. */
+	if (!xnthread_handle(cur))
+		return -EPERM;
+
 	err =3D pse51_mutex_timedlock_internal(cur, shadow, 1, timed, abs_to);
 	if (err !=3D -EBUSY)
 		goto unlock_and_return;
@@ -392,7 +396,7 @@ int pthread_mutex_trylock(pthread_mutex_
 		return -PTR_ERR(owner);
=20
 	err =3D EBUSY;
-	if (clear_claimed(owner) =3D=3D cur) {
+	if (owner =3D=3D cur) {
 		pse51_mutex_t *mutex =3D shadow->mutex;
=20
 		if (mutex->attr.type =3D=3D PTHREAD_MUTEX_RECURSIVE) {
@@ -573,7 +577,8 @@ int pthread_mutex_unlock(pthread_mutex_t
=20
 	mutex =3D shadow->mutex;
 =09
-	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) !=3D cur) {
+	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=3D
+	    xnthread_handle(cur)) {
 		err =3D EPERM;
 		goto out;
 	}
Index: b/ksrc/skins/posix/mutex.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -34,7 +34,7 @@ union __xeno_mutex {
 		xnarch_atomic_t lock;
 		union {
 			unsigned owner_offset;
-			xnarch_atomic_intptr_t *owner;
+			xnarch_atomic_t *owner;
 		};
 		struct pse51_mutexattr attr;
 #endif /* CONFIG_XENO_FASTSEM */
@@ -43,6 +43,7 @@ union __xeno_mutex {
=20
 #ifdef __KERNEL__
=20
+#include <nucleus/registry.h>
 #include <posix/internal.h>
 #include <posix/thread.h>
 #include <posix/cb_lock.h>
@@ -54,7 +55,7 @@ typedef struct pse51_mutex {
 #define link2mutex(laddr)                                               =
\
 	((pse51_mutex_t *)(((char *)laddr) - offsetof(pse51_mutex_t, link)))
=20
-	xnarch_atomic_intptr_t *owner;
+	xnarch_atomic_t *owner;
 	pthread_mutexattr_t attr;
 	unsigned sleepers;
 	pse51_kqueues_t *owningq;
@@ -77,7 +78,7 @@ int pse51_mutex_check_init(struct __shad
=20
 int pse51_mutex_init_internal(struct __shadow_mutex *shadow,
 			      pse51_mutex_t *mutex,
-			      xnarch_atomic_intptr_t *ownerp,
+			      xnarch_atomic_t *ownerp,
 			      const pthread_mutexattr_t *attr);
=20
 void pse51_mutex_destroy_internal(pse51_mutex_t *mutex,
@@ -88,6 +89,7 @@ pse51_mutex_trylock_internal(xnthread_t
 			     struct __shadow_mutex *shadow, unsigned count)
 {
 	pse51_mutex_t *mutex =3D shadow->mutex;
+	xnhandle_t ownerh;
 	xnthread_t *owner;
=20
 	if (xnpod_unblockable_p())
@@ -101,9 +103,14 @@ pse51_mutex_trylock_internal(xnthread_t
 		return ERR_PTR(-EPERM);
 #endif /* XENO_DEBUG(POSIX) */
=20
-	owner =3D xnarch_atomic_intptr_cmpxchg(mutex->owner, NULL, cur);
-	if (unlikely(owner !=3D NULL))
+	ownerh =3D xnarch_atomic_cmpxchg(mutex->owner, XN_NO_HANDLE,
+				       xnthread_handle(cur));
+	if (unlikely(ownerh)) {
+		owner =3D xnregistry_fetch(clear_claimed(ownerh));
+		if (!owner)
+			return ERR_PTR(-EINVAL);
 		return owner;
+	}
=20
 	shadow->lockcnt =3D count;
 	return NULL;
@@ -118,7 +125,8 @@ static inline int pse51_mutex_timedlock_
=20
 {
 	pse51_mutex_t *mutex;
-	xnthread_t *owner, *old;
+	xnthread_t *owner;
+	xnhandle_t ownerh, old;
 	spl_t s;
 	int err;
=20
@@ -128,32 +136,41 @@ static inline int pse51_mutex_timedlock_
 		return PTR_ERR(owner);
=20
 	mutex =3D shadow->mutex;
-	if (clear_claimed(owner) =3D=3D cur)
+	if (owner =3D=3D cur)
 		return -EBUSY;
=20
 	/* Set bit 0, so that mutex_unlock will know that the mutex is claimed.=

 	   Hold the nklock, for mutual exclusion with slow mutex_unlock. */
 	xnlock_get_irqsave(&nklock, s);
-	if (test_claimed(owner)) {
-		old =3D xnarch_atomic_intptr_get(mutex->owner);
+	if (test_claimed(ownerh)) {
+		old =3D xnarch_atomic_get(mutex->owner);
 		goto test_no_owner;
 	}
 	do {
-		old =3D xnarch_atomic_intptr_cmpxchg(mutex->owner,
-						   owner, set_claimed(owner, 1));
-		if (likely(old =3D=3D owner))
+		old =3D xnarch_atomic_cmpxchg(mutex->owner, ownerh,
+					    set_claimed(ownerh, 1));
+		if (likely(old =3D=3D ownerh))
 			break;
 	  test_no_owner:
-		if (old =3D=3D NULL) {
+		if (!old) {
 			/* Owner called fast mutex_unlock
 			   (on another cpu) */
 			xnlock_put_irqrestore(&nklock, s);
 			goto retry_lock;
 		}
-		owner =3D old;
-	} while (!test_claimed(owner));
+		ownerh =3D old;
+	} while (!test_claimed(ownerh));
+
+	owner =3D xnregistry_fetch(clear_claimed(ownerh));
+
+	/* Consistency check for owner handle - is the object a thread? */
+	if (unlikely(!owner ||
+		     xnthread_handle(owner) !=3D clear_claimed(ownerh))) {
+		err =3D -EINVAL;
+		goto error;
+	}
=20
-	xnsynch_set_owner(&mutex->synchbase, clear_claimed(owner));
+	xnsynch_set_owner(&mutex->synchbase, owner);
 	++mutex->sleepers;
 	if (timed)
 		xnsynch_sleep_on(&mutex->synchbase, abs_to, XN_REALTIME);
@@ -174,7 +191,8 @@ static inline int pse51_mutex_timedlock_
 		goto error;
 	}
=20
-	xnarch_atomic_intptr_set(mutex->owner,set_claimed(cur, mutex->sleepers)=
);
+	ownerh =3D set_claimed(xnthread_handle(cur), mutex->sleepers);
+	xnarch_atomic_set(mutex->owner, ownerh);
 	shadow->lockcnt =3D count;
 	xnlock_put_irqrestore(&nklock, s);
=20
@@ -182,9 +200,9 @@ static inline int pse51_mutex_timedlock_
=20
   error:
 	if (!mutex->sleepers)
-		xnarch_atomic_intptr_set
+		xnarch_atomic_set
 			(mutex->owner,
-			 clear_claimed(xnarch_atomic_intptr_get(mutex->owner)));
+			 clear_claimed(xnarch_atomic_get(mutex->owner)));
 	xnlock_put_irqrestore(&nklock, s);
 	return err;
 }
@@ -192,16 +210,18 @@ static inline int pse51_mutex_timedlock_
 static inline void pse51_mutex_unlock_internal(xnthread_t *cur,
 					       pse51_mutex_t *mutex)
 {
+	xnhandle_t ownerh;
 	xnthread_t *owner;
 	spl_t s;
=20
-	if (likely(xnarch_atomic_intptr_cmpxchg(mutex->owner, cur, NULL) =3D=3D=
 cur))
+	if (likely(xnarch_atomic_cmpxchg(mutex->owner, cur, XN_NO_HANDLE) =3D=3D=

+		   xnthread_handle(cur)))
 		return;
=20
 	xnlock_get_irqsave(&nklock, s);
 	owner =3D xnsynch_wakeup_one_sleeper(&mutex->synchbase);
-	xnarch_atomic_intptr_set(mutex->owner,
-				 set_claimed(owner, mutex->sleepers));
+	ownerh =3D set_claimed(xnthread_handle(owner), mutex->sleepers);
+	xnarch_atomic_set(mutex->owner, ownerh);
 	if (owner)
 		xnpod_schedule();
 	xnlock_put_irqrestore(&nklock, s);
Index: b/ksrc/skins/posix/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -1060,7 +1060,8 @@ static int __pthread_mutex_unlock(struct
=20
 	mutex =3D shadow->mutex;
=20
-	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) !=3D cur) {
+	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=3D
+	    xnthread_handle(cur)) {
 		err =3D -EPERM;
 		goto out;
 	}
@@ -1119,7 +1120,7 @@ static int __pthread_mutex_init(struct p
 	pthread_mutexattr_t locattr, *attr, *uattrp;
 	union __xeno_mutex mx, *umx;
 	pse51_mutex_t *mutex;
-	xnarch_atomic_intptr_t *ownerp;
+	xnarch_atomic_t *ownerp;
 	int err;
=20
 	umx =3D (union __xeno_mutex *)__xn_reg_arg1(regs);
@@ -1144,9 +1145,9 @@ static int __pthread_mutex_init(struct p
 	if (!mutex)
 		return -ENOMEM;
=20
-	ownerp =3D (xnarch_atomic_intptr_t *)
+	ownerp =3D (xnarch_atomic_t *)
 		xnheap_alloc(&xnsys_ppd_get(attr->pshared)->sem_heap,
-			     sizeof(xnarch_atomic_intptr_t));
+			     sizeof(xnarch_atomic_t));
 	if (!ownerp) {
 		xnfree(mutex);
 		return -EAGAIN;
@@ -1185,7 +1186,7 @@ static int __pthread_mutex_destroy(struc
 	if (pse51_kqueues(mutex->attr.pshared) !=3D mutex->owningq)
 		return -EPERM;
=20
-	if (xnarch_atomic_intptr_get(mutex->owner))
+	if (xnarch_atomic_get(mutex->owner))
 		return -EBUSY;
=20
 	pse51_mark_deleted(shadow);
Index: b/src/skins/posix/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/src/skins/posix/mutex.c
+++ b/src/skins/posix/mutex.c
@@ -31,12 +31,12 @@ extern int __pse51_muxid;
=20
 extern unsigned long xeno_sem_heap[2];
=20
-static xnarch_atomic_intptr_t *get_ownerp(struct __shadow_mutex *shadow)=

+static xnarch_atomic_t *get_ownerp(struct __shadow_mutex *shadow)
 {
 	if (likely(!shadow->attr.pshared))
 		return shadow->owner;
 =09
-	return (xnarch_atomic_intptr_t *) (xeno_sem_heap[1] + shadow->owner_off=
set);
+	return (xnarch_atomic_t *) (xeno_sem_heap[1] + shadow->owner_offset);
 }
 #endif /* CONFIG_XENO_FASTSEM */
=20
@@ -117,7 +117,7 @@ int __wrap_pthread_mutex_init(pthread_mu
=20
 #ifdef CONFIG_XENO_FASTSEM
 	if (!shadow->attr.pshared)
-		shadow->owner =3D (xnarch_atomic_intptr_t *)
+		shadow->owner =3D (xnarch_atomic_t *)
 			(xeno_sem_heap[0] + shadow->owner_offset);
 =09
 	cb_write_unlock(&shadow->lock, s);
@@ -149,7 +149,7 @@ int __wrap_pthread_mutex_lock(pthread_mu
 	int err =3D 0;
=20
 #ifdef CONFIG_XENO_FASTSEM
-	xnthread_t *cur, *owner;
+	xnhandle_t cur, owner;
=20
 	cur =3D xeno_get_current();
 	if (!cur)
@@ -163,7 +163,7 @@ int __wrap_pthread_mutex_lock(pthread_mu
 		goto out;
 	}
=20
-	owner =3D xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	owner =3D xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);=

 	if (likely(!owner)) {
 		shadow->lockcnt =3D 1;
 		cb_read_unlock(&shadow->lock, s);
@@ -210,7 +210,7 @@ int __wrap_pthread_mutex_timedlock(pthre
 	int err =3D 0;
=20
 #ifdef CONFIG_XENO_FASTSEM
-	xnthread_t *cur, *owner;
+	xnhandle_t cur, owner;
=20
 	cur =3D xeno_get_current();
 	if (!cur)
@@ -224,7 +224,7 @@ int __wrap_pthread_mutex_timedlock(pthre
 		goto out;
 	}=09
=20
-	owner =3D xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	owner =3D xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);=

 	if (likely(!owner)) {
 		shadow->lockcnt =3D 1;
 		cb_read_unlock(&shadow->lock, s);
@@ -271,7 +271,7 @@ int __wrap_pthread_mutex_trylock(pthread
 	int err =3D 0;
=20
 #ifdef CONFIG_XENO_FASTSEM
-	xnthread_t *cur, *owner;
+	xnhandle_t cur, owner;
=20
 	cur =3D xeno_get_current();
 	if (!cur)
@@ -285,7 +285,7 @@ int __wrap_pthread_mutex_trylock(pthread
 		goto out;
 	}=09
=20
-	owner =3D xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	owner =3D xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);=

 	if (likely(!owner)) {
 		shadow->lockcnt =3D 1;
 		cb_read_unlock(&shadow->lock, s);
@@ -325,8 +325,8 @@ int __wrap_pthread_mutex_unlock(pthread_
 	int err =3D 0;
=20
 #ifdef CONFIG_XENO_FASTSEM
-	xnarch_atomic_intptr_t *ownerp;
-	xnthread_t *cur;
+	xnarch_atomic_t *ownerp;
+	xnhandle_t cur, owner;
=20
 	cur =3D xeno_get_current();
 	if (!cur)
@@ -341,7 +341,8 @@ int __wrap_pthread_mutex_unlock(pthread_
 	}
=20
 	ownerp =3D get_ownerp(shadow);
-	if (unlikely(clear_claimed(xnarch_atomic_intptr_get(ownerp)) !=3D cur))=
 {
+	owner =3D clear_claimed(xnarch_atomic_get(ownerp));
+	if (unlikely(owner !=3D cur)) {
 		err =3D -EPERM;
 		goto out_err;
 	}
@@ -352,7 +353,7 @@ int __wrap_pthread_mutex_unlock(pthread_
 		goto out;
 	}
=20
-	if (likely(xnarch_atomic_intptr_cmpxchg(ownerp, cur, NULL) =3D=3D cur))=
 {
+	if (likely(xnarch_atomic_cmpxchg(ownerp, cur, XN_NO_HANDLE) =3D=3D cur)=
) {
 	  out:
 		cb_read_unlock(&shadow->lock, s);
 		return 0;
Index: b/ksrc/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/thread.c
+++ b/ksrc/skins/posix/thread.c
@@ -28,6 +28,7 @@
  *=20
  *@{*/
=20
+#include <nucleus/registry.h>
 #include <posix/thread.h>
 #include <posix/cancel.h>
 #include <posix/timer.h>
@@ -234,6 +235,21 @@ int pthread_create(pthread_t *tid,
 	thread->hkey.mm =3D NULL;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
=20
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	{
+		int err =3D
+		    xnregistry_enter("", &thread->threadbase,
+				     &xnthread_handle(&thread->threadbase),
+						      NULL);
+		if (err) {
+			thread_destroy(thread);
+			return err;
+		}
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
 	*tid =3D thread;		/* Must be done before the thread is started. */
=20
 	if (start)		/* Do not start shadow threads (i.e. start =3D=3D NULL). */=

Index: b/ksrc/skins/posix/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/Kconfig
+++ b/ksrc/skins/posix/Kconfig
@@ -1,5 +1,6 @@
 menuconfig XENO_SKIN_POSIX
 	depends on XENO_OPT_NUCLEUS=20
+	select XENO_OPT_REGISTRY if XENO_FASTSEM
 	tristate "POSIX API"
 	default y
 	help
Index: b/include/asm-generic/bits/bind.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -22,7 +22,14 @@ __attribute__ ((weak))
 void xeno_set_current(void)
 {
 	void *kthread_cb;
-	XENOMAI_SYSCALL1(__xn_sys_current, &kthread_cb);
+	int err;
+
+	err =3D XENOMAI_SYSCALL1(__xn_sys_current, &kthread_cb);
+	if (err) {
+		fprintf(stderr, "Xenomai: error obtaining handle for current "
+			"thread: %s\n", strerror(err));
+		exit(1);
+	}
 	pthread_setspecific(xeno_current_key, kthread_cb);
 }
=20
Index: b/ksrc/skins/native/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/native/Kconfig
+++ b/ksrc/skins/native/Kconfig
@@ -1,5 +1,6 @@
 menuconfig XENO_SKIN_NATIVE
 	depends on XENO_OPT_NUCLEUS
+	select XENO_OPT_REGISTRY if XENO_FASTSEM
 	tristate "Native API"
 	default y
 	help
Index: b/ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -290,14 +290,12 @@ int rt_task_create(RT_TASK *task,
 	   complete objects, so that the registry cannot return handles to
 	   half-baked objects... */
=20
-	if (name) {
-		err =3D xnregistry_enter(task->rname,
-				       &task->thread_base,
-				       &xnthread_handle(&task->thread_base),
-				       NULL);
-		if (err)
-			xnpod_delete_thread(&task->thread_base);
-	}
+	err =3D xnregistry_enter(name ? task->rname : "",
+			       &task->thread_base,
+			       &xnthread_handle(&task->thread_base),
+			       NULL);
+	if (err)
+		xnpod_delete_thread(&task->thread_base);
 #endif /* CONFIG_XENO_OPT_REGISTRY */
=20
 	return err;
Index: b/ksrc/skins/psos+/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/psos+/Kconfig
+++ b/ksrc/skins/psos+/Kconfig
@@ -2,7 +2,7 @@ menuconfig XENO_SKIN_PSOS
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "pSOS+ emulator"
-	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE
+	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || XENO_FASTSEM
 	help
=20
 	This API skin emulates WindRiver's pSOS+ operating system.
Index: b/ksrc/skins/uitron/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/uitron/Kconfig
+++ b/ksrc/skins/uitron/Kconfig
@@ -2,6 +2,7 @@ menuconfig XENO_SKIN_UITRON
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	select XENO_OPT_MAP
+	select XENO_OPT_REGISTRY if XENO_FASTSEM
 	tristate "uITRON API"
 	help
=20
Index: b/ksrc/skins/uitron/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/uitron/task.c
+++ b/ksrc/skins/uitron/task.c
@@ -151,6 +151,17 @@ ER cre_tsk(ID tskid, T_CTSK *pk_ctsk)
 	xnlock_put_irqrestore(&nklock, s);
 	task->magic =3D uITRON_TASK_MAGIC;
=20
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	if (xnregistry_enter("", &task->threadbase,
+			     &xnthread_handle(&task->threadbase), NULL)) {
+		xnmap_remove(ui_task_idmap, tskid);
+		xnpod_abort_thread(&task->threadbase);
+		return E_NOMEM;
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
 	return E_OK;
 }
=20
Index: b/ksrc/skins/rtai/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/rtai/Kconfig
+++ b/ksrc/skins/rtai/Kconfig
@@ -1,5 +1,6 @@
 menuconfig XENO_SKIN_RTAI
 	depends on XENO_OPT_NUCLEUS
+	select XENO_OPT_REGISTRY if XENO_FASTSEM
 	tristate "RTAI emulator"
 	help
=20
Index: b/ksrc/skins/rtai/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/rtai/task.c
+++ b/ksrc/skins/rtai/task.c
@@ -20,6 +20,7 @@
=20
 #include <nucleus/pod.h>
 #include <nucleus/heap.h>
+#include <nucleus/registry.h>
 #include <rtai/task.h>
=20
 static DEFINE_XNQUEUE(__rtai_task_q);
@@ -152,6 +153,17 @@ int rt_task_init(RT_TASK *task,
 	task->magic =3D RTAI_TASK_MAGIC;
 	appendq(&__rtai_task_q, &task->link);
=20
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	err =3D xnregistry_enter("", &task->thread_base,
+			       &xnthread_handle(&task->thread_base), NULL);
+	if (err) {
+		xnpod_abort_thread(&task->thread_base);
+		goto unlock_and_exit;
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
 	/* Add a switch hook only if a signal function has been declared
 	   at least once for some created task. */
=20
Index: b/ksrc/skins/vrtx/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/vrtx/Kconfig
+++ b/ksrc/skins/vrtx/Kconfig
@@ -3,7 +3,7 @@ menuconfig XENO_SKIN_VRTX
 	select XENO_OPT_TIMING_PERIODIC
 	select XENO_OPT_MAP
 	tristate "VRTX emulator"
-	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE
+	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || CONFIG_XENO_FASTSEM
 	help
=20
 	This API skin emulates Mentor Graphics's VRTX operating
Index: b/ksrc/skins/vrtx/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/vrtx/task.c
+++ b/ksrc/skins/vrtx/task.c
@@ -188,12 +188,28 @@ int sc_tecreate_inner(vrtxtask_t *task,
 	if (mode & 0x10)
 		bmode |=3D XNRRB;
=20
-	*errp =3D RET_OK;
-
 	xnlock_get_irqsave(&nklock, s);
 	appendq(&vrtx_task_q, &task->link);
 	xnlock_put_irqrestore(&nklock, s);
=20
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	{
+		int err =3D
+		    xnregistry_enter("", &task->threadbase,
+				     &xnthread_handle(&task->threadbase),
+						      NULL);
+		if (err) {
+			xnpod_abort_thread(&task->threadbase);
+			*errp =3D ER_MEM;
+			return -1;
+		}
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
+	*errp =3D RET_OK;
+
 	xnpod_start_thread(&task->threadbase,
 			   bmode, 0, XNPOD_ALL_CPUS, &vrtxtask_trampoline,
 			   task);
Index: b/ksrc/skins/vxworks/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/vxworks/Kconfig
+++ b/ksrc/skins/vxworks/Kconfig
@@ -2,7 +2,7 @@ menuconfig XENO_SKIN_VXWORKS
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "VxWorks emulator"
-	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE
+	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || XENO_FASTSEM
 	help
=20
 	This API skin emulates WindRiver's VxWorks operating system.

--------------000707060601060904080901
Content-Type: text/x-patch;
 name="remove-xnarch_atomic_intptr.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="remove-xnarch_atomic_intptr.patch"

---
 include/asm-arm/atomic.h        |    3 ---
 include/asm-blackfin/atomic.h   |    2 --
 include/asm-generic/Makefile.am |    2 +-
 include/asm-generic/Makefile.in |    2 +-
 include/asm-generic/atomic.h    |   24 ------------------------
 include/asm-ia64/atomic.h       |    2 --
 include/asm-powerpc/atomic.h    |    2 --
 include/asm-x86/atomic.h        |    2 --
 8 files changed, 2 insertions(+), 37 deletions(-)

Index: b/include/asm-arm/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-arm/atomic.h
+++ b/include/asm-arm/atomic.h
@@ -412,9 +412,6 @@ static __inline__ void xnarch_atomic_cle
=20
 typedef unsigned long atomic_flags_t;
=20
-/* Add support for xnarch_atomic_intptr_t */
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_ARM_ATOMIC_H */
=20
 // vim: ts=3D4 et sw=3D4 sts=3D4
Index: b/include/asm-blackfin/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-blackfin/atomic.h
+++ b/include/asm-blackfin/atomic.h
@@ -42,8 +42,6 @@
 typedef atomic_t atomic_counter_t;
 typedef atomic_t xnarch_atomic_t;
=20
-#include <asm-generic/xenomai/atomic.h>
-
 #else /* !__KERNEL__ */
=20
 #include <asm/xenomai/syscall.h>
Index: b/include/asm-generic/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/Makefile.am
+++ b/include/asm-generic/Makefile.am
@@ -1,5 +1,5 @@
 includesubdir =3D $(includedir)/asm-generic
=20
-includesub_HEADERS =3D arith.h atomic.h features.h hal.h syscall.h syste=
m.h wrappers.h
+includesub_HEADERS =3D arith.h features.h hal.h syscall.h system.h wrapp=
ers.h
=20
 SUBDIRS =3D bits
Index: b/include/asm-generic/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/Makefile.in
+++ b/include/asm-generic/Makefile.in
@@ -226,7 +226,7 @@ target_vendor =3D @target_vendor@
 top_builddir =3D @top_builddir@
 top_srcdir =3D @top_srcdir@
 includesubdir =3D $(includedir)/asm-generic
-includesub_HEADERS =3D arith.h atomic.h features.h hal.h syscall.h syste=
m.h wrappers.h
+includesub_HEADERS =3D arith.h features.h hal.h syscall.h system.h wrapp=
ers.h
 SUBDIRS =3D bits
 all: all-recursive
=20
Index: b/include/asm-generic/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/atomic.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef _XENO_ASM_GENERIC_ATOMIC_H
-#define _XENO_ASM_GENERIC_ATOMIC_H
-
-typedef xnarch_atomic_t xnarch_atomic_intptr_t;
-
-static inline void *xnarch_atomic_intptr_get(xnarch_atomic_intptr_t *l)
-{
-        xnarch_atomic_t *v =3D (xnarch_atomic_t *)l;
-
-        return (void *)xnarch_atomic_get(v);
-}
-
-static inline void xnarch_atomic_intptr_set(xnarch_atomic_intptr_t *l, v=
oid *i)
-{
-        xnarch_atomic_t *v =3D (xnarch_atomic_t *)l;
-
-        xnarch_atomic_set(v, (long)i);
-}
-
-#define xnarch_atomic_intptr_cmpxchg(l, old, newval) \
-        (void *)(xnarch_atomic_cmpxchg((xnarch_atomic_t *)(l), \
-				       (long)(old), (long)(newval)))
-
-#endif /* _XENO_ASM_GENERIC_ATOMIC_H */
Index: b/include/asm-ia64/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-ia64/atomic.h
+++ b/include/asm-ia64/atomic.h
@@ -71,8 +71,6 @@ static inline void atomic_clear_mask(uns
 #define xnarch_atomic_cmpxchg(pcounter,old,new) \
 	cmpxchg((&(pcounter)->counter),(old),(new))
=20
-#include <asm-generic/xenomai/atomic.h>
-
 #else /* !__KERNEL__ */
=20
 #include <asm/xenomai/features.h>
Index: b/include/asm-powerpc/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-powerpc/atomic.h
+++ b/include/asm-powerpc/atomic.h
@@ -262,6 +262,4 @@ xnarch_atomic_cmpxchg(xnarch_atomic_t *p
=20
 typedef unsigned long atomic_flags_t;
=20
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_POWERPC_ATOMIC_H */
Index: b/include/asm-x86/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86/atomic.h
+++ b/include/asm-x86/atomic.h
@@ -136,6 +136,4 @@ xnarch_atomic_cmpxchg(xnarch_atomic_t *v
=20
 #endif /* __KERNEL__ */
=20
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_X86_ATOMIC_64_H */

--------------000707060601060904080901
Content-Type: text/x-patch;
 name="spread-xeno_set_current.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="spread-xeno_set_current.patch"

---
 src/skins/native/task.c     |   13 +++++++++++--
 src/skins/psos+/task.c      |   18 ++++++++++++++----
 src/skins/uitron/task.c     |   18 +++++++++++++-----
 src/skins/vrtx/task.c       |    3 +++
 src/skins/vxworks/taskLib.c |    3 +++
 5 files changed, 44 insertions(+), 11 deletions(-)

Index: b/src/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -26,6 +26,7 @@
 #include <limits.h>
 #include <native/syscall.h>
 #include <native/task.h>
+#include <asm-generic/bits/current.h>
 #include "wrappers.h"
=20
 extern pthread_key_t __native_tskey;
@@ -88,6 +89,8 @@ static void *rt_task_trampoline(void *co
 	if (err)
 		goto fail;
=20
+	xeno_set_current();
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
@@ -169,6 +172,7 @@ int rt_task_shadow(RT_TASK *task, const
 	struct sched_param param;
 	struct rt_arg_bulk bulk;
 	RT_TASK task_desc;
+	int err;
=20
 	if (task =3D=3D NULL)
 		task =3D &task_desc; /* Discarded. */
@@ -191,8 +195,13 @@ int rt_task_shadow(RT_TASK *task, const
 	bulk.a4 =3D (u_long)mode;
 	bulk.a5 =3D (u_long)pthread_self();
=20
-	return XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
-				 NULL);
+	err =3D XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
+				NULL);
+
+	if (!err)
+		xeno_set_current();
+
+	return err;
 }
=20
 int rt_task_bind(RT_TASK *task, const char *name, RTIME timeout)
Index: b/src/skins/psos+/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/src/skins/psos+/task.c
+++ b/src/skins/psos+/task.c
@@ -26,6 +26,7 @@
 #include <memory.h>
 #include <string.h>
 #include <psos+/psos.h>
+#include <asm-generic/bits/current.h>
=20
 extern int __psos_muxid;
=20
@@ -89,6 +90,8 @@ static void *psos_task_trampoline(void *
 	if (err)
 		goto fail;
=20
+	xeno_set_current();
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
@@ -173,14 +176,21 @@ u_long t_shadow(const char *name, /* Xen
 		u_long flags,
 		u_long *tid_r)
 {
+	int err;
+
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
=20
 	old_sigharden_handler =3D signal(SIGHARDEN, &psos_task_sigharden);
=20
-	return XENOMAI_SKINCALL5(__psos_muxid,
-				 __psos_t_create,
-				 name, prio, flags,
-				 tid_r, NULL);
+	err =3D XENOMAI_SKINCALL5(__psos_muxid,
+				__psos_t_create,
+				name, prio, flags,
+				tid_r, NULL);
+
+	if (!err)
+		xeno_set_current();
+
+	return err;
 }
=20
 u_long t_start(u_long tid,
Index: b/src/skins/uitron/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/src/skins/uitron/task.c
+++ b/src/skins/uitron/task.c
@@ -25,6 +25,7 @@
 #include <limits.h>
 #include <asm/xenomai/system.h>
 #include <uitron/uitron.h>
+#include <asm-generic/bits/current.h>
=20
 extern int __uitron_muxid;
=20
@@ -89,6 +90,8 @@ static void *uitron_task_trampoline(void
 	if (err)
 		goto fail;
=20
+	xeno_set_current();
+
 	/* iargs->pk_ctsk might not be valid anymore, after our parent
 	   was released from the completion sync, so do not
 	   dereference this pointer. */
@@ -150,7 +153,7 @@ ER cre_tsk(ID tskid, T_CTSK *pk_ctsk)
 ER shd_tsk(ID tskid, T_CTSK *pk_ctsk) /* Xenomai extension. */
 {
 	struct sched_param param;
-	int policy;
+	int policy, err;
 =09
 	/* Make sure the POSIX library caches the right priority. */
 	policy =3D uitron_task_set_posix_priority(pk_ctsk->itskpri, &param);
@@ -160,10 +163,15 @@ ER shd_tsk(ID tskid, T_CTSK *pk_ctsk) /*
=20
 	old_sigharden_handler =3D signal(SIGHARDEN, &uitron_task_sigharden);
=20
-	return XENOMAI_SKINCALL3(__uitron_muxid,
-				 __uitron_cre_tsk,
-				 tskid, pk_ctsk,
-				 NULL);
+	err =3D XENOMAI_SKINCALL3(__uitron_muxid,
+				__uitron_cre_tsk,
+				tskid, pk_ctsk,
+				NULL);
+
+	if (!err)
+		xeno_set_current();
+
+	return err;
 }
=20
 ER del_tsk(ID tskid)
Index: b/src/skins/vrtx/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/src/skins/vrtx/task.c
+++ b/src/skins/vrtx/task.c
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <vrtx/vrtx.h>
+#include <asm-generic/bits/current.h>
=20
 extern pthread_key_t __vrtx_tskey;
=20
@@ -106,6 +107,8 @@ static void *vrtx_task_trampoline(void *
 	if (err)
 		goto fail;
=20
+	xeno_set_current();
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
Index: b/src/skins/vxworks/taskLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/src/skins/vxworks/taskLib.c
+++ b/src/skins/vxworks/taskLib.c
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <vxworks/vxworks.h>
+#include <asm-generic/bits/current.h>
 #include "wrappers.h"
=20
 extern pthread_key_t __vxworks_tskey;
@@ -117,6 +118,8 @@ static void *wind_task_trampoline(void *
 	if (err)
 		goto fail;
=20
+	xeno_set_current();
+
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */

--------------000707060601060904080901--

--------------enig94B70FA7EC204536D9B7EBC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjWjXEACgkQniDOoMHTA+nX5wCfV1/KMPDycWEyiZ0bPkRN3i8o
Ow0Ani0qjeusv7Ola4C70JVELXo/aweR
=PhE7
-----END PGP SIGNATURE-----

--------------enig94B70FA7EC204536D9B7EBC4--

