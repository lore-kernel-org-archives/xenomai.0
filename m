Message-ID: <491D48A8.20303@domain.hid>
Date: Fri, 14 Nov 2008 10:45:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <491805AE.1060809@domain.hid> <491C6ED8.6030903@domain.hid>
	<491C8AE3.5080109@domain.hid> <491D3554.2080207@domain.hid>
	<491D4910.6030707@domain.hid>
In-Reply-To: <491D4910.6030707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mode switch when using RT heap on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Grandegger wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Wolfgang Grandegger wrote:
>>>>> Hello,
>>>>>
>>>>> I realized that accessing memory allocated with rt_heap_alloc() causes
>>>>> mode switches on ARM i.mx31. The attached patch provides a demo program
>>>>> to demonstrate the problem, which actually does *not* show up on my
>>>>> PowerPC TQM5200 board.
>>>> Index: xenomai-2.4.x/examples/native/rtheap.c
>>>> ===================================================================
>>>> --- /dev/null
>>>> +++ xenomai-2.4.x/examples/native/rtheap.c
>>>> @@ -0,0 +1,164 @@
>>>> +#include <stdio.h>
>>>> +#include <signal.h>
>>>> +#include <unistd.h>
>>>> +#include <sys/mman.h>
>>>> +
>>>> +#include <native/task.h>
>>>> +#include <native/timer.h>
>>>> +#include <native/heap.h>
>>>> +
>>>> +#define USE_HEAP
>>>> +//#define USE_SIGXCPU
>>>> +
>>>> +#define HEAP_SIZE (1024*1024)
>>>> +#define HEAP_MODE 0		/* Local heap. */
>>>> +
>>>> +RT_HEAP heap_desc;
>>>> +RT_TASK demo_task;
>>>> +
>>>> +
>>>> +static int block_sizes[] = {16, 20, 90, 150, 310, 800, 1000};
>>>> +
>>>> +/* NOTE: error handling omitted. */
>>>> +
>>>> +void demo(void *arg)
>>>> +{
>>>> +	RTIME now, previous;
>>>> +	void *block;
>>>> +	int sizes = sizeof(block_sizes) / sizeof(int);
>>>> +	int count = 0;
>>>> +	int size, err;
>>>> +	int *ptr;
>>>> +
>>>> +#ifdef USE_SIGXCPU
>>>> +	/* Ask Xenomai to warn us upon switches to secondary mode. */
>>>> +	rt_task_set_mode(0, T_WARNSW, NULL);
>>>> +#endif
>>>> +
>>>> +	/*
>>>> +	 * Arguments: &task (NULL=self),
>>>> +	 *            start time,
>>>> +	 *            period (here: 1 s)
>>>> +	 */
>>>> +	rt_task_set_periodic(NULL, TM_NOW, 10000000);
>>>> +	previous = rt_timer_read();
>>>> +
>>>> +	while (1) {
>>>> +		rt_task_wait_period(NULL);
>>>> +		now = rt_timer_read();
>>>> +
>>>> +		size = block_sizes[count % sizes];
>>>> +#ifdef USE_HEAP
>>>> +		/*
>>>> +		 * Request a 16-bytes block, asking for a non-blocking call
>>>> +		 * since only Xenomai tasks may block.
>>>> +		 */
>>>> +		err = rt_heap_alloc(&heap_desc, size, TM_NONBLOCK, &block);
>>>> +		if (err) {
>>>> +			printf("rt_heap_alloc() failed with %d\n", err);
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		ptr = (int *)block;
>>>> +		*ptr = 0xdeadbeef;
>>>> +		if (*ptr != 0xdeadbeef) {
>>>> +			printf("Write/read test to heap failed\n");
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		ptr = (int *)(block + size - sizeof(int));
>>>>
>>>> This is not guaranteed to be aligned on an int. Could you try:
>>>>
>>>> 		ptr = (int *)(((unsigned long) block + size - sizeof(int)) & ~3);
>>> With aligned accesses rtheap reports just3 mode switches in both modes,
>>> 0 and H_NONCACHED. But already one mode switch is too much!
>> I hope we get several mode switches because the allocator returns
>> different pages. To workaround this, we will have to cause a fault on
>> each page.  We can do this either in kernel or user-space.

I checked this, and this is true: we get a fault by different page
returned by the allocator.

> 
> Doing it in kernel-space, e.g. in xnheap_init_mapped(), does not help.
> Anyhow, I think the memory pages get touched in kernel space already here:

That is because you have to fault the user-space addresses, not the
kernel-space addresses, you have to use something like handle_mm_fault.

> 
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/heap.c#096
> 
> But the mode switches disappear when I touch the allocated memory (read
> and write back) in __map_heap_memory() write after the __real_mmap(:
> 
> http://www.rts.uni-hannover.de/xenomai/lxr/source/src/skins/native/heap.c#031

The problem if we do it in user-space is that we would have to do this
for every uses of the heaps, that is native skin heaps, posix skin
heaps, mutexes heaps, and every rtdm driver using shared heaps too.

-- 
                                                 Gilles.

