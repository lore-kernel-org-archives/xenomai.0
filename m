Date: Mon, 12 Feb 2018 20:05:36 +0100 (CET)
From: Yann le Chevoir <yann.le-chevoir@etu.esisar.grenoble-inp.fr>
Message-ID: <1534486954.7547732.1518462336571.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
In-Reply-To: <a7c1111b-390f-29b8-0ccc-2a7ab793d2e4@xenomai.org>
References: <224444700.6774706.1517845800904.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
 <a7c1111b-390f-29b8-0ccc-2a7ab793d2e4@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Isolation of CPU (isolcpus=1). Unexpected better
 performance when RT thread is on core0.
Reply-To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

> You should not have downgraded but rather pulled the latest code from
> the stable-3.0.x branch at git://git.xenomai.org/xenomai-3.git.
> As a general note, please disregard the release tarballs: our release
> cycle is way too slow to make them a sane option, as truckloads of bug
> fixes can pass before a new tarball is issued. Tracking the stable tree
> would get you the latest validated fixes.

Ok, I did not realize, I pulled the latest code from the repo, thanks.

> Any specifics regarding what went wrong would be more helpful.
> Otherwise, nobody may bother and a potential bug would stay.

About Xenomai 3.0.4 Alchemy skin which did not work, as I said,
I observed (September 2017) that when I used this skin in my code, the
system froze (I did not have any trace, any control on the serial console).
And when I launched /usr/xenomai/demo/altency, the problem was the same
(I had to reboot using the hard reset button).
Today, the demo/altency test runs well with the last stable version.
Perhaps I did something wrong when installing previous one.
I was a very beginner. I can try again with v3.0.4 if you ask.

>> For now, my point is that I observe some unexpected behaviors when
>> isolating cpu1 and perhaps you can explain some to me.
>> 
>> I am a bit disappointed by so execution-time variations.
>> How can we explain that?
> 
> A dual kernel system exhibits a permanent conflict between two kernels
> competing for the same hw resources. Considering CPU caches for
> instance, the cachelines a sleeping rt thread was previously using can
> be evicted by a non-rt thread resuming on the same CPU then treading on
> a large amount of physical memory. When the rt thread wakes up
> eventually, it may have to go through a series of cache misses to get
> the I/D caches hot again.

Yes, I understand very well.
That is why I expected that when the RT thread is on the isolated CPU,
it will perform better than when it is on the non-isolated one.
Have you well understood my point that I have a better behavior when the
RT thread is on the same CPU as Linux (cpu0) rather than when it is on
the isolated one (cpu1)?
I had the feeling it would be the contrary, and your explanation comforts
me in this direction.

> This issue may be aggravated by hw specifics: your imx6d is likely
> fitted with a PL3xx outer L2 cache, for which the write-allocate policy
> is enabled by the kernel. That policy proved to be responsible for ugly
> latency figures with this cache controller. Can we disable such policy?
> Maybe, it depends; we used to have some success doing just that with
> early imx6 hw, then keeping it enabled became a requirement later with
> more recent SoCs (e.g. imx6qp) as we noticed that such policy was
> involved in cache coherence in multi-core configs. So YMMV.

Interesting.

> If you want to give WA disabling a try, just pass l2x0_write_allocate=0
> to the kernel cmdline. If your SoC ends up not booting with that switch,
> or dies in mysterious and random ways during runtime, well, this it is
> likely the sign that a cache coherence issue is biting and you can't
> hack away with that one.

I did. The SoC boots and there is no improvement.
I do not really know how to check if this parameter is well considered...

> You may also need to tell Xenomai that only CPU1 should process rt
> workloads (i.e. xenomai.supported_cpus=2). I suspect that serialization
> on a core Xenomai lock from all CPUs where the local TWDs tick
> introduces some jitter. Restricting the set of rt CPUs to CPU1 would
> prevent Xenomai from handling rt timer events on any other CPU, lifting
> any contention of that lock in the same move.

Very interesting idea. That is what I want. But my SoC does not boot with
this cmdline... Even when there is no cpu-isolation.

When cmdline is "isolcpus=1 xenomai.supported_cpus=2" or just
"xenomai.supported_cpus=2", boot hangs just after "Starting kernel ..."

Any idea why? Even if it is not what I want, I tried with
"isolcpus=1 xenomai.supported_cpus=1" cmdline too.
It boots and I can run the smokey/cpu_affinity test:

$ ./smokey --run=cpu_affinity --verbose=100
     .. CPU0 is available
     .. CPU1 is online, non-RT
     .. control thread binding to non-RT CPU1
     .. starting user thread
     .... user thread starts on CPU0, ok
     .. RTDM test module not available, skipping
     cpu_affinity OK

Of course, I am interested in having the contrary
(CPU0 is online, non-RT / CPU1 is available).
Any idea why I can not do it with cpu1?

Note: "isolcpus=0 xenomai.supported_cpus=1" also hangs the starting...

I wonder if there are some hardware limitations. Is it possible that only
cpu0 sees the clock? See my last question below.



Indeed, I continued some investigations and found other surprising stuff:

Let me call the graphs from previous message the "beautiful one"
and the "non-beautiful one".
For now, my point is always on the execution time of the thread.

Beautiful graph     = Min execution time is 32us /
                      Max execution time is 65us.
Non-beautiful graph = Min execution time is 32us /
                      Max execution time is 82us
                      (max goes up to 100us on other tests).

My previous message was with these observations:
isolcpus=1, so Linux is on core0, I stress the Linux with dohell script
When the 4000Hz thread is on core0 too ==> beautiful graph
When the 4000Hz thread is the only one on cpu1 ==> non-beautiful graph


Now, I tried other permutations, and I can not explain:
isolcpus=1, so Linux is on core0, I stress the Linux with dohell script
I bind the 4000Hz thread on cpu1 (I am confident that it is its good place).
   - When I create a new 4000Hz thread on cpu0,
     which does the same amount of stuff as the other one
     ==> beautiful graph (for the cpu1 thread execution time)
   - When I create a new 4000Hz thread on cpu0,
     which does nothing
     ==> non-beautiful graph (for the cpu1 thread execution time)
   - When I create a 2000Hz thread (<4000Hz) on cpu0,
     which does the same amount of stuff as the other one
     ==> non-beautiful graph (for the cpu1 thread execution time)
   - When I create a 5000Hz thread (>4000Hz) on cpu0,
     which does the same amount of stuff as the other one
     ==> beautiful graph (for the cpu1 thread execution time)

Given these observations I wonder if the scheduler or the clock tick are
bound to cpu0.
And if they play a role in the responsiveness of the system.
By the way, it could explain why xenomai.supported_cpus=2 cmdline does
not work, no?

Is it possible to migrate the clock tick interrupt to cpu1?
Is it what you did in your 2015 patch?
https://xenomai.org/pipermail/xenomai-git/2015-December/006009.html



Regards,

Yann

