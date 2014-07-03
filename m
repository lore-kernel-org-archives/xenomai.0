Message-ID: <53B57361.1000603@xenomai.org>
Date: Thu, 03 Jul 2014 17:14:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKc2Hpb0S50P=9iWvw3z9NexHmyZEjuAU=7SGyT77EPpub_D2A@mail.gmail.com>
In-Reply-To: <CAKc2Hpb0S50P=9iWvw3z9NexHmyZEjuAU=7SGyT77EPpub_D2A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: Deadlock in finalize_thread()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/03/2014 10:11 AM, Kim De Mey wrote:

> What I think that goes wrong is that the lock which is taken in
> threadobj_notify_entry() is not released before threadobj_start()
> continues at wait_on_barrier(thobj, __THREAD_S_ACTIVE).

Until threadobj_notify_entry() releases that lock, there is no way 
wait_on_barrier() can exit, since it competes for the same lock. 
pthread_cond_wait() will grab this lock before returning.

As there is a
> t_delete() done right after t_start() returns in my test case, this
> could mean that the thread gets in finalize_thread() after the
> pthread_cancel() and blocks there on the threadobj_lock() as the
> threadobj_unlock() from threadobj_notify_entry() was possibly not yet
> called.

called? do you mean exited instead?

Until wait_on_barrier() unwinds for the child task, theadobj_start() 
cannot complete for its parent, so the latter cannot delete the child it 
has just spawned, until the latter has dropped the lock from 
threadobj_notify_entry(). So I'm unsure the explanation stands - unless 
I missed your point entirely.

This said, there must be something fishy as the backtrace clearly shows 
a child thread hanging in the finalizer, waiting for access to its own tcb.

If you have a simple standalone test case illustrating this bug, please 
send it along, this would save me some precious time trying to reproduce 
the issue accurately. Otherwise I'll write one.

PS: mentioning the exact Xenomai 3 version you are running would always 
help. Passing --version on the command line of any application built 
over the copperplate-based APIs returns this information.

-- 
Philippe.

