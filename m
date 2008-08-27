Message-ID: <48B50BD5.9060500@domain.hid>
Date: Wed, 27 Aug 2008 10:09:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48B3FD37.4060701@domain.hid>	<dcca602eeac0de54e5e7095d60c77710@domain.hid>
	<48B41527.70507@domain.hid>
In-Reply-To: <48B41527.70507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with tcb.handle and taskDesc.td_tid
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Matthieu wrote:
>> On Tue, 26 Aug 2008 14:55:19 +0200, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Matthieu wrote:
>>>>> Hi
>>>>>
>>>>> I would like to understand the coherence between the task identifier of
>>> the
>>>>> task control block and the task id given by taskDesk (function
>>>>> taskInfoGet()). In fact, I init a task with taskInit, I get the tid
>>> using
>>>>> tid=tcb.handle. The use of taskInfoGet(tid, taskDesc) gives me a
>>>>> taskDesk.td_tid different from the tid.
>>>>>
>>>>> I want to test if the task is suspended using taskIsSuspended(tid) or
>>>>> taskIsSuspended(taskDesc.td_tid), but both get me  a 3d0001 errno (code
>>>>> error of WIND_OBJ_ERR_BASE S_objLib_OBJ_ID_ERROR). The PID given by
>>>>> /proc/xenomai/stat also has no connection. Idem with a ps -AfL
>>>>>
>>>>> Thank you in advance for your explanations
>>>> You are not supposed to use the internal fields of the structures. A
>>>> valid id is one returned by the taskIdSelf(), taskNameToId(),
>>>> taskIdDefault(). I can not find a service which returns the task Id for
>>>> a given TCB. Is it what you are looking for ?
>>> By the way, if you could call taskInfoGet, you already have a valid task
>>> id...
>>>
>> But using taskNameToId, taskSuspend(tid) makes the same error and so is
>> taskInfoGet().
> 
> Ok. So, we have a bug and these functions do not work as expected.
>

Kernel to userland id. translation was missing for the taskNameToId() wrapper.

Index: include/vxworks/vxworks.h
===================================================================
--- include/vxworks/vxworks.h	(revision 4121)
+++ include/vxworks/vxworks.h	(working copy)
@@ -232,6 +232,8 @@

 typedef void (*wind_tick_handler_t)(long);

+xnhandle_t taskNameToHandle(const char *name);
+
 #ifdef errno
 #undef errno
 #endif
Index: ksrc/skins/vxworks/syscall.c
===================================================================
--- ksrc/skins/vxworks/syscall.c	(revision 4121)
+++ ksrc/skins/vxworks/syscall.c	(working copy)
@@ -411,7 +411,7 @@
 {
 	char name[XNOBJECT_NAME_LEN];
 	WIND_TCB_PLACEHOLDER ph;
-	TASK_ID task_id;
+	xnhandle_t handle;

 	if (!__xn_access_ok
 	    (curr, VERIFY_WRITE, __xn_reg_arg2(regs), sizeof(ph)))
@@ -429,12 +429,11 @@
 			       sizeof(name) - 1);
 	name[sizeof(name) - 1] = '\0';

-	task_id = taskNameToId(name);
-
-	if (task_id == ERROR)
+	handle = taskNameToHandle(name);
+	if (handle == XN_NO_HANDLE)
 		return wind_errnoget();

-	ph.handle = task_id;	/* Copy back the task handle. */
+	ph.handle = handle; /* Copy back the task handle. */

 	__xn_copy_to_user(curr, (void __user *)__xn_reg_arg2(regs), &ph,
 			  sizeof(ph));
Index: ksrc/skins/vxworks/taskLib.c
===================================================================
--- ksrc/skins/vxworks/taskLib.c	(revision 4121)
+++ ksrc/skins/vxworks/taskLib.c	(working copy)
@@ -551,9 +551,9 @@
    wind_tasks_q */
 TASK_ID taskNameToId(const char *name)
 {
+	TASK_ID result = (TASK_ID)ERROR;
 	xnholder_t *holder;
 	wind_task_t *task;
-	int result = ERROR;
 	spl_t s;

 	if (!name)
@@ -578,6 +578,28 @@
 	return result;
 }

+xnhandle_t taskNameToHandle(const char *name)
+{
+	xnhandle_t handle;
+	wind_task_t *task;
+	TASK_ID task_id;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	task_id = taskNameToId(name);
+	if (task_id == ERROR) {
+		handle = XN_NO_HANDLE;
+		goto out;
+	}
+	task = (wind_task_t *)task_id;
+	handle = xnthread_handle(&task->threadbase);
+out:
+	xnlock_put_irqrestore(&nklock, s);
+
+	return handle;
+}
+
 /* nklock must be locked on entry, interrupts off */
 static int testSafe(wind_task_t *task)
 {

-- 
Philippe.

