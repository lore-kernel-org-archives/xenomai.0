Date: Wed, 10 Aug 2016 17:10:08 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160810171008.111b14a3@md1em3qc>
In-Reply-To: <3850e719-d750-ab8d-40a0-10ccdc424e7c@tuebingen.mpg.de>
References: <web-9034838@tuebingen.mpg.de> <20160804141744.3adbe573@md1em3qc>
 <web-9059594@tuebingen.mpg.de> <20160804161155.382df26e@md1em3qc>
 <web-9079189@tuebingen.mpg.de> <20160808113421.5ce17aaa@md1em3qc>
 <654b5045-1430-379f-92fa-bfa691408fff@tuebingen.mpg.de>
 <20160808191129.1206b1b2@md1em3qc>
 <e98947d5-5147-bd34-5634-58dc88a3466d@tuebingen.mpg.de>
 <20160809174642.75541ddc@md1em3qc>
 <3850e719-d750-ab8d-40a0-10ccdc424e7c@tuebingen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] tsc not monotonic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Vincent Berenz <vberenz@tuebingen.mpg.de>
Cc: Vincent Berenz <vincent.berenz@tuebingen.mpg.de>, xenomai@xenomai.org

Am Wed, 10 Aug 2016 14:35:11 +0200
schrieb Vincent Berenz <vberenz@tuebingen.mpg.de>:

> Hi,
> 
> Thanks a lot for the help and insight.
> 
> Feels like trying my luck on a different machine is the most 
> straightforward way to get a working setup. Also I may lack the the 
> skills to look into this in a truly useful manner. I will try
> installing on a fujitsu celsius and see how it goes. If I can not
> have this other machine work, then for sure I'll give more of a fight.

I have got a 32core Celsius here that probably has the same problem.

> I do not mind keeping the machine I have been working on as such for
> a while, in case performing extra tests on it could be beneficial to
> anybody.

Maybe putting some sync code back into Linux would be a good idea,
because Xenomai relies on the tsc but does not check it. And that
together with a somewhat softer test with a threshold will probably
work.

That whole topic should probably be discussed in a bigger round, also
having the kernel guys involved.

Henning

