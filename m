Message-ID: <442D3AC8.3080806@domain.hid>
Date: Fri, 31 Mar 2006 16:20:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_delete() question
References: <442C19F2.206@domain.hid> <442D02CD.6080508@domain.hid>
In-Reply-To: <442D02CD.6080508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Sean McGranaghan wrote:
> 
>> Hello all,
>>
>> I am posting this for a co-worker who is having problems with killing 
>> a real-time task. (He is joining the email list shortly but for now I 
>> will pass responses on to him.) Here is the scenario:
>>
>> 1. A Linux process starts up and detaches from the tty (daemon)
>> 2. The daemon creates a xeno message queue
>> 2. The daemon spawns a xeno task
>> 3. The xeno task on startup binds to the queue rt_queue_bind()
>> 4. The xeno task waits on the queue recv with infinite timeout
>> 5. The daemon process goes to sleep in a join, waiting for the task to 
>> exit
>> 6. Some time later another program starts
>> 7. The other non-realtime program looks up the xeno task name via 
>> rt_task_bind()
>> 8. The other non-realtime program attempts to delete the task via 
>> rt_task_delete()
>>         Failed Attempt #1 - Non-realtime program calls 
>> rt_task_delete() and gets
>>                             a segmentation fault
>>         Failed Attempt #2 - Non-realtime program spawns a realtime 
>> task which
>>                             binds to original task and tries 
>> rt_task_delete().
>>                             Also gets segmentation fault.
>>
> 
> Eeek... 100% reproducible here. Blatant bug. More later. Thanks for 
> reporting.
> 
>> The was attempted one a system running the latest Xenomai 2.1 release.
>>
>> What is the preferred method to start/join threads from a non-realtime 
>> context?
>>
>> Any help is appreciated.
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
> 
> 
>

Fixed in the trunk/ and 2.1 maintenance branches (commits #827 and #828).
The attached patch should apply properly on 2.1.0 with only a few hunks.

Index: src/skins/native/task.c
===================================================================
--- src/skins/native/task.c	(revision 822)
+++ src/skins/native/task.c	(working copy)
@@ -212,7 +212,7 @@
  {
      int err;

-    if (task) {
+    if (task && task->opaque2) {
  	err = pthread_cancel((pthread_t)task->opaque2);
  	if (err)
  	    return -err;
@@ -349,6 +349,9 @@

  int rt_task_join (RT_TASK *task)
  {
+    if (!task->opaque2)
+	return -ESRCH;
+
      return -pthread_join((pthread_t)task->opaque2, NULL);
  }

Index: ksrc/skins/native/syscall.c
===================================================================
--- ksrc/skins/native/syscall.c	(revision 822)
+++ ksrc/skins/native/syscall.c	(working copy)
@@ -207,7 +207,12 @@
      err = __rt_bind_helper(curr,regs,&ph.opaque,XENO_TASK_MAGIC,NULL);

      if (!err)
+	{
+	/* We just don't know the associated user-space pthread
+	   identifier -- clear it to prevent misuse. */
+	ph.opaque2 = 0;
  	__xn_copy_to_user(curr,(void __user *)__xn_reg_arg1(regs),&ph,sizeof(ph));
+	}

      return err;
  }
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 822)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -327,7 +327,14 @@

  	    case LO_SIGNAL_REQ:

-		send_sig(rq->req[reqnum].arg,p,1);
+		/* Special case: SIGKILL should always be sent to the
+		   entire thread group. */
+
+		if (rq->req[reqnum].arg == SIGKILL)
+		    kill_proc(p->pid,SIGKILL,1);
+		else
+		    send_sig(rq->req[reqnum].arg,p,1);
+
  		break;
  	    }
  	}
@@ -790,7 +797,7 @@
  	xnpod_fatal("xnshadow_unmap() called from invalid context");
  #endif /* CONFIG_XENO_OPT_DEBUG */

-    p = xnthread_archtcb(thread)->user_task;
+    p = xnthread_archtcb(thread)->user_task; /* May be != current */

      magic = xnthread_get_magic(thread);

@@ -819,11 +826,11 @@
      if (p->state != TASK_RUNNING)
  	{
  	/* If the shadow is being unmapped in primary mode or blocked
-	   in secondary mode, the associated Linux task should also
-	   die. In the former case, the zombie Linux side returning to
-	   user-space will be trapped and exited inside the pod's
-	   rescheduling routines. */
-	schedule_linux_call(LO_WAKEUP_REQ,p,0);
+	   in secondary mode, the entire thread group associated with
+	   the mapped task should also die. In the former case, the
+	   zombie Linux side returning to user-space will be trapped
+	   and exited inside the pod's rescheduling routines. */
+	schedule_linux_call(LO_SIGNAL_REQ,p,SIGKILL);
  	return;
  	}

-- 

Philippe.

