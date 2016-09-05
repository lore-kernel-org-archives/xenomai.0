Date: Mon, 5 Sep 2016 10:54:37 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160905105437.06f5bea8@md1em3qc>
In-Reply-To: <20160819182233.157a97f1@md1em3qc>
References: <web-9034838@tuebingen.mpg.de> <20160804141744.3adbe573@md1em3qc>
 <web-9059594@tuebingen.mpg.de> <20160819182233.157a97f1@md1em3qc>
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

Vincent,

did you have a chance to try the mentioned patch? It should allow you
to use the machine you wanted to use from the start.
While it might need some more work to get something like this mainline,
i think it is worth trying. But for that to work we need to collect
more information and try such a tsc-sync patch on different
affected systems.

Henning

Am Fri, 19 Aug 2016 18:22:33 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Thu, 4 Aug 2016 15:23:34 +0200
> schrieb Vincent Berenz <vincent.berenz@tuebingen.mpg.de>:
> 
> > Hi,
> > 
> > Many thanks for the answer.
> > 
> > We use new hardware. I am working on a recent dell precision T7910.
> > I did not try to update our older hardware (still in use).
> > 
> > Info on the CPU of the new machine:
> > 
> > -----
> > processor	: 23
> > vendor_id	: GenuineIntel
> > cpu family	: 6
> > model		: 63
> > model name	: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz
> > stepping	: 2
> > microcode	: 0x36
> > cpu MHz		: 2594.037
> > cache size	: 30720 KB
> > physical id	: 1
> > siblings	: 12
> > core id		: 13
> > cpu cores	: 12
> > apicid		: 58
> > initial apicid	: 58
> > fpu		: yes
> > fpu_exception	: yes
> > cpuid level	: 15
> > wp		: yes
> > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep
> > mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
> > tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs
> > bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq
> > dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> > dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave
> > avx f16c rdrand lahf_lm abm ida arat epb xsaveopt pln pts dtherm
> > tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
> > smep bmi2 erms invpcid bogomips	: 5189.70 clflush
> > size	: 64 cache_alignment	: 64 address sizes	:
> > 46 bits physical, 48 bits virtual power management: -----
> > 
> > There are 24 processors and I had to update the config file:  
> 
> This Xeon might have an erratum as described in this thread on lkml
> https://lkml.org/lkml/2015/11/9/639
> 
> Eventually they figured out that the TSC adjust MSR on core 0 was set
> up by the BIOS or something before Linux. And that made the discussion
> stop without a general solution.
> 
> I am seeing 0->1 offsets on a "Xeon E5-2687W v2" and this CPU does not
> even support MSR 0x3b.
> 
> Does your machine support TSC adjustment?
> $ grep tsc_adjust /proc/cpuinfo
> If so are offsets programmed?
> # modprobe msr
> # rdmsr -a 0x3b
> 
> You could try that patch (unconditional set_cpu_bug) in combination
> with "tsc=reliable" and see what the clocktest says. That is close to
> suggestions 1. from the "dealing with non-synchronized TSCs in
> Xenomai" Mail i sent.
> On my Xeon i got to TSCs that where at most 800 ticks apart, which
> might just be good enough.
> 
> 
> > ---
> > CONFIG_XENO_OPT_PIPE_NRDEV=32
> > CONFIG_XENO_OPT_REGISTRY_NRSLOTS=1024
> > CONFIG_XENO_OPT_SYS_HEAPSZ=32768
> > CONFIG_XENO_OPT_SYS_STACKPOOLSZ=4096
> > ---
> > 
> > Best
> > 
> > Vincent
> > 
> > On Thu, 4 Aug 2016 14:17:44 +0200
> >  Henning Schild <henning.schild@siemens.com> wrote:  
> > > Am Wed, 3 Aug 2016 12:12:51 +0200
> > > schrieb Vincent Berenz <vincent.berenz@tuebingen.mpg.de>:
> > >     
> > > > Hi,
> > > > 
> > > > After using for years xenomai 2.5.6 on ubuntu 12.04, we decided
> > > > to upgrade to ubuntu 14.04 and a newer machine. I installed
> > > > xenomai 2.6.4 and kernel 3.14.39. The installation boots
> > > > correctly, the latency is low and our software seems to work ok.
> > > > 
> > > > But the system has "frequency surge" (I could not find better
> > > > wording). For example:
> > > > 
> > > > - sometime when typing on the keyboard, the pressed key is
> > > > printed many times ('aaaaaaaa' instead of 'a')
> > > > 
> > > > - 'glxgears' has change in frame rates, the gears can be seen as
> > > > sometime changing speed. For example:
> > > > 
> > > > ---
> > > > 1141 frames in 5.0 seconds = 228.186 FPS
> > > > 1024 frames in 5.0 seconds = 204.787 FPS
> > > > 506 frames in 5.0 seconds = 101.194 FPS
> > > > 482 frames in 5.0 seconds = 96.317 FPS
> > > > 1416 frames in 5.0 seconds = 283.182 FPS
> > > > 2614 frames in 5.0 seconds = 521.100 FPS
> > > > 2618 frames in 5.0 seconds = 522.314 FPS
> > > > 3073 frames in 5.0 seconds = 614.562 FPS
> > > > ---
> > > > 
> > > > All the tests run fine (as far as I could tell) with the notable
> > > > exception of tsc which sometimes (not always) terminates with
> > > > something like:
> > > > 
> > > > ---
> > > > tsc not monotonic after 7430687798 ticks, jumped back 49567650
> > > > tick ---
> > > > 
> > > > I could find this in the syslog:
> > > > 
> > > > -------
> > > > [    0.092932] TSC deadline timer enabled
> > > > [    0.092941] Performance Events: PEBS fmt2+, 16-deep LBR,
> > > > Haswell events, full-width counters, Intel PMU driver.
> > > > [    0.092961] ... version:                3 [    0.092962] ...
> > > > bit width: 48 [    0.092963] ... generic registers:      4
> > > > [    0.092964] ... value mask:             0000ffffffffffff
> > > > [    0.092965] ... max period:             0000ffffffffffff
> > > > [    0.092965] ... fixed-purpose events:   3
> > > > [    0.092966] ... event mask:             000000070000000f
> > > > [    0.094914] x86: Booting SMP configuration:
> > > > [    0.094916] .... node  #0, CPUs:        #1
> > > > [    0.109150] TSC synchronization [CPU#0 -> CPU#1]:
> > > > [    0.109157] Measured 25802382 cycles TSC warp between CPUs,
> > > > turning off TSC clock. [    0.109161] tsc: Marking TSC unstable
> > > > due to check_tsc_sync_source failed ---------    
> > > 
> > > I have seen this message before, but with smaller numbers.
> > > 
> > > I assume you have not changed the Hardware, which versions of
> > > Xenomai and the Kernel did you use before? Trying to find out
> > > whether these checks did not trigger before because they did not
> > > exist or where different in your old setup.
> > >     
> > > > Best
> > > > 
> > > > Vincent
> > > > -------------- next part --------------
> > > > A non-text attachment was scrubbed...
> > > > Name: config
> > > > Type: application/octet-stream
> > > > Size: 162268 bytes
> > > > Desc: not available
> > > > URL:
> > > > <http://xenomai.org/pipermail/xenomai/attachments/20160803/26bc2e90/attachment.obj>
> > > > -------------- next part -------------- An embedded and
> > > > charset-unspecified text was scrubbed... Name: dmesg_xeno.txt
> > > > URL:
> > > > <http://xenomai.org/pipermail/xenomai/attachments/20160803/26bc2e90/attachment.txt>
> > > > _______________________________________________ Xenomai mailing
> > > > list Xenomai@xenomai.org
> > > > https://xenomai.org/mailman/listinfo/xenomai    
> > >     
> >   
> 


