Date: Tue, 4 Nov 2014 11:41:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141104104152.GH13057@sisyphus.hd.free.fr>
References: <5458ABC7.2080201@ixblue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5458ABC7.2080201@ixblue.com>
Subject: Re: [Xenomai] Round robin scheduling seem not working in a specific
 case...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christophe Carton <christophe.carton@ixblue.com>
Cc: xenomai@xenomai.org

On Tue, Nov 04, 2014 at 11:34:47AM +0100, Christophe Carton wrote:
> Hello,
> 
> I am currently working with Xenomai 2.6.4 with native skin and with
> a Linux kernel 3.14.17.
> The linux and the xenomai have been taken from the following Git
> repositories :
> * http://git.xenomai.org/xenomai-2.6.git - tag v2.6.4
> * http://git.xenomai.org/ipipe.git - tag ipipe-core-3.14.17-x86-4
> 
> I am encountering a problem to enable the Round Robin scheduler in a
> specific case :
> * Two tasks ("rr task 1" and "rr task 2") of priority 10 are
> launched by a task ("init task") of priority 90.
> * All 3 of them are configured with a RR scheduler via
> "rt_task_slice" API before they are started.
> In this case the FIFO scheduling seems to be applied (could be seen
> via rt_printf logs).
> 
> I have found a thread on the mailing list that gives an example
> demonstrating the good behavior of the RR scheduler.
> http://www.xenomai.org/pipermail/xenomai/2011-November/024897.html
> http://www.xenomai.org/pipermail/xenomai/2011-November/024899.html
> This example implies that the tasks are locked via a semaphore at
> startup and that this semaphore is unlocked by the main when all
> threads have been started.
> This is necessary in this case due to the fact that the main
> function is no an RT task.
> 
> This implementation (with the semaphore) applied to my test works.
> Why is the semaphore needed in my case?
> The 2 RT lower priority ("rr task 1" and "rr task 2") runs when my
> high priority task ("init task") is waiting on the "rt_task_join".
> They are are so launched at the "same time" with a RR scheduling.
> But the FIFO scheduling seems to be taken into account when I look
> at the logs...
> Were am I wrong?
> 
> You could find attached my source code.

Are you running on an uniprocessor system or multiprocessor system?

-- 
					    Gilles.

