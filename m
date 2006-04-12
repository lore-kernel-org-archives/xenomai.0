Subject: Re: [Xenomai-help] question about the latency test running on	Blackfin
From: adam li <yi.li@domain.hid>
In-Reply-To: <443CB06C.2080202@domain.hid>
References: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>
	<1144294706.12272.32.camel@domain.hid>  <4434BDBD.9060102@domain.hid>
	<1144412822.21632.10.camel@domain.hid>  <44365CFA.1020506@domain.hid>
	<1144809772.7286.47.camel@domain.hid>  <443CB06C.2080202@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Apr 2006 20:28:16 +0800
Message-Id: <1144844898.7808.34.camel@domain.hid>
Mime-Version: 1.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Thanks for the suggestions. 

I am using Blackfin 533 on the STAMP board. The core frequency is 398
MHz.These data are got when there is not special workload, only uClinux
running.

I tried to run "latency" test in Mode 0 (user space task) for 60 sec,
with the "calibrator" as work load, this time the worst case schedule
latency becomes 82 us. 

As you mentioned:

">Yes, Xenomai is a hard-RT system. But this doesn't depend on a
specific
> worst-case latency number, rather on the fact that a hardware-dependent
> upper limit can be provided that is independent of the (here:) Linux load"

Can I understand like this: Given the hardware and the workload, the
upper limit (worst case latency) is "determinative", regardless of what
is happening in Linux?

But still another confusion, as we can see from the test result, given
the hardware and the workload, each time running the "latency" test case
will result in an average latency and a worst case value, but how can we
"make sure" that using such hardware and such workload, the worst case
latency is "sure" to bellow certain upper limit? In other words, is it
possible that in some case, the worst case latency may go beyond the
observed upper limit? Or can I say that, there is such possibility, but
the probability is rare (statistically).

Thanks,
-Li Yi


 




On Wed, 2006-04-12 at 09:46 +0200, Jan Kiszka wrote:
> Li Yi wrote:
> > Hi Philippe,
> > 
> > According to your answers, I updated the document on Xenomai on
> > Blackfin: (http://docs.blackfin.uclinux.org/doku.php?id=adeos) with the
> > test result of different modes, setting  XENO_OPT_TIMING_SCHEDLAT = 1.
> > But I still have some question about the test result, hoping for your
> > help:
> > 
> > When running this test in mode 0, the worst case latency is 65 us, (HSD|
> > max| 65 - 66 | 1). This result is get when there is no workload. Can I
> > say this system is "Hard Real-time" because most of the latency samples
> > are in a  limited range?  
> 
> Soft RT: the more samples remain under the required limit the higher is
>          the quality of the system
> 
> Hard RT: ALL samples must be below the limit
> 
> So, for hard RT, those 65 us is the interesting number. How did you
> create the system load? Typical tests contain some cache benchmarking
> tool (I prefer calibrator: http://www.cwi.nl/~manegold/Calibrator) +
> network load (e.g. ping -f) + hard disk or other persistent storage
> access (e.g. dd if=<your-disk> of=/dev/null).
> 
> How much MHz does your board have, and to what can it be compared when
> looking at other architectures. 65 us looks quite (too?) good for
> low-end, but maybe the blackfin isn't actually low-end.
> 
> > 
> > That is, from the test result:
> > HSS|    min|        59|     31.746|      0.632
> > HSS|    avg|    599965|     33.365|      2.151
> > HSS|    max|        59|     53.339|      2.739
> > 
> > Can I make the conclusion that the schedule latency is "determinative" and the system is "hard real-time"? If not,
> > what is the expected test result? Xenomai is able to provide hard real-time, right?
> 
> Yes, Xenomai is a hard-RT system. But this doesn't depend on a specific
> worst-case latency number, rather on the fact that a hardware-dependent
> upper limit can be provided that is independent of the (here:) Linux load.
> 
> Jan
> 

