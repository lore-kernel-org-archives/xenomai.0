Date: Mon, 8 Aug 2016 11:34:21 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160808113421.5ce17aaa@md1em3qc>
In-Reply-To: <web-9079189@tuebingen.mpg.de>
References: <web-9034838@tuebingen.mpg.de> <20160804141744.3adbe573@md1em3qc>
 <web-9059594@tuebingen.mpg.de> <20160804161155.382df26e@md1em3qc>
 <web-9079189@tuebingen.mpg.de>
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
To: Vincent Berenz <vincent.berenz@tuebingen.mpg.de>
Cc: xenomai@xenomai.org

Am Fri, 5 Aug 2016 19:13:13 +0200
schrieb Vincent Berenz <vincent.berenz@tuebingen.mpg.de>:

> I checked the syslog when booting on the non realtime kernel, and
> indeed the same messages related to TSC showed up. Yet, I do not
> experience any of the issues observed on the patched kernel (e.g
> glxgears or keyboard)
> 
> I ran lstopo and lshw and there seem to be 2 sockets with 12 cores on
> each.
> 

I have seen this several times across sockets, but in your case the two
CPUs are on the same socket. And i have a 32 core XEON that also fails
the TSC test between 0 and 1 on the same socket.

> lstopo
> 
> ---
> Machine (126GB)
>   Socket L#0 + L3 L#0 (30MB)
>     L2 L#0 (256KB) + L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU
> L#0 (P#0) L2 L#1 (256KB) + L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1
> + PU L#1 (P#1) L2 L#2 (256KB) + L1d L#2 (32KB) + L1i L#2 (32KB) +
> Core L#2 + PU L#2 (P#2) L2 L#3 (256KB) + L1d L#3 (32KB) + L1i L#3
> (32KB) + Core L#3 + PU L#3 (P#3) L2 L#4 (256KB) + L1d L#4 (32KB) +
> L1i L#4 (32KB) + Core L#4 + PU L#4 (P#4) L2 L#5 (256KB) + L1d L#5
> (32KB) + L1i L#5 (32KB) + Core L#5 + PU L#5 (P#5) L2 L#6 (256KB) +
> L1d L#6 (32KB) + L1i L#6 (32KB) + Core L#6 + PU L#6 (P#6) L2 L#7
> (256KB) + L1d L#7 (32KB) + L1i L#7 (32KB) + Core L#7 + PU L#7 (P#7)
> L2 L#8 (256KB) + L1d L#8 (32KB) + L1i L#8 (32KB) + Core L#8 + PU L#8
> (P#8) L2 L#9 (256KB) + L1d L#9 (32KB) + L1i L#9 (32KB) + Core L#9 +
> PU L#9 (P#9) L2 L#10 (256KB) + L1d L#10 (32KB) + L1i L#10 (32KB) +
> Core L#10 + PU L#10 (P#10) L2 L#11 (256KB) + L1d L#11 (32KB) + L1i
> L#11 (32KB) + Core L#11 + PU L#11 (P#11) Socket L#1 + L3 L#1 (30MB)
> L2 L#12 (256KB) + L1d L#12 (32KB) + L1i L#12 (32KB) + Core L#12 + PU
> L#12 (P#12) L2 L#13 (256KB) + L1d L#13 (32KB) + L1i L#13 (32KB) +
> Core L#13 + PU L#13 (P#13) L2 L#14 (256KB) + L1d L#14 (32KB) + L1i
> L#14 (32KB) + Core L#14 + PU L#14 (P#14) L2 L#15 (256KB) + L1d L#15
> (32KB) + L1i L#15 (32KB) + Core L#15 + PU L#15 (P#15) L2 L#16 (256KB)
> + L1d L#16 (32KB) + L1i L#16 (32KB) + Core L#16 + PU L#16 (P#16) L2
> L#17 (256KB) + L1d L#17 (32KB) + L1i L#17 (32KB) + Core L#17 + PU
> L#17 (P#17) L2 L#18 (256KB) + L1d L#18 (32KB) + L1i L#18 (32KB) +
> Core L#18 + PU L#18 (P#18) L2 L#19 (256KB) + L1d L#19 (32KB) + L1i
> L#19 (32KB) + Core L#19 + PU L#19 (P#19) L2 L#20 (256KB) + L1d L#20
> (32KB) + L1i L#20 (32KB) + Core L#20 + PU L#20 (P#20) L2 L#21 (256KB)
> + L1d L#21 (32KB) + L1i L#21 (32KB) + Core L#21 + PU L#21 (P#21) L2
> L#22 (256KB) + L1d L#22 (32KB) + L1i L#22 (32KB) + Core L#22 + PU
> L#22 (P#22) L2 L#23 (256KB) + L1d L#23 (32KB) + L1i L#23 (32KB) +
> Core L#23 + PU L#23 (P#23) ---
> 
> 
> lshw -class processor
> 
> ---
>   *-cpu:0                 
>        description: CPU
>        product: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz
>        vendor: Intel Corp.
>        physical id: 106
>        bus info: cpu@0
>        version: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz
>        slot: SOCKET 1
>        size: 2600MHz
>        capacity: 4GHz
>        width: 64 bits
>        clock: 100MHz
>        capabilities: x86-64 fpu fpu_exception wp vme de pse tsc msr
> pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx
> fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp constant_tsc
> arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf
> pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16
> xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid configuration:
> cores=12 enabledcores=12 threads=24 *-cpu:1 description: CPU product:
> Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz vendor: Intel Corp.
> physical id: 11a bus info: cpu@1 version: Intel(R) Xeon(R) CPU
> E5-2690 v3 @ 2.60GHz slot: SOCKET 2 size: 2600MHz capacity: 4GHz
> width: 64 bits clock: 100MHz
>        capabilities: x86-64 fpu fpu_exception wp vme de pse tsc msr
> pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx
> fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp constant_tsc
> arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf
> pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16
> xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid configuration:
> cores=12 enabledcores=12 threads=24 ---
> 
> To add the kernel parameter I updated /etc/default/grub to :
> 
> ---
> GRUB_CMDLINE_LINUX_DEFAULT="quiet splash
> xeno_nucleus.xenomai_gid=1001
> xeno_hal.supported_cpus=0xfffffffffffffffd" ---
> 
> Is that the correct way to do this ?
> Is there a way to check this was effective ? (I attached the syslogs,
> just in case).
> 
> Stressing the kernel resulted in :
> 
> ---
> [  515.420275] Broke affinity for irq 98
> [  515.421329] kvm: disabling virtualization on CPU1
> [  515.424184] smpboot: CPU 1 is now offline
> [  530.021118] x86: Booting SMP configuration:
> [  530.021121] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [  530.037201] kvm: enabling virtualization on CPU1
> ---

Sorry, i should have explained that in more detail. The systems i have
seen the problem on do not always fail the TSC sync test. So the idea is
to hotplug a CPU to not have to reboot all the time. If any CPU pair
fails the test during boot you will not be able to do anything with cpu
hotplugging, because the TSC will be marked unstable already.

I guess in your case the TSC tests fails all the time on 0 -> 1. So you
do not need the hotplugging to try and reproduce it.

There is a switch that tells Linux to skip the test and assume the tsc
was stable. "tsc=reliable"
What is the behaviour if you use that? Both in regular Linux and in
the patched kernel. The problem with this guy is that it skips a test
very relevant to Xenomai operation later on.

> In case this hardware is not best for xenomai:
> We selected this configuration for the only reason it has lots of
> pci-express slots. We would be happy to switch to any other preferred
> solution. Just in case : would you have by chance some
> recommendation ?

I do not have a recommendation, but you could try different BIOS
versions for that machine. (up- or downgrade)
 
> 
> Have a nice week end !
> 
> Vincent
> 
> 
> 
> 
> 
> 
> On Thu, 4 Aug 2016 16:11:55 +0200
>  Henning Schild <henning.schild@siemens.com> wrote:
> > Am Thu, 4 Aug 2016 15:23:34 +0200
> > schrieb Vincent Berenz <vincent.berenz@tuebingen.mpg.de>:
> >   
> > > Hi,
> > > 
> > > Many thanks for the answer.
> > > 
> > > We use new hardware. I am working on a recent dell precision
> > > T7910. I did not try to update our older hardware (still in use).
> > > 
> > > Info on the CPU of the new machine:
> > > 
> > > -----
> > > processor	: 23
> > > vendor_id	: GenuineIntel
> > > cpu family	: 6
> > > model		: 63
> > > model name	: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz
> > > stepping	: 2
> > > microcode	: 0x36
> > > cpu MHz		: 2594.037
> > > cache size	: 30720 KB
> > > physical id	: 1
> > > siblings	: 12
> > > core id		: 13
> > > cpu cores	: 12
> > > apicid		: 58
> > > initial apicid	: 58
> > > fpu		: yes
> > > fpu_exception	: yes
> > > cpuid level	: 15
> > > wp		: yes
> > > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep
> > > mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
> > > ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon
> > > pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni
> > > pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16
> > > xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt
> > > tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat
> > > epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> > > fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
> > > bogomips	: 5189.70 clflush size	: 64
> > > cache_alignment	: 64 address sizes	: 46 bits
> > > physical, 48 bits virtual power management: -----
> > > 
> > > There are 24 processors and I had to update the config file:  
> > 
> > That is a big machine. Are cpu0 and cpu1 on different sockets?
> > (lstopo) Linux detects a problem with the TSCs of the two cores not
> > beeing in sync, that should be unrelated to Xenomai and should also
> > happen on your Distro-Kernel.
> > 
> > You can stress the Linux-Kernel code that generated that message
> > with offlining/onlining the CPU.
> > 
> > For your case "TSC synchronization [CPU#0 -> CPU#1]" you want to
> > offline CPU1 and online it from CPU0.
> > 
> > # make sure online comes from CPU0
> > taskset 0x1 bash
> > # offline CPU1
> > echo 0 >  /sys/devices/system/cpu/cpu1/online
> > # online CPU1
> > echo 1 >  /sys/devices/system/cpu/cpu1/online
> > 
> > Doing that on a xenomai enabled kernel you will have to exclude the
> > CPU in question from xenomai. In your case add the following kernel
> > parameter "xeno_hal.supported_cpus=0xfffffffffffffffd".
> > 
> > I am guessing you will be able to reproduce this 
> >   
> > > > > [    0.109150] TSC synchronization [CPU#0 -> CPU#1]:
> > > > > [    0.109157] Measured 25802382 cycles TSC warp between CPUs,
> > > > > turning off TSC clock. [    0.109161] tsc: Marking TSC
> > > > > unstable  
> > 
> > on a xenomai kernel and a regular kernel. I would be interested in
> > the results.
> > In the worst case the TSC of your machine can indeed not be trusted.
> >   
> > > ---
> > > CONFIG_XENO_OPT_PIPE_NRDEV=32
> > > CONFIG_XENO_OPT_REGISTRY_NRSLOTS=1024
> > > CONFIG_XENO_OPT_SYS_HEAPSZ=32768
> > > CONFIG_XENO_OPT_SYS_STACKPOOLSZ=4096
> > > ---
> > > 
> > > Best
> > > 
> > > Vincent
> > > 
> > > On Thu, 4 Aug 2016 14:17:44 +0200
> > >  Henning Schild <henning.schild@siemens.com> wrote:  
> > > > Am Wed, 3 Aug 2016 12:12:51 +0200
> > > > schrieb Vincent Berenz <vincent.berenz@tuebingen.mpg.de>:
> > > >     
> > > > > Hi,
> > > > > 
> > > > > After using for years xenomai 2.5.6 on ubuntu 12.04, we
> > > > > decided to upgrade to ubuntu 14.04 and a newer machine. I
> > > > > installed xenomai 2.6.4 and kernel 3.14.39. The installation
> > > > > boots correctly, the latency is low and our software seems to
> > > > > work ok.
> > > > > 
> > > > > But the system has "frequency surge" (I could not find better
> > > > > wording). For example:
> > > > > 
> > > > > - sometime when typing on the keyboard, the pressed key is
> > > > > printed many times ('aaaaaaaa' instead of 'a')
> > > > > 
> > > > > - 'glxgears' has change in frame rates, the gears can be seen
> > > > > as sometime changing speed. For example:
> > > > > 
> > > > > ---
> > > > > 1141 frames in 5.0 seconds = 228.186 FPS
> > > > > 1024 frames in 5.0 seconds = 204.787 FPS
> > > > > 506 frames in 5.0 seconds = 101.194 FPS
> > > > > 482 frames in 5.0 seconds = 96.317 FPS
> > > > > 1416 frames in 5.0 seconds = 283.182 FPS
> > > > > 2614 frames in 5.0 seconds = 521.100 FPS
> > > > > 2618 frames in 5.0 seconds = 522.314 FPS
> > > > > 3073 frames in 5.0 seconds = 614.562 FPS
> > > > > ---
> > > > > 
> > > > > All the tests run fine (as far as I could tell) with the
> > > > > notable exception of tsc which sometimes (not always)
> > > > > terminates with something like:
> > > > > 
> > > > > ---
> > > > > tsc not monotonic after 7430687798 ticks, jumped back 49567650
> > > > > tick ---
> > > > > 
> > > > > I could find this in the syslog:
> > > > > 
> > > > > -------
> > > > > [    0.092932] TSC deadline timer enabled
> > > > > [    0.092941] Performance Events: PEBS fmt2+, 16-deep LBR,
> > > > > Haswell events, full-width counters, Intel PMU driver.
> > > > > [    0.092961] ... version:                3
> > > > > [    0.092962] ... bit width: 48 [    0.092963] ... generic
> > > > > registers:      4 [    0.092964] ... value mask:
> > > > > 0000ffffffffffff [    0.092965] ... max period:
> > > > > 0000ffffffffffff [    0.092965] ... fixed-purpose events:   3
> > > > > [    0.092966] ... event mask:             000000070000000f
> > > > > [    0.094914] x86: Booting SMP configuration:
> > > > > [    0.094916] .... node  #0, CPUs:        #1
> > > > > [    0.109150] TSC synchronization [CPU#0 -> CPU#1]:
> > > > > [    0.109157] Measured 25802382 cycles TSC warp between CPUs,
> > > > > turning off TSC clock. [    0.109161] tsc: Marking TSC
> > > > > unstable due to check_tsc_sync_source failed ---------    
> > > > 
> > > > I have seen this message before, but with smaller numbers.
> > > > 
> > > > I assume you have not changed the Hardware, which versions of
> > > > Xenomai and the Kernel did you use before? Trying to find out
> > > > whether these checks did not trigger before because they did not
> > > > exist or where different in your old setup.
> > > >     
> > > > > Best
> > > > > 
> > > > > Vincent
> > > > > -------------- next part --------------
> > > > > A non-text attachment was scrubbed...
> > > > > Name: config
> > > > > Type: application/octet-stream
> > > > > Size: 162268 bytes
> > > > > Desc: not available
> > > > > URL:
> > > > > <http://xenomai.org/pipermail/xenomai/attachments/20160803/26bc2e90/attachment.obj>
> > > > > -------------- next part -------------- An embedded and
> > > > > charset-unspecified text was scrubbed... Name: dmesg_xeno.txt
> > > > > URL:
> > > > > <http://xenomai.org/pipermail/xenomai/attachments/20160803/26bc2e90/attachment.txt>
> > > > > _______________________________________________ Xenomai
> > > > > mailing list Xenomai@xenomai.org
> > > > > https://xenomai.org/mailman/listinfo/xenomai    
> > > >     
> > >   
> >   
> 


