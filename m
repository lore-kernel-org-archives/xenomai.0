Message-ID: <518A06C9.50204@mitrol.it>
Date: Wed, 08 May 2013 10:03:21 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it> <51830D98.7090309@xenomai.org>
	<5183CDD6.80400@mitrol.it>
In-Reply-To: <5183CDD6.80400@mitrol.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Gilles,
I have added a check in

file          :   xenomai-2.5.6/ksrc/skins/native/task.c
function      :   int rt_task_delete(RT_TASK *task)

See my code signed with =======>

It seems if I'm working with a gdb session, the rt_task_delete() keep 
the lock of the killed thread.
With my additional check, all seems ok.

I could also insert my check directly in xnpod_delete_thread().

What do you think about ?
Paolo



// 
********************************************************************************
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
// 
********************************************************************************


