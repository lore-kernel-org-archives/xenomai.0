Message-ID: <526D5C2A.1010500@xenomai.org>
Date: Sun, 27 Oct 2013 19:32:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <526B99CD.3080303@xenomai.org>,
 <OF415A91C1.3CB4977D-ON85257C0F.0078CAEF-85257C0F.0078CB7B@moog.com>
 <OF4C4FACAC.0349F48E-ON85257C11.005CE00C-85257C11.005CE031@moog.com>
In-Reply-To: <OF4C4FACAC.0349F48E-ON85257C11.005CE00C-85257C11.005CE031@moog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_heap_alloc priority inversion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <GBroz@moog.com>
Cc: Xenomai@xenomai.org

On 10/27/2013 05:54 PM, George Broz wrote:
> -----Philippe Gerum <rpm@xenomai.org> wrote: -----
>>
>> On 10/25/2013 11:59 PM, George Broz wrote:
>>> Hello All,
>>>
>>> I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API
>>> on x86 (Atom, SMP, 32-bit).
>>>
>>> I have two tasks, both running in Xenomai user-space.
>>> One is priority=99 and blocks on rt_intr_wait(),
>>> running every 250 us with 125us margin. This task does
>>> not make direct calls to rt_heap_alloc/free().
>>>
>>> The other task is priority=50, wakes 1msec, sleeps 1msec.
>>> This task routinely makes rt_heap_alloc/free calls.
>>>
>>> When the priority=50 task makes rt_heap_alloc() calls
>>> for "size" greater than 5 MB, the priority=99 task
>>> appears to be held off from executing for several ms.
>>>
>>> Plenty of memory is available (vmalloc=320M as linux
>>> boot arg).
>>
>> The size that matters in how much memory you assigned to the heap in
>>
>> rt_heap_create().
> 
> Yes, sorry. Passing 256 MB (as 268,435,456) to rt_heap_create().

I believe the rt_heap is not meant for such large sizes: to satisfy a 5
MB allocation using 4096 bytes pages, it has to allocate 1280 pages,
that means a lot of housekeeping which happens with a spinlock locked,
irqs off. So, for your case you would want to use a larger page size,
say 1MB. Please try the following patch which is not a fix, but simply
an attempt at finding whether the page size is what causes the issue.

diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
index 568ba27..3a9105a 100644
--- a/ksrc/nucleus/heap.c
+++ b/ksrc/nucleus/heap.c
@@ -1362,7 +1362,7 @@ int xnheap_init_mapped(xnheap_t *heap, u_long
heapsize, int memflags)
 	if (heapbase == NULL)
 		return -ENOMEM;

-	err = xnheap_init(heap, heapbase, heapsize, PAGE_SIZE);
+	err = xnheap_init(heap, heapbase, heapsize, 1024 * 1024);
 	if (err) {
 		__unreserve_and_free_heap(heapbase, heapsize, memflags);
 		return err;

-- 
                                                                Gilles.

