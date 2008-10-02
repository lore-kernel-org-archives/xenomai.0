Message-ID: <48E4E8FB.1050901@domain.hid>
Date: Thu, 02 Oct 2008 17:30:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <899865CA54E4444DAF2E3639C04C5F48E4DB5C@trillian.at.omicron.at>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F48E4DB5C@trillian.at.omicron.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] FW: [PATCH] repost: ARM FCSE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: adeos-main@gna.org

Richard Cochran wrote:
>> -----Original Message----- From: Gilles Chanteperdrix
>>
>> found the reason for the crash. The system seems to run stable now.
>> Here comes the patch.
> 
> Great work!
> 
>> Could you test it and confirm that there is no problem for you ?
> 
> I back ported the patch to 2.6.21 and ran it on an NSLU. I did not see
> any trouble. I ran my three "production" user space programs and ran,
> at the same time:
> 
>     while [ 1 ]; do find /; cat /dev/mem > /dev/null; done
> 
> Can you post your stress-testing script?

Well, I have not really stressed-test it, I have run a dd if=/dev/zero
of=/dev/null, in parallel with a loop of ls -lR /, and launched the
xenomai run script. I intend to make a real effort, and compile and run
LTP, to avoid making myself ridiculous on the Linux arm kernel mailing list.

I intend to ask if they are ready to include the patch into the mainline
kernel if we make the effort of overcoming the 95 pids * 32 MiB limitation.

> 
> I will test the new patch on my four other, different IXP boards.
> 
> I will have to study the patch to understand what the trouble
> was. Perhaps you can explain it a bit?

One problem was the pid allocation: linux recycles pids faster than it
recycles mm_structs, so by using the task_struct pid, we could have two
mm_struct with the same pid at the same time. And since this allocation
scheme was not using all pids with multi-threaded processes, I
implemented a bitfield based PID allocation.

Another problem was the way the mapping was built, I did not fully
understand how the pmd_populate trick could work with such things as
copy_page_range (which copies the pages at fork time, and should copy
them automatically between different address spaces), and I did not like
the way like there was two parallel mappings, so, I implemented
something different: I made the pgd_offset macro "FCSE aware", and it
turned out that it was sufficient to fix the page tables population
completely.

Something else I needed was that the cache flush do not rely on
mm->cpu_vm_mask to flush. So, we basically wanted that the cpu bit be
set in cpu_vm_mask unconditionnaly when the context is switched first to
the new process, and not cleared in switch_to when the process is
switched out.

The most important cache flush which must happen is flush_cache_mm,
which is called when a process dies, this is because since the pages are
returned to the memory allocator, we do not want later cache line
evictions to override these possibly reused pages.

However, since we do flush the tlb, we want cpu_vm_mask not to be used
by tlb flushing operations, so, I put a second cpumask_t in the mm
context, which is conditionnaly used for tlb flushing operations instead
of mm->cpu_vm_mask when CONFIG_ARM_FCSE is set, this mask being cleared
by switch_to after the tlb is flushed.

Another thing (which really is a quick hack in the current patch), is
that we need cpu_do_switch_mm to do a full cache flush, when a process
has a shared, writable, cached mapping, because of potential aliasing
issues (we assume that applications are not stupid, and will not map a
shared writable cacheable mapping if they are not really sharing it with
other applications). So, cpu_do_switch_mm takes a second argument
telling whether a cache flush should occur. What is a quick hack is the
piece of code in do_mmap2 which checks if the mapping verifies the
shared, writable, cacheabled constraints, but this check never happens
when using mprotect, mremap, and munmap. We probably rather need
architecture dependent hooks in the architecture-independent code, but I
did not want to touch architecture-independent code.

The problem which really blocked me for some time was two missing
va_to_mvas in tlb user range flush operation (local_tlb_flush_range, or
something).

> 
> In any case, I found one huge error in the patch...you mangled my name
> ;)
> + *              (C) 2008 Richard Co            if (next)
> +chran

Sorry, must be "thumb on the touchpad" accident... :-)

-- 
                                                 Gilles.

