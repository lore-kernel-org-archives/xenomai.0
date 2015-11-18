Date: Wed, 18 Nov 2015 14:52:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151118135249.GA24942@hermes.click-hack.org>
References: <trinity-3b905084-1366-4586-b761-0f15088b0d82-1447853696479@3capp-webde-bap53>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-3b905084-1366-4586-b761-0f15088b0d82-1447853696479@3capp-webde-bap53>
Subject: Re: [Xenomai] rtdm_clock_read overhead/accuracy question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JK.Behnke@web.de
Cc: xenomai@xenomai.org

On Wed, Nov 18, 2015 at 02:34:56PM +0100, JK.Behnke@web.de wrote:
>    Hello,
> 
>    I'm currently debugging a problem in my xenomai application.
>    In order ot get timing information I do the following inside the
>    read-handler of my rtdm driver.
> 
>    // --- start code snippet ---------------------------------
>    nanosecs_abs_t  t1, t2;
>    rtdm_lock_get_irqsave(&lockobj, lockctx);
> 
>    t1=rtdm_clock_read();
>    rtdm_task_busy_sleep(10000); // code block to be measured.
>    t2=rtdm_clock_read();
> 
>    rtdm_lock_put_irqrestore(&lockobj, lockctx);
>    // --- end code snippet ---------------------------------
> 
>    I observe the following time differences  t2-t1:
>    min=10176 ns,  max=10737 ns, avg=10314 ns
> 
>    This means in this case the average overhead of the two rtdm_clock_read
>    calls is
>    approximately 314 ns/2 = 157 ns.

No, this means that the average overhead of rtdm_clock_read is
314ns.

what you do is:
read time
convert to ns
busy sleep
read time
convert to ns

As you can see, between the two time reads, there is only one
conversion to nanoseconds, (which we assume is the bulk of the
overhead). And more generally, the overhead of the second time read
is not counted either.


> 
>    Is that realistic?

This seems to be a lot. The "tsc" test will measure the average
difference between two time reads, and the "arith" test will measure
the average time for a "multiply then shift" operation, adding the
two should give you an idea of the overhead. From what I recall,
reading the tsc on an atom N230 (a very old one) had an overhead
around 20ns.

>    Are there any other functions I might use to measure execution time of
>    an arbitrary code block?

You may want to use the tsc. The native skin has rt_timer_tsc and
rt_timer_tsc2ns. Since you are in kernel space, you may want to
use the I-pipe tsc read function, which should reduce even more the
overhead.

> 
>    I'm running xenomai 2.6.3 on linux kernel 3.8.13.
>    Hardware platform is Intel Atom E640 (1.0 GHz)

At 1GHz, you may even skip the rt_timer_tsc2ns ;-)

-- 
					    Gilles.
https://click-hack.org