> Best
> 
> Vincent
> 
> On 08/09/2016 05:46 PM, Henning Schild wrote:
> > Am Tue, 9 Aug 2016 16:52:55 +0200
> > schrieb Vincent Berenz <vberenz@tuebingen.mpg.de>:
> >  
> >> Here the result of clocktest ...
> >>
> >> I understand that does not look good at all ?
> >>
> >> == Tested clock: 0 (CLOCK_REALTIME)
> >> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> >> --- -------------------- ---------------- ---------- --------------
> >>     1           -1957405.1            0.113        138 596.2
> >>     2           -1961185.1          924.401       1790 10760.2
> >>     3           -1960780.6         1374.628       1785 10346.2
> >>     4           -1959285.8          234.291       1044 8401.9
> >>     5           -1965873.3         -454.507       2145 11733.6
> >>     6           -1958102.2         1207.278        663 7284.3
> >>     7           -1962047.5         -954.835        901 7895.4
> >>     8           -1957405.2          937.974        480 5017.7
> >>     9           -1957405.6           -0.153        264 2322.8
> >>    10           -1963423.0        -1021.867       1424 9269.7
> >>    11           -1962459.0          713.691       2214 11799.1
> >>    12           -1959102.5         1301.214       1173 8746.8
> >>    13           -1961567.4          200.190       1814 10797.3
> >>    14           -1962166.1          823.783       2263 11806.8
> >>    15           -1957581.8         1227.750        564 6986.0
> >>    16           -1959897.2          199.587       1165 9096.1
> >>    17           -1957405.5           59.393        345 4900.3
> >>    18           -1964477.5         -132.414       1467 10216.8
> >>    19           -1965895.2        -1033.341       2511 11886.4
> >>    20           -1957794.4          671.807        743 7384.3
> >>    21           -1962207.5          890.940       2941 11846.1
> >>    22           -1960914.3          873.089       1324 9952.5
> >>    23           -1962340.2          889.721       1860 11568.6  
> > Indeed that does not look good at all. This is an up to 12ms
> > difference between the furthest off core-pair. Task migration or
> > communication across cores will have funny ejects on this machine.
> >
> > Linux used to be able to sync the TSCs cross cores using MSR 0x10,
> > at least that is what this link suggests:
> > https://lwn.net/Articles/211051/
> > I did not go through the kernel mailing list archives or the git
> > repo yet. Why was that code dropped exactly? It probably was never
> > SMI-safe.
> >
> > You should first of all check whether you can get another BIOS for
> > that machine. If you do not mind hacking you could find that MSR
> > 0x10 calibration code again and see how well you can synchronize
> > the TSCs. Or maybe at least find the discussion for the change on
> > lkml for us to look at. I am kind of afraid it will be a very long
> > one ... 
> >> Vincent
> >>
> >> On 08/08/2016 07:11 PM, Henning Schild wrote:  
> >>> Am Mon, 8 Aug 2016 18:21:28 +0200
> >>> schrieb Vincent Berenz <vberenz@tuebingen.mpg.de>:
> >>>     
> >>>> Hi,
> >>>>
> >>>> I set tsc=reliable, and "skipped synchronization checks as TSC is
> >>>> reliable" showed up in the syslog.
> >>>>
> >>>> The machine boots correctly on both the patched and non patched
> >>>> kernel. And in both case everything seems to run fine. On xenomai
> >>>> patched kernel the issues related to the keyboard and glxgears
> >>>> are gone. The latency is still low (between 4 and 20) and our
> >>>> software seems to work well. So, seemingly all good.
> >>>>
> >>>> Anything else I should check or be careful about ?  
> >>> Let's say i did not suggest that parameter as a solution. Linux
> >>> does not do those checks for fun and does not fail them because
> >>> its broken. A comment in the Linux suggests that your BIOS
> >>> programmed the TSC offsets incorrectly, because on your machine
> >>> the test failed for socket-siblings.
> >>>
> >>> If the tests fail at every boot and the values are at the same
> >>> order of magnitude i guess the TSCs are indeed off. You should be
> >>> able to see that with the xenomai clocktest.
> >>>
> >>> Could you please run /usr/lib/xenomai/testsuite/clocktest
> >>> I am guessing you might see "warps" and "max delta [us]" values
> >>> different from 0.
> >>>
> >>> The max delta is how far a tsc based clock reading could jump if
> >>> the process migrated between the cores with that offset. In that
> >>> case processes measuring time could get negative or very high
> >>> outliers.
> >>>
> >>> Henning
> >>>     
> >>>> On 08.08.2016 11:34, Henning Schild wrote:  
> >>>>> Am Fri, 5 Aug 2016 19:13:13 +0200
> >>>>> schrieb Vincent Berenz <vincent.berenz@tuebingen.mpg.de>:
> >>>>>        
> >>>>>> I checked the syslog when booting on the non realtime kernel,
> >>>>>> and indeed the same messages related to TSC showed up. Yet, I
> >>>>>> do not experience any of the issues observed on the patched
> >>>>>> kernel (e.g glxgears or keyboard)
> >>>>>>
> >>>>>> I ran lstopo and lshw and there seem to be 2 sockets with 12
> >>>>>> cores on each.
> >>>>>>        
> >>>>> I have seen this several times across sockets, but in your case
> >>>>> the two CPUs are on the same socket. And i have a 32 core XEON
> >>>>> that also fails the TSC test between 0 and 1 on the same socket.
> >>>>>        
> >>>>>> lstopo
> >>>>>>
> >>>>>> ---
> >>>>>> Machine (126GB)
> >>>>>>      Socket L#0 + L3 L#0 (30MB)
> >>>>>>        L2 L#0 (256KB) + L1d L#0 (32KB) + L1i L#0 (32KB) + Core
> >>>>>> L#0 + PU L#0 (P#0) L2 L#1 (256KB) + L1d L#1 (32KB) + L1i L#1
> >>>>>> (32KB) + Core L#1
> >>>>>> + PU L#1 (P#1) L2 L#2 (256KB) + L1d L#2 (32KB) + L1i L#2
> >>>>>> (32KB) + Core L#2 + PU L#2 (P#2) L2 L#3 (256KB) + L1d L#3
> >>>>>> (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3) L2 L#4
> >>>>>> (256KB) + L1d L#4 (32KB)
> >>>>>> + L1i L#4 (32KB) + Core L#4 + PU L#4 (P#4) L2 L#5 (256KB) + L1d
> >>>>>> L#5 (32KB) + L1i L#5 (32KB) + Core L#5 + PU L#5 (P#5) L2 L#6
> >>>>>> (256KB) + L1d L#6 (32KB) + L1i L#6 (32KB) + Core L#6 + PU L#6
> >>>>>> (P#6) L2 L#7 (256KB) + L1d L#7 (32KB) + L1i L#7 (32KB) + Core
> >>>>>> L#7 + PU L#7 (P#7) L2 L#8 (256KB) + L1d L#8 (32KB) + L1i L#8
> >>>>>> (32KB) + Core L#8 + PU L#8 (P#8) L2 L#9 (256KB) + L1d L#9
> >>>>>> (32KB)
> >>>>>> + L1i L#9 (32KB) + Core L#9 + PU L#9 (P#9) L2 L#10 (256KB) +
> >>>>>> L1d L#10 (32KB) + L1i L#10 (32KB) + Core L#10 + PU L#10 (P#10)
> >>>>>> L2 L#11 (256KB) + L1d L#11 (32KB) + L1i L#11 (32KB) + Core
> >>>>>> L#11 + PU L#11 (P#11) Socket L#1 + L3 L#1 (30MB) L2 L#12
> >>>>>> (256KB) + L1d L#12 (32KB) + L1i L#12 (32KB)
> >>>>>> + Core L#12 + PU L#12 (P#12) L2 L#13 (256KB) + L1d L#13 (32KB)
> >>>>>> + L1i L#13 (32KB) + Core L#13 + PU L#13 (P#13) L2 L#14 (256KB)
> >>>>>> + L1d L#14 (32KB) + L1i L#14 (32KB) + Core L#14 + PU L#14
> >>>>>> (P#14) L2 L#15 (256KB) + L1d L#15 (32KB) + L1i L#15 (32KB) +
> >>>>>> Core L#15
> >>>>>> + PU L#15 (P#15) L2 L#16 (256KB)
> >>>>>> + L1d L#16 (32KB) + L1i L#16 (32KB) + Core L#16 + PU L#16
> >>>>>> (P#16) L2 L#17 (256KB) + L1d L#17 (32KB) + L1i L#17 (32KB) +
> >>>>>> Core L#17
> >>>>>> + PU L#17 (P#17) L2 L#18 (256KB) + L1d L#18 (32KB) + L1i L#18
> >>>>>> (32KB) + Core L#18 + PU L#18 (P#18) L2 L#19 (256KB) + L1d L#19
> >>>>>> (32KB) + L1i L#19 (32KB) + Core L#19 + PU L#19 (P#19) L2 L#20
> >>>>>> (256KB) + L1d L#20 (32KB) + L1i L#20 (32KB) + Core L#20 + PU
> >>>>>> L#20 (P#20) L2 L#21 (256KB)
> >>>>>> + L1d L#21 (32KB) + L1i L#21 (32KB) + Core L#21 + PU L#21
> >>>>>> (P#21) L2 L#22 (256KB) + L1d L#22 (32KB) + L1i L#22 (32KB) +
> >>>>>> Core L#22
> >>>>>> + PU L#22 (P#22) L2 L#23 (256KB) + L1d L#23 (32KB) + L1i L#23
> >>>>>> (32KB) + Core L#23 + PU L#23 (P#23) ---
> >>>>>>
> >>>>>>
> >>>>>> lshw -class processor
> >>>>>>
> >>>>>> ---
> >>>>>>      *-cpu:0
> >>>>>>           description: CPU
> >>>>>>           product: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz
> >>>>>>           vendor: Intel Corp.
> >>>>>>           physical id: 106
> >>>>>>           bus info: cpu@0
> >>>>>>           version: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz
> >>>>>>           slot: SOCKET 1
> >>>>>>           size: 2600MHz
> >>>>>>           capacity: 4GHz
> >>>>>>           width: 64 bits
> >>>>>>           clock: 100MHz
> >>>>>>           capabilities: x86-64 fpu fpu_exception wp vme de pse
> >>>>>> tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36
> >>>>>> clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> >>>>>> pdpe1gb rdtscp constant_tsc arch_perfmon pebs bts rep_good
> >>>>>> nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64
> >>>>>> monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> >>>>>> dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
> >>>>>> xsave avx f16c rdrand lahf_lm abm ida arat epb xsaveopt pln
> >>>>>> pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> >>>>>> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid configuration:
> >>>>>> cores=12 enabledcores=12 threads=24 *-cpu:1 description: CPU
> >>>>>> product: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz vendor:
> >>>>>> Intel Corp. physical id: 11a bus info: cpu@1 version: Intel(R)
> >>>>>> Xeon(R) CPU E5-2690 v3 @ 2.60GHz slot: SOCKET 2 size: 2600MHz
> >>>>>> capacity: 4GHz width: 64 bits clock: 100MHz capabilities:
> >>>>>> x86-64 fpu fpu_exception wp vme de pse tsc msr pae mce cx8
> >>>>>> apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr
> >>>>>> sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp constant_tsc
> >>>>>> arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
> >>>>>> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2
> >>>>>> ssse3 fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe
> >>>>>> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
> >>>>>> abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
> >>>>>> flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
> >>>>>> erms invpcid configuration: cores=12 enabledcores=12
> >>>>>> threads=24 ---
> >>>>>>
> >>>>>> To add the kernel parameter I updated /etc/default/grub to :
> >>>>>>
> >>>>>> ---
> >>>>>> GRUB_CMDLINE_LINUX_DEFAULT="quiet splash
> >>>>>> xeno_nucleus.xenomai_gid=1001
> >>>>>> xeno_hal.supported_cpus=0xfffffffffffffffd" ---
> >>>>>>
> >>>>>> Is that the correct way to do this ?
> >>>>>> Is there a way to check this was effective ? (I attached the
> >>>>>> syslogs, just in case).
> >>>>>>
> >>>>>> Stressing the kernel resulted in :
> >>>>>>
> >>>>>> ---
> >>>>>> [  515.420275] Broke affinity for irq 98
> >>>>>> [  515.421329] kvm: disabling virtualization on CPU1
> >>>>>> [  515.424184] smpboot: CPU 1 is now offline
> >>>>>> [  530.021118] x86: Booting SMP configuration:
> >>>>>> [  530.021121] smpboot: Booting Node 0 Processor 1 APIC 0x2
> >>>>>> [  530.037201] kvm: enabling virtualization on CPU1
> >>>>>> ---  
> >>>>> Sorry, i should have explained that in more detail. The systems
> >>>>> i have seen the problem on do not always fail the TSC sync
> >>>>> test. So the idea is to hotplug a CPU to not have to reboot all
> >>>>> the time. If any CPU pair fails the test during boot you will
> >>>>> not be able to do anything with cpu hotplugging, because the
> >>>>> TSC will be marked unstable already.
> >>>>>
> >>>>> I guess in your case the TSC tests fails all the time on 0 -> 1.
> >>>>> So you do not need the hotplugging to try and reproduce it.
> >>>>>
> >>>>> There is a switch that tells Linux to skip the test and assume
> >>>>> the tsc was stable. "tsc=reliable"
> >>>>> What is the behaviour if you use that? Both in regular Linux and
> >>>>> in the patched kernel. The problem with this guy is that it
> >>>>> skips a test very relevant to Xenomai operation later on.
> >>>>>        
> >>>>>> In case this hardware is not best for xenomai:
> >>>>>> We selected this configuration for the only reason it has lots
> >>>>>> of pci-express slots. We would be happy to switch to any other
> >>>>>> preferred solution. Just in case : would you have by chance
> >>>>>> some recommendation ?  
> >>>>> I do not have a recommendation, but you could try different BIOS
> >>>>> versions for that machine. (up- or downgrade)
> >>>>>           
> >>>>>> Have a nice week end !
> >>>>>>
> >>>>>> Vincent
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On Thu, 4 Aug 2016 16:11:55 +0200
> >>>>>>     Henning Schild <henning.schild@siemens.com> wrote:  
> >>>>>>> Am Thu, 4 Aug 2016 15:23:34 +0200
> >>>>>>> schrieb Vincent Berenz <vincent.berenz@tuebingen.mpg.de>:
> >>>>>>>            
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> Many thanks for the answer.
> >>>>>>>>
> >>>>>>>> We use new hardware. I am working on a recent dell precision
> >>>>>>>> T7910. I did not try to update our older hardware (still in
> >>>>>>>> use).
> >>>>>>>>
> >>>>>>>> Info on the CPU of the new machine:
> >>>>>>>>
> >>>>>>>> -----
> >>>>>>>> processor	: 23
> >>>>>>>> vendor_id	: GenuineIntel
> >>>>>>>> cpu family	: 6
> >>>>>>>> model		: 63
> >>>>>>>> model name	: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz
> >>>>>>>> stepping	: 2
> >>>>>>>> microcode	: 0x36
> >>>>>>>> cpu MHz		: 2594.037
> >>>>>>>> cache size	: 30720 KB
> >>>>>>>> physical id	: 1
> >>>>>>>> siblings	: 12
> >>>>>>>> core id		: 13
> >>>>>>>> cpu cores	: 12
> >>>>>>>> apicid		: 58
> >>>>>>>> initial apicid	: 58
> >>>>>>>> fpu		: yes
> >>>>>>>> fpu_exception	: yes
> >>>>>>>> cpuid level	: 15
> >>>>>>>> wp		: yes
> >>>>>>>> flags		: fpu vme de pse tsc msr pae mce cx8
> >>>>>>>> apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx
> >>>>>>>> fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm
> >>>>>>>> constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> >>>>>>>> nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
> >>>>>>>> vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid dca sse4_1
> >>>>>>>> sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> >>>>>>>> f16c rdrand lahf_lm abm ida arat epb xsaveopt pln pts dtherm
> >>>>>>>> tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust
> >>>>>>>> bmi1 avx2 smep bmi2 erms invpcid bogomips	: 5189.70
> >>>>>>>> clflush size	: 64 cache_alignment	: 64 address
> >>>>>>>> sizes	: 46 bits physical, 48 bits virtual power
> >>>>>>>> management: -----
> >>>>>>>>
> >>>>>>>> There are 24 processors and I had to update the config
> >>>>>>>> file:  
> >>>>>>> That is a big machine. Are cpu0 and cpu1 on different sockets?
> >>>>>>> (lstopo) Linux detects a problem with the TSCs of the two
> >>>>>>> cores not beeing in sync, that should be unrelated to Xenomai
> >>>>>>> and should also happen on your Distro-Kernel.
> >>>>>>>
> >>>>>>> You can stress the Linux-Kernel code that generated that
> >>>>>>> message with offlining/onlining the CPU.
> >>>>>>>
> >>>>>>> For your case "TSC synchronization [CPU#0 -> CPU#1]" you want
> >>>>>>> to offline CPU1 and online it from CPU0.
> >>>>>>>
> >>>>>>> # make sure online comes from CPU0
> >>>>>>> taskset 0x1 bash
> >>>>>>> # offline CPU1
> >>>>>>> echo 0 >  /sys/devices/system/cpu/cpu1/online
> >>>>>>> # online CPU1
> >>>>>>> echo 1 >  /sys/devices/system/cpu/cpu1/online
> >>>>>>>
> >>>>>>> Doing that on a xenomai enabled kernel you will have to
> >>>>>>> exclude the CPU in question from xenomai. In your case add
> >>>>>>> the following kernel parameter
> >>>>>>> "xeno_hal.supported_cpus=0xfffffffffffffffd".
> >>>>>>>
> >>>>>>> I am guessing you will be able to reproduce this
> >>>>>>>            
> >>>>>>>>>> [    0.109150] TSC synchronization [CPU#0 -> CPU#1]:
> >>>>>>>>>> [    0.109157] Measured 25802382 cycles TSC warp between
> >>>>>>>>>> CPUs, turning off TSC clock. [    0.109161] tsc: Marking
> >>>>>>>>>> TSC unstable  
> >>>>>>> on a xenomai kernel and a regular kernel. I would be
> >>>>>>> interested in the results.
> >>>>>>> In the worst case the TSC of your machine can indeed not be
> >>>>>>> trusted.  
> >>>>>>>> ---
> >>>>>>>> CONFIG_XENO_OPT_PIPE_NRDEV=32
> >>>>>>>> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=1024
> >>>>>>>> CONFIG_XENO_OPT_SYS_HEAPSZ=32768
> >>>>>>>> CONFIG_XENO_OPT_SYS_STACKPOOLSZ=4096
> >>>>>>>> ---
> >>>>>>>>
> >>>>>>>> Best
> >>>>>>>>
> >>>>>>>> Vincent
> >>>>>>>>
> >>>>>>>> On Thu, 4 Aug 2016 14:17:44 +0200
> >>>>>>>>     Henning Schild <henning.schild@siemens.com> wrote:  
> >>>>>>>>> Am Wed, 3 Aug 2016 12:12:51 +0200
> >>>>>>>>> schrieb Vincent Berenz <vincent.berenz@tuebingen.mpg.de>:
> >>>>>>>>>              
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> After using for years xenomai 2.5.6 on ubuntu 12.04, we
> >>>>>>>>>> decided to upgrade to ubuntu 14.04 and a newer machine. I
> >>>>>>>>>> installed xenomai 2.6.4 and kernel 3.14.39. The
> >>>>>>>>>> installation boots correctly, the latency is low and our
> >>>>>>>>>> software seems to work ok.
> >>>>>>>>>>
> >>>>>>>>>> But the system has "frequency surge" (I could not find
> >>>>>>>>>> better wording). For example:
> >>>>>>>>>>
> >>>>>>>>>> - sometime when typing on the keyboard, the pressed key is
> >>>>>>>>>> printed many times ('aaaaaaaa' instead of 'a')
> >>>>>>>>>>
> >>>>>>>>>> - 'glxgears' has change in frame rates, the gears can be
> >>>>>>>>>> seen as sometime changing speed. For example:
> >>>>>>>>>>
> >>>>>>>>>> ---
> >>>>>>>>>> 1141 frames in 5.0 seconds = 228.186 FPS
> >>>>>>>>>> 1024 frames in 5.0 seconds = 204.787 FPS
> >>>>>>>>>> 506 frames in 5.0 seconds = 101.194 FPS
> >>>>>>>>>> 482 frames in 5.0 seconds = 96.317 FPS
> >>>>>>>>>> 1416 frames in 5.0 seconds = 283.182 FPS
> >>>>>>>>>> 2614 frames in 5.0 seconds = 521.100 FPS
> >>>>>>>>>> 2618 frames in 5.0 seconds = 522.314 FPS
> >>>>>>>>>> 3073 frames in 5.0 seconds = 614.562 FPS
> >>>>>>>>>> ---
> >>>>>>>>>>
> >>>>>>>>>> All the tests run fine (as far as I could tell) with the
> >>>>>>>>>> notable exception of tsc which sometimes (not always)
> >>>>>>>>>> terminates with something like:
> >>>>>>>>>>
> >>>>>>>>>> ---
> >>>>>>>>>> tsc not monotonic after 7430687798 ticks, jumped back
> >>>>>>>>>> 49567650 tick ---
> >>>>>>>>>>
> >>>>>>>>>> I could find this in the syslog:
> >>>>>>>>>>
> >>>>>>>>>> -------
> >>>>>>>>>> [    0.092932] TSC deadline timer enabled
> >>>>>>>>>> [    0.092941] Performance Events: PEBS fmt2+, 16-deep LBR,
> >>>>>>>>>> Haswell events, full-width counters, Intel PMU driver.
> >>>>>>>>>> [    0.092961] ... version:                3
> >>>>>>>>>> [    0.092962] ... bit width: 48 [    0.092963] ... generic
> >>>>>>>>>> registers:      4 [    0.092964] ... value mask:
> >>>>>>>>>> 0000ffffffffffff [    0.092965] ... max period:
> >>>>>>>>>> 0000ffffffffffff [    0.092965] ... fixed-purpose
> >>>>>>>>>> events:   3 [    0.092966] ... event mask:
> >>>>>>>>>> 000000070000000f [    0.094914] x86: Booting SMP
> >>>>>>>>>> configuration: [    0.094916] .... node  #0, CPUs:
> >>>>>>>>>> #1 [    0.109150] TSC synchronization [CPU#0 -> CPU#1]:
> >>>>>>>>>> [    0.109157] Measured 25802382 cycles TSC warp between
> >>>>>>>>>> CPUs, turning off TSC clock. [    0.109161] tsc: Marking
> >>>>>>>>>> TSC unstable due to check_tsc_sync_source failed
> >>>>>>>>>> ---------  
> >>>>>>>>> I have seen this message before, but with smaller numbers.
> >>>>>>>>>
> >>>>>>>>> I assume you have not changed the Hardware, which versions
> >>>>>>>>> of Xenomai and the Kernel did you use before? Trying to
> >>>>>>>>> find out whether these checks did not trigger before
> >>>>>>>>> because they did not exist or where different in your old
> >>>>>>>>> setup. 
> >>>>>>>>>> Best
> >>>>>>>>>>
> >>>>>>>>>> Vincent
> >>>>>>>>>> -------------- next part --------------
> >>>>>>>>>> A non-text attachment was scrubbed...
> >>>>>>>>>> Name: config
> >>>>>>>>>> Type: application/octet-stream
> >>>>>>>>>> Size: 162268 bytes
> >>>>>>>>>> Desc: not available
> >>>>>>>>>> URL:
> >>>>>>>>>> <http://xenomai.org/pipermail/xenomai/attachments/20160803/26bc2e90/attachment.obj>
> >>>>>>>>>> -------------- next part -------------- An embedded and
> >>>>>>>>>> charset-unspecified text was scrubbed... Name:
> >>>>>>>>>> dmesg_xeno.txt URL:
> >>>>>>>>>> <http://xenomai.org/pipermail/xenomai/attachments/20160803/26bc2e90/attachment.txt>
> >>>>>>>>>> _______________________________________________ Xenomai
> >>>>>>>>>> mailing list Xenomai@xenomai.org
> >>>>>>>>>> https://xenomai.org/mailman/listinfo/xenomai  
> >>>>>>>>>              
> >>>>>>>>            
> >>>>>>>            
> 


