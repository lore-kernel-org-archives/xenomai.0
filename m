Message-ID: <52EF7772.2000008@xenomai.org>
Date: Mon, 03 Feb 2014 12:03:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1391373420.28930.YahooMailNeo@web171604.mail.ir2.yahoo.com>
In-Reply-To: <1391373420.28930.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] race condition when creating and deleting VxWorks
 tasks in xenomai-forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/02/2014 09:37 PM, Matthias Schneider wrote:
> Hi all, there seems to be a race condition in the VxWorks skin in xenomai-forge
> when creating and deleting tasks in rapid succession. The problem seems to be the
> adding and removing of tasks to wind_task_list in task_trampoline() and
> task_finalizer().
> 
> When creating a task, before returning a handle to the created task to the
> application, calling threadobj_start() from taskActivate() will wait for
> &thobj->barrier by calling wait_on_barrier(). This condition is triggered from
> the newly created task via task_trampoline() calling threadobj_prologue().
> Having unblocked taskActivate(), the creating task/thread will return to the
> calling application, which in turn can delete the task in quick succession.
> Deleting the task will trigger the execution of task_finalizer, which will try
> to remove the task from wind_task_table. However, due to specific timing
> situations, it may be possible  that the started task has not yet added itself
> to the list (it may still be "just" leaving threadobj_prologue()), leading to
> a segmentation fault. This behavior can be easily reproduced by adding a delay
> in task_trampoline() at the following location in taskLib.c:
> 
> ret = __bt(threadobj_prologue(&task->thobj, task->name));
> 
> usleep(100000);
> 
> write_lock_nocancel(&wind_task_lock);
> pvlist_append(&task->next, &wind_task_list);
> write_unlock(&wind_task_lock);
> 
> 
> writing a simple test application that simply calls
> 
> SEM_ID tid = taskSpawn(name, 50, 0, 0, task, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
> taskDelete(tid);
> 
> will then reliably demonstrate the issue.
> 
> Moving the last three lines appending the task to the list above threadobj_prologue()
> seems to fix the issue, although I am not 100% sure about possible side effects.
> 
> Thanks in advance for commenting my issue,
> regards,
> 

All correct, the bug bites as described. As you suspected, simply swapping the statements would introduce another race. Could you try this patch instead? TIA,

diff --git a/lib/vxworks/taskLib.c b/lib/vxworks/taskLib.c
index 1ef52a5..e3457a3 100644
--- a/lib/vxworks/taskLib.c
+++ b/lib/vxworks/taskLib.c
@@ -151,9 +151,11 @@ static void task_finalizer(struct threadobj *thobj)
 {
 	struct wind_task *task = container_of(thobj, struct wind_task, thobj);
 
-	write_lock_nocancel(&wind_task_lock);
-	pvlist_remove(&task->next);
-	write_unlock(&wind_task_lock);
+	if (pvholder_linked(&task->next)) {
+		write_lock_nocancel(&wind_task_lock);
+		pvlist_remove(&task->next);
+		write_unlock(&wind_task_lock);
+	}
 
 	task->tcb->status |= WIND_DEAD;
 	cluster_delobj(&wind_task_table, &task->cobj);
@@ -356,6 +358,7 @@ static STATUS __taskInit(struct wind_task *task,
 	idata.finalizer = task_finalizer;
 	idata.priority = cprio;
 	threadobj_init(&task->thobj, &idata);
+	initpvh(&task->next);
 
 	ret = __bt(cluster_addobj(&wind_task_table, task->name, &task->cobj));
 	if (ret) {


-- 
Philippe.

