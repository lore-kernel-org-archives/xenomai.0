Message-ID: <518A6195.7030206@mitrol.it>
Date: Wed, 08 May 2013 16:30:45 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it>
	<51830D98.7090309@xenomai.org>	<5183CDD6.80400@mitrol.it>
	<518A06C9.50204@mitrol.it> <518A4C09.8030906@xenomai.org>
	<518A505C.2090207@mitrol.it> <518A52A7.5000801@xenomai.org>
	<518A5600.20508@mitrol.it>
In-Reply-To: <518A5600.20508@mitrol.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Re : Sporadic problem : rt_task_sleep locked after
 debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I think to be very near to the solution of this problem.
Thanks to Gilles for his patience.

Now I will retry to make a summary of the problem.

********************
**** MY PROBLEM ****
********************
I have an user space xenomai application.
It works fine. If I try to debug it with gdb, sometimes, in some points,
xenomai stops to works. All xenomai threads are like stopped.
In my case they are stopped in rt_task_sleep() or other wait operations.
Linux instead continues to work normally.
To make xenomai usable and working I have to reset the processor.
I have no other way.


**************************
**** SOLUTION / PATCH ****
**************************
file          :   xenomai-2.5.6/ksrc/skins/native/task.c
function      :   int rt_task_delete(RT_TASK *task)

See my code signed with =======>

int rt_task_delete(RT_TASK *task)
{
         int err = 0;
         spl_t s;

         if (!task) {
                 if (!xnpod_primary_p())
                         return -EPERM;

                 task = xeno_current_task();
         } else if (xnpod_asynch_p())
                 return -EPERM;

         xnlock_get_irqsave(&nklock, s);

         task = xeno_h2obj_validate(task, XENO_TASK_MAGIC, RT_TASK);

         if (!task) {
                 err = xeno_handle_error(task, XENO_TASK_MAGIC, RT_TASK);
                 goto unlock_and_exit;
         }

         /* Make sure the target task is out of any safe section. */
         err = __native_task_safewait(task);

         if (err)
                 goto unlock_and_exit;

         =========> if (xnthread_test_state(&task->thread_base, XNDEBUG))
         =========> {
         =========>     unlock_timers();
         =========> }


         /* Does not return if task is current. */
         xnpod_delete_thread(&task->thread_base);

       unlock_and_exit:

         xnlock_put_irqrestore(&nklock, s);

         return err;
}

As you can see, my patch unlock timers if the xenomai thread is killed.


***************************
**** DETAILS OF MY BUG ****
***************************
I have a xenomai application with 70 real-time threads.
Suppose that thread 1 deletes thread 70 with rt_task_delete().
This is my case.

I put a breakpoint and run my xenomai application.
When my breakpoint is reached gdb stops all my xenomai threads.

If I press "c" to continue, gdb restarts my application,
that is every thread, one by one (thread 1, thread 2, thread 3,
.... , thread 70).

If I press "c" on gdb, the following scenario could happens :

1) gdb start thread 1
2) thread 1 starts immediately
3)   thread 1 delete thread 70 by rt_task_delete()
...
4) gdb start thread 2
5) gdb start thread 3
6) gdb start thread 4
7) gdb start thread 5
8) gdb start thread 6
...
.) gdb start thread 68
.) gdb start thread 69
.) gdb start thread 70

The thread 1 finds thread 70 in debug mode !

My patch adjust this problem.

I realize that it is a very special case, but it is my case.

I'd like to know if the patch is valid or can be written in a different way.
For example, I could insert my patch directly in xnpod_delete_thread().

The function unlock_timers() cannot be called from 
xenomai-2.5.6/ksrc/skins/native/task.c
because it is defined static. This is a detail. There are simple ways to 
solve this.

Thanks in advance,
Paolo Minazzi


