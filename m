Subject: Re: [PATCH v2 5/7] drivers/net: wrap csum_partial_copy_nocheck()
References: <20210327101912.2291474-1-rpm@xenomai.org>
 <20210327101912.2291474-6-rpm@xenomai.org>
 <f00e7b29-5d8d-cdcb-adeb-630c277f7d67@siemens.com>
 <87k0p4ui5y.fsf@xenomai.org>
 <ce95f3e8-7bdc-c94f-8814-d6af1c3e5d71@siemens.com>
 <878s5kugo7.fsf@xenomai.org>
 <8c69e790-a094-7c96-c5b0-d71899cfc4f9@siemens.com>
 <87wnt25g5g.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a45f15ee-2432-fc18-f0c8-ec5f61fc1c4b@siemens.com>
Date: Fri, 16 Apr 2021 19:12:10 +0200
MIME-Version: 1.0
In-Reply-To: <87wnt25g5g.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 16.04.21 18:48, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 15.04.21 09:54, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 15.04.21 09:21, Philippe Gerum wrote:
>>>>>
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> On 27.03.21 11:19, Philippe Gerum wrote:
>>>>>>> From: Philippe Gerum <rpm@xenomai.org>
>>>>>>>
>>>>>>> Since v5.9-rc1, csum_partial_copy_nocheck() forces a zero seed as its
>>>>>>> last argument to csum_partial(). According to #cc44c17baf7f3, passing
>>>>>>> a non-zero value would not even yield the proper result on some
>>>>>>> architectures.
>>>>>>>
>>>>>>> Nevertheless, the current ICMP code does expect a non-zero csum seed
>>>>>>> to be used in the next computation, so let's wrap net_csum_copy() to
>>>>>>> csum_partial_copy_nocheck() for pre-5.9 kernels, and open code it for
>>>>>>> later kernels so that we still feed csum_partial() with the user-given
>>>>>>> csum. We still expect the x86, ARM and arm64 implementations of
>>>>>>> csum_partial() to do the right thing.
>>>>>>>
>>>>>>
>>>>>> If that issue only affects the ICMP code path, why not only changing
>>>>>> that, leaving rtskb_copy_and_csum_bits with the benefit of doing copy
>>>>>> and csum in one step?
>>>>>>
>>>>>
>>>>> As a result of #cc44c17baf7f3, I see no common helper available from the
>>>>> kernel folding the copy and checksum operations anymore, so I see no way
>>>>> to keep rtskb_copy_and_csum_bits() as is. Did you find an all-in-one
>>>>> replacement for csum_partial_copy_nocheck() which would allow a csum
>>>>> value to be fed in?
>>>>>
>>>>
>>>> rtskb_copy_and_csum_dev does not need that.
>>>>
>>>
>>> You made rtskb_copy_and_csum_bits() part of the exported API. So how do
>>> you want to deal with this?
>>>
>>
>> That is an internal API, so we don't care.
>>
>> But even if we converted rtskb_copy_and_csum_bits to work as it used to
>> (with a csum != 0), there would be not reason to make
>> rtskb_copy_and_csum_dev pay that price.
>>
> 
> Well, there may be a reason to challenge the idea that a folded
> copy_and_csum is better for a real-time system than a split memcpy+csum
> in the first place. Out of curiosity, I ran a few benchmarks lately on a
> few SoCs regarding this, and it turned out that optimizing the data copy
> to get the buffer quickly in place before checksumming the result may
> well yield much better results with respect to jitter than what
> csum_and_copy currently achieves on these SoCs.
> 
> Inline csum_and_copy did perform slightly better on average (a couple of
> hundreds of nanosecs at best) but with pathological jittery in the worst
> case at times. On the contrary, the split memcpy+csum method did not
> exhibit such jittery during these tests, not once.
> 
> - four SoCs tested (2 x x86, armv7, armv8a)
> - test code ran in kernel space (real-time task context,
>   out-of-band/primary context)
> - csum_partial_copy_nocheck() vs memcpy()+csum_partial()
> - 3 buffer sizes tested (32, 1024, 1500 bytes), 3 runs each
> - all buffers (src & dst) aligned on L1_CACHE_BYTES
> - each run performed 1000,000 iterations of a given checksum loop, no
>   pause in between.
> - no concurrent load on the board
> - all results in nanoseconds
> 
> The worst results obtained are presented here for each SoC.
> 
> x86[1]
> ------
> 
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 92
> model name	: Intel(R) Atom(TM) Processor E3940 @ 1.60GHz
> stepping	: 9
> cpu MHz		: 1593.600
> cache size	: 1024 KB
> cpuid level	: 21
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology tsc_reliable nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 ds_cpl vmx est tm2 ssse3 sdbg cx16 xtpr pdcm sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave rdrand lahf_lm 3dnowprefetch cpuid_fault cat_l2 pti tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust smep erms mpx rdt_a rdseed smap clflushopt intel_pt sha_ni xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts
> vmx flags	: vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple shadow_vmcs
> 
> ==
> 
> CSUM_COPY 32b: min=68, max=653, avg=70
> CSUM_COPY 1024b: min=248, max=373, avg=251
> CSUM_COPY 1500b: min=344, max=3123, avg=350   <=================
> COPY+CSUM 32b: min=101, max=790, avg=103
> COPY+CSUM 1024b: min=297, max=397, avg=300
> COPY+CSUM 1500b: min=402, max=490, avg=405
> 
> ==
> 
> CSUM_COPY 32b: min=68, max=1420, avg=70
> CSUM_COPY 1024b: min=248, max=29706, avg=251   <=================
> CSUM_COPY 1500b: min=344, max=792, avg=350
> COPY+CSUM 32b: min=101, max=872, avg=103
> COPY+CSUM 1024b: min=297, max=776, avg=300
> COPY+CSUM 1500b: min=402, max=853, avg=405
> 
> ==
> 
> CSUM_COPY 32b: min=68, max=661, avg=70
> CSUM_COPY 1024b: min=248, max=1714, avg=251
> CSUM_COPY 1500b: min=344, max=33937, avg=350   <=================
> COPY+CSUM 32b: min=101, max=610, avg=103
> COPY+CSUM 1024b: min=297, max=605, avg=300
> COPY+CSUM 1500b: min=402, max=712, avg=405
> 
> x86[2]
> ------
> 
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 23
> model name      : Intel(R) Core(TM)2 Duo CPU     E7200  @ 2.53GHz
> stepping        : 6
> microcode       : 0x60c
> cpu MHz         : 1627.113
> cache size      : 3072 KB
> cpuid level     : 10
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl cpuid aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm sse4_1 lahf_lm pti dtherm
> 
> CSUM_COPY 32b: min=558, max=31010, avg=674     <=================
> CSUM_COPY 1024b: min=558, max=2794, avg=745
> CSUM_COPY 1500b: min=558, max=2794, avg=841
> COPY+CSUM 32b: min=558, max=2794, avg=671
> COPY+CSUM 1024b: min=558, max=2794, avg=778
> COPY+CSUM 1500b: min=838, max=2794, avg=865
> 
> ==
> 
> CSUM_COPY 32b: min=59, max=532, avg=62
> CSUM_COPY 1024b: min=198, max=270, avg=201
> CSUM_COPY 1500b: min=288, max=34921, avg=289   <=================
> COPY+CSUM 32b: min=53, max=326, avg=56
> COPY+CSUM 1024b: min=228, max=461, avg=232
> COPY+CSUM 1500b: min=311, max=341, avg=317
> 
> ==
> 
> CSUM_COPY 32b: min=59, max=382, avg=62
> CSUM_COPY 1024b: min=198, max=383, avg=201
> CSUM_COPY 1500b: min=285, max=21235, avg=289   <=================
> COPY+CSUM 32b: min=52, max=300, avg=56
> COPY+CSUM 1024b: min=228, max=348, avg=232
> COPY+CSUM 1500b: min=311, max=409, avg=317
> 
> Cortex A9 quad-core 1.2Ghz (iMX6qp)
> -----------------------------------
> 
> model name	: ARMv7 Processor rev 10 (v7l)
> Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpd32 
> CPU implementer	: 0x41
> CPU architecture: 7
> CPU variant	: 0x2
> CPU part	: 0xc09
> CPU revision	: 10
> 
> CSUM_COPY 32b: min=333, max=1334, avg=440
> CSUM_COPY 1024b: min=1000, max=2666, avg=1060
> CSUM_COPY 1500b: min=1333, max=45333, avg=1357   <=================
> COPY+CSUM 32b: min=333, max=1334, avg=476
> COPY+CSUM 1024b: min=1000, max=2333, avg=1324
> COPY+CSUM 1500b: min=1666, max=2334, avg=1713
> 
> ==
> 
> CSUM_COPY 32b: min=333, max=1334, avg=439
> CSUM_COPY 1024b: min=1000, max=46000, avg=1060   <=================
> CSUM_COPY 1500b: min=1333, max=5000, avg=1351
> COPY+CSUM 32b: min=333, max=1334, avg=476
> COPY+CSUM 1024b: min=1000, max=2334, avg=1324
> COPY+CSUM 1500b: min=1666, max=2667, avg=1713
> 
> ==
> 
> CSUM_COPY 32b: min=333, max=1666, avg=454
> CSUM_COPY 1024b: min=1000, max=2000, avg=1060
> CSUM_COPY 1500b: min=1333, max=45000, avg=1348   <=================
> COPY+CSUM 32b: min=333, max=1334, avg=454
> COPY+CSUM 1024b: min=1000, max=2334, avg=1317
> COPY+CSUM 1500b: min=1666, max=6000, avg=1712
> 
> Cortex A55 quad-core 2Ghz (Odroid C4)
> -------------------------------------
> 
> Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
> CPU implementer : 0x41
> CPU architecture: 8
> CPU variant     : 0x1
> CPU part        : 0xd05
> CPU revision    : 0
> 
> 
> CSUM_COPY 32b: min=125, max=833, avg=140
> CSUM_COPY 1024b: min=625, max=41916, avg=673   <=================
> CSUM_COPY 1500b: min=875, max=3875, avg=923
> COPY+CSUM 32b: min=125, max=458, avg=140
> COPY+CSUM 1024b: min=625, max=1166, avg=666
> COPY+CSUM 1500b: min=875, max=1167, avg=913
> 
> ==
> 
> CSUM_COPY 32b: min=125, max=1292, avg=139
> CSUM_COPY 1024b: min=541, max=48333, avg=555
> CSUM_COPY 1500b: min=708, max=3458, avg=740
> COPY+CSUM 32b: min=125, max=292, avg=136
> COPY+CSUM 1024b: min=541, max=750, avg=556
> COPY+CSUM 1500b: min=708, max=834, avg=740
> 
> ==
> 
> CSUM_COPY 32b: min=125, max=833, avg=140
> CSUM_COPY 1024b: min=666, max=55667, avg=673   <=================
> CSUM_COPY 1500b: min=875, max=4208, avg=913
> COPY+CSUM 32b: min=125, max=375, avg=140
> COPY+CSUM 1024b: min=666, max=916, avg=673
> COPY+CSUM 1500b: min=875, max=1042, avg=913
> 
> ============
> 
> A few additional observations from looking at the implementation:
> 
> For memcpy, legacy x86[2] uses movsq, finishing with movsb to complete
> buffers of unaligned length. Current x86[1] uses ERMS-optimized movsb
> which is faster.
> 
> arm32/armv7 optimizes memcpy by loading up to 8 words in a single
> instruction. csum_and_copy loads/stores at best 4 words at a time,
> only when src and dst are 32bit aligned (which matches the test case).
> 
> arm64/armv8a uses load/store pair instructions to copy memory
> blocks. It does not have asm-optimized csum_and_copy support, so it
> uses the generic C version.
> 
> What could be inferred in terms of prefetching and speculation might
> explain some differences between the approaches too.
> 
> I would be interested in any converging / diverging results testing the
> same combo with a different test code, because from my standpoint,
> things do not seem as obvious as they are supposed to be at the moment.
> 

If copy+csum is not using any recent memcopy optimizations, that is an
argument for at least equivalent performance.

But I don't get yet where the huge jittery should be coming from. Were
the measurement loop preemptible? In that case I would expect a split
copy followed by another loop to csum should give much worse results as
it needs the cache to stay warm - while copy-csum only touches the data
once.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

