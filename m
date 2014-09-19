Message-ID: <541C0ACA.10307@xenomai.org>
Date: Fri, 19 Sep 2014 12:51:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/19/2014 04:06 AM, Gilles Chanteperdrix wrote:
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

Thinking more about this, the store buffer is there for timing reasons
(because getting the cache line from another cpu takes time), so I
suspect the barrier does not in fact really flush the buffer, but wait
for it to drain, which means issuing the barrier will not, in fact,
change the timing for the visibility of the last store on a distant cpu,
it will simply stall the current cpu.

-- 
                                                                Gilles.

