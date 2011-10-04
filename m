From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <CAGc_wL210UJCguth0cD-MOJFvzTqZXmoikQuaCE8Q5TJOWGg1w@domain.hid>
References: <CAGc_wL210UJCguth0cD-MOJFvzTqZXmoikQuaCE8Q5TJOWGg1w@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 Oct 2011 11:16:17 +0200
Message-ID: <1317719777.2082.41.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Using the analogy layer in kernel tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Delange <julien.delange@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Tue, 2011-10-04 at 04:48 -0400, Julien Delange wrote:
> Dear all,
> 
> I would like to know if somebody already tried to migrate code of
> user-space tasks that use the analogy layer to the kernel. As kernel
> tasks may run faster than user-space,

No, it won't run that faster, it might switch contexts faster between
threads, but that assumption is a fairly red herring now on most
architectures, especially on modern x86. The bottom line is that you
won't gain an order in magnitude in performance figures by moving to
kernel land. i.e. saving 200 ns to 40 us depending on your arch on
typical context switch time and maybe some more in avoiding
user/supervisor transitions won't fix your 1 ms jitter.

However, for sure you will lose the regular programming model, debugging
facilities, memory protection and so on. Moving your application code to
user space would also kill your upgrade path to Xenomai 3. The upcoming
architecture clearly pushes application code to userland, keeping kernel
land for RTDM drivers only. Running applications in kernel space is
_always_ a really bad idea, for multiple reasons.

To sum up, I would rather try to find out the cause of the ms-range
jittery, which is clearly pathological over a dual kernel system.
However, if your application can't cope with a few microseconds bounded
jitter introduced by userland, then maybe it's time reconsidering the
current option of running two kernels (linux and xenomai), which
permanently conflict on accessing physical resources (e.g. cache, CPU,
interrupt controller, buses), all on the same hardware. In that case,
maybe what one needs is a dedicated real-time hardware running a single
image RTOS, not a dual kernel system including a resource-hungry GPOS.

>  it might help to speed
> application execution. However, when trying to load the application, I
> encounter the following errors (see below). So, is the analogy layer
> designed to be used in kernel tasks ? If yes, which functions are
> allowed, which are forbidden (and in that case, it would be useful to
> disable functions in
> /lib/modules/KERNEL_VERSION/build/include/xenomai/analogy/ headers) ?
> 
> Thanks you for any comment/help regarding that topic,
> 
> Best regards,
> 
> 
> 
> [ 1560.700937] test_pcimio: Unknown symbol a4l_open (err 0)
> [ 1560.701100] test_pcimio: Unknown symbol __floatsidf (err 0)
> [ 1560.701634] test_pcimio: Unknown symbol __ltdf2 (err 0)
> [ 1560.701863] test_pcimio: Unknown symbol a4l_get_chinfo (err 0)
> [ 1560.702501] test_pcimio: Unknown symbol __fixdfsi (err 0)
> [ 1560.702625] test_pcimio: Unknown symbol a4l_fill_desc (err 0)
> [ 1560.702855] test_pcimio: Unknown symbol a4l_snd_insnlist (err 0)
> [ 1560.702977] test_pcimio: Unknown symbol a4l_rawtod (err 0)
> [ 1560.703099] test_pcimio: Unknown symbol a4l_get_rnginfo (err 0)
> [ 1560.703682] test_pcimio: Unknown symbol a4l_find_range (err 0)
> [ 1615.399804] test_pcimio: Unknown symbol a4l_open (err 0)
> [ 1615.399944] test_pcimio: Unknown symbol __floatsidf (err 0)
> [ 1615.400073] test_pcimio: Unknown symbol __ltdf2 (err 0)
> [ 1615.400288] test_pcimio: Unknown symbol a4l_get_chinfo (err 0)
> [ 1615.400288] test_pcimio: Unknown symbol __fixdfsi (err 0)
> [ 1615.400288] test_pcimio: Unknown symbol a4l_fill_desc (err 0)
> [ 1615.400786] test_pcimio: Unknown symbol a4l_snd_insnlist (err 0)
> [ 1615.400910] test_pcimio: Unknown symbol a4l_rawtod (err 0)
> [ 1615.401032] test_pcimio: Unknown symbol a4l_get_rnginfo (err 0)
> [ 1615.401173] test_pcimio: Unknown symbol a4l_find_range (err 0)
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



