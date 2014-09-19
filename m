Message-ID: <541BC21F.20604@siemens.com>
Date: Fri, 19 Sep 2014 07:41:51 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAPRPZsBD_5ufxFAhPCFqRf9YZSm1FhqfcmL+MTbhJ=1Sb7ED_g@mail.gmail.com>	<CAPRPZsBsOmiaWPJmPR9RK0uv_BXbw_s43rarKOvVoGfN2gWZjQ@mail.gmail.com>	<CAPRPZsCnAJH_-070SbSMB+Q_dQwf+FYfKpmp1wzwtz=zMA2bcA@mail.gmail.com>	<5357C92F.2060206@xenomai.org>	<CAPRPZsAvxx9XVB5MYi65m1FPaz2p7Rgh7+M4U357exJBbo0kHQ@mail.gmail.com>	<535828F6.6050308@xenomai.org>	<CAPRPZsA4ZQEm1a+2TV6s2wvD2_M53RrL4zLz0sJgLKEF8ALo1w@mail.gmail.com>	<53583DF7.3080700@xenomai.org>	<CAPRPZsB8a=gN=U14qn_tpfksg3T8yW+M8pZGhOkT-jPDuU8L0w@mail.gmail.com>	<CAPRPZsAyTQN936=phnT+NzvT7w_UxnY1ppQDucCjh39neOYn6g@mail.gmail.com>	<CAPRPZsB4+68QpNZ7sBCa6-wssNizkrBpG7vB_6q-cJXvCzkihg@mail.gmail.com>
 <CAPRPZsCji_p56+CC+a6ueywq39piA=70RaTPP3Xtz62NL_nhcQ@mail.gmail.com>
 <540F6B15.2070201@xenomai.org> <54112EFA.4080901@web.de>
 <541130D0.50409@web.de> <541AC62F.2050003@xenomai.org>
 <541AC933.9090600@siemens.com> <541B3ED6.8090606@xenomai.org>
 <541B8F91.9050603@xenomai.org>
In-Reply-To: <541B8F91.9050603@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reading /proc/xenomai/stat causes high latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-09-19 04:06, Gilles Chanteperdrix wrote:
> On 09/18/2014 10:21 PM, Gilles Chanteperdrix wrote:
>> On 09/18/2014 01:59 PM, Jan Kiszka wrote:
>>> On 2014-09-18 13:46, Gilles Chanteperdrix wrote:
>>>>  (*) There is no guarantee that a CPU will see the correct order of
>>>> effects from a second CPU's accesses, even _if_ the second CPU uses a
>>>> memory barrier, unless the first CPU _also_ uses a matching memory
>>>> barrier (see the subsection on "SMP Barrier Pairing").
>>>
>>> [quick answer]
>>>
>>> ...or the architecture refrains from reordering write requests, like x86
>>> does. What may happen, though, is that the compiler reorders the writes.
>>> Therefore you need at least a (must cheaper) compiler barrier on those
>>> archs. See also linux/Documentation/memory-barriers.txt on this and more.
>>
>> The passage you quote is quoted from memory-barriers.txt, and I find it
>> makes it pretty clear that the two barriers are needed for cache
>> synchronization in the general case. Now, I read more in
>> memory-barriers, and I do not find easily details about what the fact
>> that x86 is "strictly ordered" means, and how it relaxes the constraints
>> on what rules. Maybe you would care to give us the exact passage where
>> this is mentioned? Also, I would welcome any detail about how SMP cache
>> synchronization actually works on x86.
> 
> Ok, I have read a few things, it would seem recent x86 architectures
> (nehalem, sandy bridge and probably haswell) use the MESIF cache
> coherence protocol, with a twist for haswell since it introduced
> transactional memory. A cache coherence protocol ensures in theory
> transparently the same view of cache on all cpus. MESIF itself is
> derived from the MESI cache coherence protocol, which is said (by
> wikipedia article) to have some performance issues which are generally
> compensated by adding a store buffer, which in turn requires memory
> barriers for a store on one cpu to be visible in the cache (and so on
> other cpus). I did not find any indication that memory barriers are
> still needed for this case (which is exactly the case we are interested
> in) with MESIF, but no indication that they are not needed either.
> 
> Then, I had a look at the ticket spinlocks implementations. The
> operations they do are roughly the same as the xnlock implementation,
> except that they are optimized for each architecture, and so remove the
> useless barriers. The ARM implementation has the barrier after unlock,
> and use in addition the special "sev" instruction, allowing the spinning
> cpu to wait for this signal with the "wfe" (wait for event) instruction,
> and to not burn cpu power when spinning. In fact it does not spin.
> 
> Of course, the problem is that they are not recursive, so implementing
> recursive tickets spinlocks without adding overhead seems tricky. Just
> to test if ticket spinlocks solve the issue which started this thread, I
> made the following implementation:
> 
> typedef struct {
> 	unsigned owner;
> 	arch_spinlock_t alock;
> } xnlock_t;
> 
> static inline int __xnlock_get(xnlock_t *lock /*, */
> XNLOCK_DBG_CONTEXT_ARGS)
> {
> 	unsigned long long start;
> 	int cpu = xnarch_current_cpu();
> 
> 	if (lock->owner == cpu)
> 		return 1;
> 
> 	xnlock_dbg_prepare_acquire(&start);
> 
> 	arch_spin_lock(&lock->alock);
> 	lock->owner = cpu;
> 
> 	xnlock_dbg_acquired(lock, cpu, &start /*, */ XNLOCK_DBG_PASS_CONTEXT);
> 
> 	return 0;
> }
> 
> static inline void xnlock_put(xnlock_t *lock)
> {
> 	if (xnlock_dbg_release(lock))
> 		return;
> 
> 	lock->owner = ~0U;
> 	arch_spin_unlock(&lock->alock);
> }
> 
> And the good news is yes, this avoids the issue with /proc/xenomai/stat.
> The bad news is that it does not answer the question about visibility on
> one cpu of stores on another cpu without barrier. Because the ticket
> spinlocks work either way on x86: the atomic add at the beginning of
> arch_spin_lock ensures both the visibility of the fact that there is a
> waiter to the cpu attempting to relock, and of the fact that the spin
> lock has been unlocked to the waiting cpu. So, in the particular case of
> the concurrent cat /proc/xenomai/stat, the "two barriers needed for
> visibility" rule is respected.
> 
> I have also measured latencies with a cat /proc/xenomai/stat loop
> running, with and without a memory barrier after arch_spin_unlock, and
> could not find any difference, minimum, average and maximum latency
> after a few minutes of runtime are the same, or at least inferior to 100ns.
> 
> I am also wondering if this xnlock implementation could be used on
> forge. It has the advantage of benefiting from architecture
> optimization, without the need for maintaining architecture dependent code.
>

Indeed, that would be very elegant!

Jan


-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

