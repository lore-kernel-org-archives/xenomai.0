From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b88603c30912300524w6c3fc006u2af367e53707f4d5@domain.hid>
References: <b88603c30912290148v7c67f028vce0a432c352ee41f@domain.hid>
	<1262081910.19080.363.camel@domain.hid>
	<1262083807.19080.378.camel@domain.hid>
	<b88603c30912290816y575f5dd2qaa4f6452c1ae36d5@domain.hid>
	<1262165780.19080.431.camel@domain.hid>
	<b88603c30912300524w6c3fc006u2af367e53707f4d5@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Dec 2009 14:57:49 +0100
Message-ID: <1262181469.19080.472.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Long latency exactly every hour
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-12-30 at 14:24 +0100, Henri Roosen wrote:
> On Wed, Dec 30, 2009 at 10:36 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> > On Tue, 2009-12-29 at 17:16 +0100, Henri Roosen wrote:
> >> Thanks Philippe for your quick response!
> >>
> >> I instrumented the code like below. I only see the first trace entry
> >> (0x11) in the log. If I interpret that correctly, the
> >> i8042_read_status() which is actually only an inb(0x64); stalls the
> >> system when fetching the data!? Could you comment on that. Is there
> >> maybe another explanation?
> >
> > You could double-check this by moving that particular invocation of
> > i8042_read_status() to a non-static, one-liner routine, and check
> > whether you see the 400 us lag charged to it.
> >
> 
> I tried to switch off the i8042 kernel driver using the kernel
> menuconfig, but it wouldn't let me that easily.. so I added a "return
> IRQ_HANDLED;" statement at the beginning of the i8042_interrupt
> routine, just for a quick test. The system has been running over-night
> without any long latencies now (< 80us with tracing enabled).
> 
> This sounds to me that something in the system design around the i8042
> implementation causes the delay. Strange is that I can use a connected
> keyboard without generating any delay. The delay only occured one time
> exactly every hour (was 100% reproducable). Maybe the way it is wired
> up in the system is a problem. If I read the internal chip block
> diagram correctly the i8042 might even be implemented in an on-chip
> 8051.. I will try and get more details from our vendor.
> 
> >>
> >> The i8042 is implemented in the Vortex86DX chip which is a system on
> >> chip. If this conclusion is correct I might try and contact someone at
> >> Vortex to find out if they can confirm this behaviour.
> >>
> >
> > Quite frankly, I don't have a definite answer.
> >
> > Some observations though:
> >
> > - first of all, this "noise" is periodic, in the 300-500 us range, which
> > is a common symptom of USB-related SMI interrupts on other platforms.
> >
> > - However, the issue seems to trigger when PS/2 I/O are performed, via
> > the i8042 chip. I have no answer to this either, but maybe you could try
> > disabling the kernel support for the AT keyboard and PS/2 mouse,
> > including the i8042 driver, only relying on the serial 8250 console, for
> > the purpose of testing whether this does make a difference or not.
> >
> 
> It makes all the difference :-), see previous comment. Finding a
> proper way to disable the i8042 kernel driver now... Our product does
> not need any PS/2 I/O.
> 
> > - Unfortunately, looking at the specs of DMP's Vortex86DX, I don't see
> > any ACPI capabilities. So enabling ACPI for mitigating any SMI issue
> > does not seem to be an option.
> >
> > - looking at the spec again, I see a display chip mentioned in the block
> > diagram, present on the Vortex86DX SoC. However, VGA support seems to be
> > available only with the upcoming MX SoC. It would be interesting to know
> > whether you do have some display hardware on that SoC, eventually.
> >
> 
> The Vortex86DX does not have display hardware on-chip. I agree the
> block diagram is not very clear, but the display block is painted
> outside of the dashed red line.

Ah, ok. I did not pay attention to the box in dashed line delimiting the
available hw. Nice marketing trick, if you think of it.

>  The internal-block-diagram of the DX
> SoC does not show it, which is correct.
> 
> > It would be useful to know from your vendor whether this SoC implements
> > some hardware emulation via SMM, in which case SMI would have a good
> > reason to be present.
> >
> 
> Good question. I will forward that question to our vendor. However, I
> disabled the SMM/SMI manually by configuring the SMM registers of the
> chip (port 0xfff0-0xfffa), so I would not expect any SMM/SMI.
> 

A wild guess, would be that an actually missing PS/2 hardware is being
emulated by SMM over USB on this SoC. For some reason, talking to that
emulated device might periodically trigger some ugly BIOS code, blocking
hw interrupts bluntly.

> > Also, could you send your full kernel boot log, with Xenomai SMI source
> > detection enabled in your configuration? This would help determining
> > which chipset our SMI work-around code actually detects.
> >
> 
> Please find the bootlog attached. I enabled the SMI workaround, but
> see nothing about it in the bootlog.
> 

This means that our work-around does not detect any SMI-capable chipset
among the ones it knows about, which does not mean there isn't any
though. No action is taken by the Xenomai core to disable any SMI source
in that case.

