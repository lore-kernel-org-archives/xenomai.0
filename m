Message-ID: <529F0C48.20705@xenomai.org>
Date: Wed, 04 Dec 2013 12:04:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
 <529DCF2F.1070702@xenomai.org>
 <1507DF58-4A8D-42E0-92B8-4A9EAB4289E3@open.ac.uk>
 <529DDB58.3090709@xenomai.org>
 <5B55252A-19D2-4A0D-82BE-FC77BFA6AEE1@open.ac.uk>
 <529DFEC3.1050106@xenomai.org>
 <90F2A7A6-5B5E-4A25-8D9D-3D50D0EC0826@open.ac.uk>
 <529E2801.5060505@xenomai.org> <529EEB7C.4090308@xenomai.org>
 <529EED06.4010108@xenomai.org> <529EF58A.8030003@xenomai.org>
 <529EF680.1040108@xenomai.org> <529EF89E.6000302@xenomai.org>
 <529EFB3D.6090900@xenomai.org> <529F03FC.8040409@xenomai.org>
 <529F04DD.2070201@xenomai.org>
In-Reply-To: <529F04DD.2070201@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Kurijn Buys <Kurijn.Buys@open.ac.uk>, Xenomai@xenomai.org

On 12/04/2013 11:33 AM, Philippe Gerum wrote:
> On 12/04/2013 11:29 AM, Philippe Gerum wrote:
>> On 12/04/2013 10:51 AM, Gilles Chanteperdrix wrote:
>>> On 12/04/2013 10:40 AM, Philippe Gerum wrote:
>>>> On 12/04/2013 10:31 AM, Gilles Chanteperdrix wrote:
>>>>> On 12/04/2013 10:27 AM, Philippe Gerum wrote:
>>>>>> On 12/04/2013 09:51 AM, Gilles Chanteperdrix wrote:
>>>>>>> On 12/04/2013 09:44 AM, Philippe Gerum wrote:
>>>>>>>> On 12/03/2013 07:50 PM, Gilles Chanteperdrix wrote:
>>>>>>>>> On 12/03/2013 05:49 PM, Kurijn Buys wrote:
>>>>>>>>>> Op 3-dec.-2013, om 15:54 heeft Gilles Chanteperdrix het volgende
>>>>>>>>>> geschreven:
>>>>>>>>>>
>>>>>>>>>>> On 12/03/2013 04:31 PM, Kurijn Buys wrote:
>>>>>>>>>>>> Op 3-dec.-2013, om 13:23 heeft Gilles Chanteperdrix het
>>>>>>>>>>>> volgende
>>>>>>>>>>>> geschreven:
>>>>>>>>>>>>
>>>>>>>>>>>>> On 12/03/2013 02:07 PM, Kurijn Buys wrote:
>>>>>>>>>>>>>> Thanks for the quick response, ACPI is enabled, I only
>>>>>>>>>>>>>> disabled
>>>>>>>>>>>>>> "Processor" in there... -1 was a typo indeed, it is at 1... I
>>>>>>>>>>>>>> see SCHED_SMT [=y] in my kernel config... shall I recompile
>>>>>>>>>>>>>> the
>>>>>>>>>>>>>> kernel with this disabled then... no other things to try
>>>>>>>>>>>>>> first/at
>>>>>>>>>>>>>> the same time?
>>>>>>>>>>>>>
>>>>>>>>>>>>> To remove hyperthreading, either: - disable it in the BIOS
>>>>>>>>>>>>> configuration; - or disable CONFIG_SMP (not SCHED_SMPT) in the
>>>>>>>>>>>>> kernel configuration.
>>>>>>>>>>>>>
>>>>>>>>>>>> Ah I see, CONFIG_SMP is also enabled... I've disabled it in
>>>>>>>>>>>> BIOS, but
>>>>>>>>>>>> no success (tell me if it is worth trying to disable it in the
>>>>>>>>>>>> kernel
>>>>>>>>>>>> config in stead).
>>>>>>>>>>>
>>>>>>>>>>> When you say "no success", you mean you still have 2 cpus ? Or
>>>>>>>>>>> you
>>>>>>>>>>> still
>>>>>>>>>>> have latency pikes? If the former, then yes, try without
>>>>>>>>>>> CONFIG_SMP, or
>>>>>>>>>>> pass nr_cpus=1 on the command line. If the latter, then no,
>>>>>>>>>>> testing
>>>>>>>>>>> without CONFIG_SMP is useless.
>>>>>>>>>>
>>>>>>>>>> the second: still latency...
>>>>>>>>>> (lscpu says there is only 1 cpu now)
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I realized that the test with sched_rt_runtime_us on -1 I
>>>>>>>>>>>>>> performed was with an earlier set-up. When I set it now to
>>>>>>>>>>>>>> -1, I
>>>>>>>>>>>>>> have better performance, but: 1) still spikes of up to 87us
>>>>>>>>>>>>>> under
>>>>>>>>>>>>>> load with ./latency 2) still some completely shifted
>>>>>>>>>>>>>> occurrences
>>>>>>>>>>>>>> with the other latency test, with a 1000µs period (but now
>>>>>>>>>>>>>> only 2
>>>>>>>>>>>>>> out of 890814), and the rest of the distribution lies in
>>>>>>>>>>>>>> [861-1139]µs, which is also rather large I suppose.
>>>>>>>>>>>>>
>>>>>>>>>>>>> sched_rt_runtime_us should not make any difference.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Something else you should try is to disable root thread
>>>>>>>>>>>>> priority
>>>>>>>>>>>>> coupling.
>>>>>>>>>>>>>
>>>>>>>>>>>> I have tried a config with priority coupling support disabled
>>>>>>>>>>>> before,
>>>>>>>>>>>> but then the system was even more vulnerable for such latency
>>>>>>>>>>>> peaks
>>>>>>>>>>>> (however the mean latency was a little lower!) (I still have
>>>>>>>>>>>> the
>>>>>>>>>>>> kernel, but unfortunately the I-pipe tracer isn't installed
>>>>>>>>>>>> there)
>>>>>>>>>>>
>>>>>>>>>>> Please keep priority coupling disabled in further tests.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The ipipe trace after test (1) was similar to the one I
>>>>>>>>>>>>>> posted,
>>>>>>>>>>>>>> where this line seems to be the problem I suppose: :|   #end
>>>>>>>>>>>>>> 0x80000001 -179! 149.235  ipipe_check_context+0x87
>>>>>>>>>>>>>> (add_preempt_count+0x15)
>>>>>>>>>>>>>>
>>>>>>>>>>>> ...I hoped the I-pipe trace would help..?
>>>>>>>>>>>
>>>>>>>>>>> Unfortunately the trace is not helping much.
>>>>>>>>>>
>>>>>>>>>> If it would help, I've another trace (joint as txt) where the
>>>>>>>>>> following line seems to indicate a problem:
>>>>>>>>>> :    +func                -141! 117.825  i915_gem_flush_ring+0x9
>>>>>>>>>> [i915] (i915_gem_do_execbuffer+0xb46 [i915])
>>>>>>>>>> -- The Open University is incorporated by Royal Charter (RC
>>>>>>>>>> 000391),
>>>>>>>>>> an exempt charity in England & Wales and a charity registered in
>>>>>>>>>> Scotland (SC 038302).
>>>>>>>>>
>>>>>>>>> Ah this is a known issue then. I traced back this issue some time
>>>>>>>>> ago,
>>>>>>>>> and from what I understood on the rt-users mailing list it is
>>>>>>>>> fixed on
>>>>>>>>> more recent kernels. So, I would advise to update to 3.10.18
>>>>>>>>> branch,
>>>>>>>>> available here by git:
>>>>>>>>
>>>>>>>> Incidentally, I've been chasing a latency issue on x86 involving
>>>>>>>> the
>>>>>>>> i915 chipset recently on 3.10,
>>>>>>>
>>>>>>> was it 3.10 or 3.10.18 ?
>>>>>>>
>>>>>>
>>>>>> http://git.xenomai.org/ipipe.git/log/?h=ipipe-3.10
>>>>>>
>>>>>> which is currently 3.10.18.
>>>>>>
>>>>>>>> and it turned out that we were still
>>>>>>>> badly hit by wbinvd instructions, emitted on _all_ cores via an
>>>>>>>> IPI in
>>>>>>>> the GEM control code, when the LLC cache is present.
>>>>>>>>
>>>>>>>> The jitter incurred by invalidating all internal caches exceeds
>>>>>>>> 300 us
>>>>>>>> in my test case, so it seems that we are not there yet.
>>>>>>>
>>>>>>> Ok, maybe the preempt_rt workaround is only enabled for
>>>>>>> CONFIG_PREEMPT_RT? In which case we can try and import the patch in
>>>>>>> the
>>>>>>> I-pipe.
>>>>>>>
>>>>>>
>>>>>> Looking at the comment in the GEM code, this invalidation is
>>>>>> required to
>>>>>> flush transactions before updating the fence register.
>>>>>>
>>>>>
>>>>>   From what I understood, the preempt_rt patch asks users to pin the X
>>>>> server on one cpu and disables the IPI, so the invalidation can be run
>>>>> on only one cpu. That said, if that had solved the issue, Kurijn would
>>>>> not have observed the latency spikes when running with only one cpu.
>>>>>
>>>>
>>>>     if (HAS_LLC(obj->base.dev))
>>>>         on_each_cpu(i915_gem_write_fence__ipi, NULL, 1);
>>>>
>>>> So this will run on every CPU regardless of the number of CPUs, in sync
>>>> mode. In addition, this section is interrupt-enabled. Some of my tests
>>>> were conducted in UP mode to make sure we did not face a locking
>>>> latency
>>>> inherited from another core, like we had with the APIC madness in the
>>>> early days, and the jitter was still right there. I don't see much
>>>> hope.
>>>>
>>>
>>> I have not read the preempt_rt patch, only the announces. But for
>>> instance, in the 3.8.13-rt12 patch announce, I read:
>>>
>>> - added an option to the i915 driver to disable the expensive wbinvd. A
>>>    warning is printed once on RT if wbinvd is not disabled to let the
>>>    user know about this problem. This problem was decoded by Carsten
>>> Emde.
>>>
>>>
>>
>> This is documented as a plain reversal of the former change aimed at
>> fixing non-coherence issues with fence updates:
>>
>>  From 22d61b535bbb5f2b65bfe564d16b0d2b4413535a Mon Sep 17 00:00:00 2001
>> From: Chris Wilson <chris@chris-wilson.co.uk>
>> Date: Wed, 10 Jul 2013 13:36:24 +0100
>> Subject: [PATCH 003/293] Revert "drm/i915: Workaround incoherence between
>>   fences and LLC across multiple CPUs"
>>
>> This reverts commit 25ff119 and the follow on for Valleyview commit
>> 2dc8aae.
>>
>
> That one seems to be suggested as a cheaper replacement for the ugly
> wbinvd, we should have a look at it:
>
> drm/i915: Fix incoherence with fence updates on Sandybridge+
>

We do have this one in 3.10.18, but not the reversal of the former 
workaround which produces jitter.

http://www.spinics.net/lists/stable-commits/msg27025.html

-- 
Philippe.

