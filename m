From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DFF664C.5030504@domain.hid>
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>
	<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>
	<4DFBA463.3090902@domain.hid>	<4DFBAEB9.8060106@domain.hid>
	<4DFBB08B.5020005@domain.hid>	<4DFCC18F.3060207@domain.hid>
	<BANLkTin00xA-LMikumq1C4_nFyFbCdgi+Q@mail.gmail.com>
	<4DFF610F.5070602@domain.hid>  <4DFF664C.5030504@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Jun 2011 18:16:29 +0200
Message-ID: <1308586589.2119.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Mon, 2011-06-20 at 16:25 +0100, Jakub Nowacki wrote:
> On 06/20/2011 04:02 PM, Gilles Chanteperdrix wrote:
> > To make proper benchmarks, you should:
> > - let the latency run long
> > - provide some load, you can use the dohell script in xenomai-head to
> > generate the load.
> >
> I've generated a load using 'dd if=/dev/zero of=/dev/null' one for each 
> core (8 in total), which is roughly the way how xeno-test does it. The 
> test was running for 30 min, which is not very long but I should see the 
> long latencies by that time, I think at least.
> 
> > That said, having some spikes is not abnormal. The real question is to
> > know whether the latencies your get are sufficient for your application.
> >
> Well, I think it should be OK for peak latencies < 20 us, that is what 
> I'm getting now.
> 
> >> ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
> >
> > You have to increase CONFIG_XENO_OPT_SYS_STACKPOOLSZ.
> >
> It is 128 Kb now. Should it be more? Is there any (thumb) rule for this 
> value?

Max # of concurrent kernel-based Xenomai threads x stack_size. 8k stack
minimum is a safe bet for x86_64.

Typically, RTDM (driver) tasks in kernel space are Xenomai ones, so you
would need to reserve stack space for each of them in this amount.

The switchtest driver is RTDM-based, and may run a number of RTDM tasks,
depending on the test scenario.

> 
> Best wishes,
> 
> Jakub
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