> Thanks for your support!
> Henri.
> 
> >>
> >>         spin_lock_irqsave(&i8042_lock, flags);
> >>         ipipe_trace_special(0x11, 0);
> >>         str = i8042_read_status();
> >>         if (unlikely(~str & I8042_STR_OBF)) {
> >>                 ipipe_trace_special(0xf1, 0);
> >>                 spin_unlock_irqrestore(&i8042_lock, flags);
> >>                 if (irq) dbg("Interrupt %d, without any data", irq);
> >>                 ret = 0;
> >>                 goto out;
> >>         }
> >>         ipipe_trace_special(0x12, 0);
> >>         data = i8042_read_data();
> >>         ipipe_trace_special(0x13, 0);
> >>         spin_unlock_irqrestore(&i8042_lock, flags);
> >>
> >>
> >> Thanks,
> >> Henri
> >>
> >>
> >> On Tue, Dec 29, 2009 at 11:50 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> >> > On Tue, 2009-12-29 at 11:18 +0100, Philippe Gerum wrote:
> >> >> On Tue, 2009-12-29 at 10:48 +0100, Henri Roosen wrote:
> >> >> > Hi,
> >> >> >
> >> >> > I have a small board with a Vortex86DX processor, which is a x86
> >> >> > compatible processor. I have a Linux Xenomai kernel 2.6.30.10 running
> >> >> > with ipipe 2.4-09 and Xenomai 2.4.10. The .config file is attached to
> >> >> > this email.
> >> >> >
> >> >> > The latency test program runs fine with latencies < 40us, but exactly
> >> >> > every hour I get one latency which is about 450us. In our system that
> >> >> > is killing.
> >> >> >
> >> >> > I switched off all the SMI and NMI on the board so that will not cause
> >> >> > the latency. Also I don't see any NMI's or ERR interrupts in
> >> >> > /proc/interrupts.
> >> >> >
> >> >> > I enabled the ipipe tracer and did a couple of runs. What I noticed is
> >> >> > that the long delay is happening every time at ipipe_check_context in
> >> >> > the Linux domain (see attached trace_464.log and trace2_438.log). What
> >> >> > could be blocking the next common_interrupt for so long or what is
> >> >> > happening there?
> >> >> >
> >> >>
> >> >> Actually, the bad guy is not ipipe_check_context(), but i8042_interrupt,
> >> >> from the serio driver, one line above in the report. For some reason, it
> >> >> spins there for quite a while.
> >> >>
> >> >> If you look at the various interrupt statuses reported on that line, you
> >> >> will see that interrupts are still enabled at hw level, but stalled only
> >> >> for Linux. So what that interrupt handler does, seems to defer the next
> >> >> interrupt at PIC/device level, but nothing masks it at CPU level.
> >> >
> >> > Well, unless some code there fiddles with the interrupt mask internally,
> >> > in a way that does not get reported to the tracer, in which case what
> >> > the tracer reports would be suspicious/incomplete wrt the hw interrupt
> >> > status.
> >> >
> >> >>
> >> >> A possible way to debug this is to add more tracepoints to the suspected
> >> >> code. You have a special tracer call for adding manual instrumentation,
> >> >> named "ipipe_trace_special()". You could use it this way, e.g.
> >> >>
> >> >> static irqreturn_t i8042_interrupt(int irq, void *dev_id)
> >> >> {
> >> >>       struct i8042_port *port;
> >> >>       unsigned long flags;
> >> >>       unsigned char str, data;
> >> >>       unsigned int dfl;
> >> >>       unsigned int port_no;
> >> >>       int ret = 1;
> >> >>
> >> >>       spin_lock_irqsave(&i8042_lock, flags);
> >> >> +     ipipe_trace_special(0x11, 0);
> >> >>       str = i8042_read_status();
> >> >>       if (unlikely(~str & I8042_STR_OBF)) {
> >> >>               spin_unlock_irqrestore(&i8042_lock, flags);
> >> >>               if (irq) dbg("Interrupt %d, without any data", irq);
> >> >>               ret = 0;
> >> >> +             ipipe_trace_special(0x12, 0);
> >> >>               goto out;
> >> >>       }
> >> >>       data = i8042_read_data();
> >> >> +     ipipe_trace_special(0x13, 0);
> >> >>       spin_unlock_irqrestore(&i8042_lock, flags);
> >> >>
> >> >> and so on, until you think you have covered enough paths to find the
> >> >> culprit in the tracer log. The basic idea is to catch the high latency
> >> >> between two consecutive calls of the special tracepoints, ideally close
> >> >> enough from each other to allow a precise pinpointing of the faulty
> >> >> code.
> >> >>
> >> >> See there for more:
> >> >> http://www.xenomai.org/index.php/I-pipe:Tracer
> >> >>
> >> >> > All help for debugging and solving this problem is appreciated.
> >> >> >
> >> >> > Thanks,
> >> >> > Henri.
> >> >> > _______________________________________________
> >> >> > Xenomai-help mailing list
> >> >> > Xenomai-help@domain.hid
> >> >> > https://mail.gna.org/listinfo/xenomai-help
> >> >>
> >> >>
> >> >
> >> >
> >> > --
> >> > Philippe.
> >> >
> >> >
> >> >
> >
> >
> > --
> > Philippe.
> >
> >
> >


-- 
Philippe.



