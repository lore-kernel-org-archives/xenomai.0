Message-ID: <47274AF6.9090707@domain.hid>
Date: Tue, 30 Oct 2007 16:17:10 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB26C@rennsmail04.eu.thmulti.com>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB26C@rennsmail04.eu.thmulti.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.4-rc4: freeze with RTAI skin,
 fine with other skins
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> Philippe Gerum wrote:
> [...]
>> This rounding was missing too. We need the previous one for kernel
> local
>> heaps, and the one below to meet the stricter PAGE_SIZE constraint for
>> shareable heaps.
>>
>> --- ksrc/nucleus/heap.c	(revision 3095)
>> +++ ksrc/nucleus/heap.c	(working copy)
>> @@ -1103,7 +1103,7 @@
>> 	spl_t s;
>> 	int err;
>>
>> -	heapsize = PAGE_ALIGN(heapsize);
>> +	heapsize = xnheap_rounded_size(heapsize, PAGE_SIZE);
>> 	heapbase = __alloc_and_reserve_heap(heapsize, memflags);
>>
>> 	if (!heapbase)
> 
> Nope, still doesn't in -rc5  :-(
> Most probably because it should be at least _2_ times the page size.
>

Damnit. Half of the logic is indeed missing. Ok, will re-re-re-fix, ...
the fix.

> 
> The following patch missed the -rc5, can it please make it for -rc6?
> 

Yes. Thanks.

> --- ksrc/skins/rtai/task.c	29 Oct 2007 08:45:27 -0000	1.3
> +++ ksrc/skins/rtai/task.c	30 Oct 2007 15:04:08 -0000
> @@ -139,6 +139,9 @@
> 	task->body = body;
> 	task->sigfn = sigfn;
> 
> +	if (xnarch_cpus_empty(task->affinity))
> +		task->affinity = XNPOD_ALL_CPUS;
> +
> 	xnlock_get_irqsave(&nklock, s);
> 
> 	err = xnpod_start_thread(&task->thread_base, XNSUSP,    /*
> Suspend on startup. */
> 


-- 
Philippe.

