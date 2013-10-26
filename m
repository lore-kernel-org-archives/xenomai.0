Message-ID: <526B99CD.3080303@xenomai.org>
Date: Sat, 26 Oct 2013 12:30:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <OF415A91C1.3CB4977D-ON85257C0F.0078CAEF-85257C0F.0078CB7B@moog.com>
In-Reply-To: <OF415A91C1.3CB4977D-ON85257C0F.0078CAEF-85257C0F.0078CB7B@moog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: George Broz <GBroz@moog.com>, Xenomai@xenomai.org

On 10/25/2013 11:59 PM, George Broz wrote:
> Hello All,
>
> I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API
> on x86 (Atom, SMP, 32-bit).
>
> I have two tasks, both running in Xenomai user-space.
> One is priority=99 and blocks on rt_intr_wait(),
> running every 250 us with 125us margin. This task does
> not make direct calls to rt_heap_alloc/free().
>
> The other task is priority=50, wakes 1msec, sleeps 1msec.
> This task routinely makes rt_heap_alloc/free calls.
>
> When the priority=50 task makes rt_heap_alloc() calls
> for "size" greater than 5 MB, the priority=99 task
> appears to be held off from executing for several ms.
>
> Plenty of memory is available (vmalloc=320M as linux
> boot arg).

The size that matters in how much memory you assigned to the heap in 
rt_heap_create().

  TM_NONBLOCK is used when calling
> rt_heap_alloc(). Both "0" and H_PRIO have been tried
> for "mode" when creating the area with rt_heap_create().
>
> Is this expected behavior?
>
> How can large memory allocations be built without a
> "realloc" equivalent offered in the memory heap
> services?
>
>

There is no reallocation in the rt heap services, ever. If H_SINGLE was 
passed to rt_heap_create(), there is not even any "allocation", the 
address of the heap memory is returned in that case, as it is viewed as 
a single buffer.

Assuming you don't pass H_SINGLE when creating the heap, the only reason 
to get delays in non-blocking allocation mode would be that a minor VM 
fault unexpectedly happens when the 5MB block is being pulled from the 
heap, when writing our meta-data to that memory area. That would mean 
that your calling thread switches to secondary mode for handling the 
fault, and gets delayed for this reason.

You should first try checking this assumption, by enabling T_WARNSW for 
your thread. If this is confirmed, then there could be something wrong 
in the i-pipe layer for your kernel release.

-- 
Philippe.

