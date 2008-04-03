Message-ID: <47F50503.5000200@domain.hid>
Date: Thu, 03 Apr 2008 18:25:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>	<d6c8ef150804030300p3a4c719tca9903aa7663a5d9@domain.hid>	<2ff1a98a0804030642i79cf9d98uce4034295d3e2d4d@domain.hid>
	<7289437c0804030734g7c2fea2h9ba93c1e89e8b699@domain.hid>
In-Reply-To: <7289437c0804030734g7c2fea2h9ba93c1e89e8b699@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Question about rtdm_mmap_to_user()
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Perrine Martignoni wrote:
>>Mixing up RTDM and native API usage, though technically feasible, isn't
> a good idea anyway. Better have a look at Hannes' example, >and if that
> one or your own version still doesn't work, post more details (Xenomai
> version, target architecture, test code, etc.).
> 
> I found an example in Native-API-Tour.pdf which do this. I try to follow
> it and it doesn't work.
>

Except that the example listed in the document in question takes care of
defining the heap descriptor in global memory, not in the init_module() stack.

> static int dmem_Init(void)
> {   
>         RT_HEAP Heap;

^^^^ this won't survive long enough.

>         int ret =0;
>         void *p_HeapMem = NULL;
> ----------------------------------------------------------------------------------------------------------------------------------
> 
> I see in /proc/xenomai/registry/native/heaps the /HeapTest  /I create.
> And I see that :
> 
> * type=kernel:size=3017801728:used=1
>

i.e. we see a 2.8+ _gigabyte_ heap from which 1 single byte would be in use...,
albeit you defined a 2Kb heap initially, to be used as a single contiguous
segment. Getting braindamage values like this when looking at the /proc
interface should ring a bell about a possible corruption of some important
kernel-based information, like a heap descriptor.

-- 
Philippe.

