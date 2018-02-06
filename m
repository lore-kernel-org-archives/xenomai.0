References: <224444700.6774706.1517845800904.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a7c1111b-390f-29b8-0ccc-2a7ab793d2e4@xenomai.org>
Date: Tue, 6 Feb 2018 18:20:57 +0100
MIME-Version: 1.0
In-Reply-To: <224444700.6774706.1517845800904.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Isolation of CPU (isolcpus=1). Unexpected better
 performance when RT thread is on core0.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>, xenomai@xenomai.org

On 02/05/2018 04:50 PM, Yann le Chevoir wrote:
> Hello,
> 
> I am an engineering student and I try to proof that a 4000Hz hard real-time
> application can run on an ARM board rather than on a more powerful machine.
> 
> I work with an IMX6 dual-core and Xenomai Cobalt 3.0.4. I use POSIX skin.
> By the way, I first installed Xenomai Cobalt 3.0.5 but first
> experimentations revealed that Alchemy API did not work properly (for
> example, altency test did not work).

Any specifics regarding what went wrong would be more helpful. 
Otherwise, nobody may bother and a potential bug would stay.

  I needed more investigations but when
> I tried previous version, it worked. I did not test v3.0.6.
> 

You should not have downgraded but rather pulled the latest code from 
the stable-3.0.x branch at git://git.xenomai.org/xenomai-3.git.
As a general note, please disregard the release tarballs: our release 
cycle is way too slow to make them a sane option, as truckloads of bug 
fixes can pass before a new tarball is issued. Tracking the stable tree 
would get you the latest validated fixes.

> For now, my point is that I observe some unexpected behaviors when
> isolating cpu1 and perhaps you can explain some to me.
> 
> 
> TID 881 is the main.
> I am not sure why there is the TID 890 thread. Is it a Xenomai one (main)?

libcobalt's internal printer loop thread for carrying out deferred 
printf() calls. Ancillary stuff.

> Min execution time is 32us.
> Max execution time is 82us.
> I am a bit disappointed by so execution-time variations.
> How can we explain that?
>

A dual kernel system exhibits a permanent conflict between two kernels 
competing for the same hw resources. Considering CPU caches for 
instance, the cachelines a sleeping rt thread was previously using can 
be evicted by a non-rt thread resuming on the same CPU then treading on 
a large amount of physical memory. When the rt thread wakes up 
eventually, it may have to go through a series of cache misses to get 
the I/D caches hot again.

Generally speaking, we have a GPOS running side by side a RTOS on the 
same hardware, and the former does not care a dime about the 
requirements of the latter. Mitigating the adverse effects of such 
situation in order to keep latency low and bounded is the basic task 
defining the Xenomai project.

This issue may be aggravated by hw specifics: your imx6d is likely 
fitted with a PL3xx outer L2 cache, for which the write-allocate policy 
is enabled by the kernel. That policy proved to be responsible for ugly 
latency figures with this cache controller. Can we disable such policy? 
Maybe, it depends; we used to have some success doing just that with 
early imx6 hw, then keeping it enabled became a requirement later with 
more recent SoCs (e.g. imx6qp) as we noticed that such policy was 
involved in cache coherence in multi-core configs. So YMMV.

If you want to give WA disabling a try, just pass l2x0_write_allocate=0 
to the kernel cmdline. If your SoC ends up not booting with that switch, 
or dies in mysterious and random ways during runtime, well, this it is 
likely the sign that a cache coherence issue is biting and you can't 
hack away with that one.

> 
> Then, trying permutations to understand these variations, I decided to put
> thread1 on CPU0. Linux, main, thread0 and dohell continue doing their stuff.
> Note that there is again the isolcpus=1 argument, so nothing is on CPU1.
> I am surprised to have a better execution time statistics. Is it a known
> situation and how can we explain that? See "Core0.png".
> 
> Reminder of the configuration when plotting "Core0.png":
> Core0: Linux stressed + main + thread0 + thread1
> Core1: -
> 
> Min execution time is 32us.
> Max execution time is 65us.
> 
> 
> Then, given these results, as I had the feeling that a mono-core processor
> performs better that a dual-core one, I tried to delete the isolcpus=1
> argument to proof the contrary.
> 
> Here is the configuration when plotting "NoIsolation.png":
> Core0: Linux stressed + main + thread0
> Core1: Linux stressed + thread1
> 
> As you can see, the graph looks like the first one, but execution time
> is even worse at 94us.
> 
> Is there something I do wrong?

You may also need to tell Xenomai that only CPU1 should process rt 
workloads (i.e. xenomai.supported_cpus=2). I suspect that serialization 
on a core Xenomai lock from all CPUs where the local TWDs tick 
introduces some jitter. Restricting the set of rt CPUs to CPU1 would 
prevent Xenomai from handling rt timer events on any other CPU, lifting 
any contention of that lock in the same move.

-- 
Philippe.

