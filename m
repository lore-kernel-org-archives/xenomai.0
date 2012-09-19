Message-ID: <2330c5aaa23e65a5d06cabd21bdbe03d.squirrel@www.xenomai.org>
In-Reply-To: <5059E22E.5020606@siemens.com>
References: <504F5F1B.4020806@siemens.com> <50550091.50002@xenomai.org>
	<505592B8.9000109@xenomai.org> <5056DBAD.1000903@xenomai.org>
	<5058AE95.2020103@siemens.com> <5058AF21.5000600@xenomai.org>
	<5058BC96.8090601@siemens.com> <5058BE17.5070304@xenomai.org>
	<5058C39C.8000407@siemens.com> <5058C5F6.3040406@xenomai.org>
	<5058C73B.8040006@siemens.com> <5058C79A.5020400@xenomai.org>
	<5058C8EE.1050803@siemens.com> <5058C9FE.5030505@xenomai.org>
	<5059D412.7020202@siemens.com>
	<ce86871e85b087a85fbdd8317716a9fd.squirrel@www.xenomai.org>
	<5059D7BD.7040103@siemens.com>
	<79e3e1e2376d88a17769fd13c9447e06.squirrel@www.xenomai.org>
	<5059DB31.6040604@siemens.com>
	<aa526cca898247642342ebae7e01b6a0.squirrel@www.xenomai.org>
	<5059E22E.5020606@siemens.com>
Date: Wed, 19 Sep 2012 18:09:57 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH] ipipe: x86: Populate vector_irq for all
 dispatched vectors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Jan Kiszka wrote:
> On 2012-09-19 17:02, Gilles Chanteperdrix wrote:
>>
>> Jan Kiszka wrote:
>>> On 2012-09-19 16:46, Gilles Chanteperdrix wrote:
>>>>
>>>> Jan Kiszka wrote:
>>>>> On 2012-09-19 16:28, Gilles Chanteperdrix wrote:
>>>>>>
>>>>>> Jan Kiszka wrote:
>>>>>>>  	for (vector = 0; vector < NR_VECTORS; ++vector) {
>>>>>>> +		/* I-pipe requires initialized vector_irq for system vectors */
>>>>>>> +		if (test_bit(vector, used_vectors))
>>>>>>> +			continue;
>>>>>>>  		irq = per_cpu(vector_irq, cpu)[vector];
>>>>>>>  		if (irq < 0)
>>>>>>>  			continue;
>>>>>>
>>>>>> This looks wrong to me: you are skipping a part a code that was
>>>>>> setting
>>>>>> to
>>>>>> -1 vectors that were allocated but not used on this cpu.
>>>>>
>>>>> I'm skipping only used_vectors, i.e system vectors. They will be set
>>>>> up
>>>>> for I-pipe for that well-known reason. I'm no longer skipping to
>>>>> clear
>>>>> IRQ vectors that are not used on the current CPU
>>>>> (!cpumask_test_cpu(cpu,
>>>>> cfg->domain)). That is what was missing in both approaches so far.
>>>>>
>>>>> Note: vector_free = (vector_irq == -1) && !used_vector
>>>>
>>>> Let us go back to the obvious loop:
>>>>
>>>>>         for (vector = 0; vector < first_system_vector; ++vector) {
>>>>>                 if (vector == IRQ_MOVE_CLEANUP_VECTOR)
>>>>>                         continue;
>>>>>
>>>>>                 irq = per_cpu(vector_irq, cpu)[vector];
>>>>>                 if (irq < 0)
>>>>>                         continue;
>>>>>
>>>>>                 cfg = irq_cfg(irq);
>>>>>                 if (!cpumask_test_cpu(cpu, cfg->domain))
>>>>>                         per_cpu(vector_irq, cpu)[vector] = -1;
>>>>>         }
>>>>
>>>> >From what I understand, this function is called when a CPU is
>>>> started,
>>>> so, for instance, with hotplug cpu, on a system that has been running
>>>> for days and so had a lot of time to allocate a lot of vectors.
>>>>
>>>> Now, some of these vectors are known not to be needed on the cpu we
>>>> are currently starting. What this loop does, is for such vectors, to
>>>> set the vector_irq entry on the cpu we are currently starting to -1.
>>>>
>>>> Now, such vectors will certainly have the used_vectors bit to 1.
>>>
>>> used_vectors should be called "used_for_system_vector".
>>
>> What about TLB flush vectors, are they not restricted to some cpus?
>
> OK, let's try this step by step:
>
> So far, the original loop ("Mark the free vectors" went over all
> vectors, clearing those out in vector_irq that were filled for *external
> IRQs* by the first loop ("Mark the inuse vector") but are actually not
> in use on the current CPU. Linux does not fill any system vector into
> vector_irq, as we know.

Ok, right, that is the answer to my question. per-cpu TLB vectors will not
get set in vector_irq, and so, the loop will not be able to clear them
on cpus where they are not used.

>
> Now that we do enter certain system vectors here (MOVE_CLEANUP and those
> above first_system_vector), we must avoid that this clearing happens for
> them. My old version did this by overwriting what was cleared with that
> simply 1:1 mapping again. Your version avoided any clearing for
> MOVE_CLEANUP and >first_system_vector. Both were wrong as both left
> vectors marked as in use which are actually free.

Which is not actually a big issue, as this will simply result in a oops
in __ipipe_dispatch_irq due to a NULL descriptor, instead of a call to
BUG(). No big difference... Ok, the bug may be easier to interpret.

>
> What we need is to still clear unused IRQ vectors, i.e. still run the
> full loop, but skip used system vectors. And the latter can be achieved
> by looking at used_vectors which is valid for all CPUs.
>
> Is this clearer?

Ok, no problem.

-- 
                    Gilles.


