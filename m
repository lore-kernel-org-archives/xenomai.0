MIME-Version: 1.0
References: <3594e210190a4c74ae039e2a2f9859f3@boschrexroth.nl>
 <c6cc67a3-c7cb-adc6-f0af-1d4161b95fad@siemens.com>
In-Reply-To: <c6cc67a3-c7cb-adc6-f0af-1d4161b95fad@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 2 Mar 2020 11:01:59 -0500
Message-ID: <CALLqZ8TsLUU5mHrSJCOv+R=aMnQdBpq4_V6=ywC0CeEyQ-f5aQ@mail.gmail.com>
Subject: Re: IRQ's off issue
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Bradley Valdenebro Peter (DC-AE/ESW52)" <Peter.BradleyValdenebro@boschrexroth.nl>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Mar 2, 2020 at 7:45 AM Jan Kiszka via Xenomai
<xenomai@xenomai.org> wrote:
>
> On 02.03.20 12:03, Bradley Valdenebro Peter (DC-AE/ESW52) via Xenomai wrote:
> > Hello Xenomai team,
> >
> > We need you help understanding and solving a possible IRQ's off issue.
> > We are running a Xenomai/Linux setup on a Zynq Z-7020 SoC (We run Linux on CPU0 and Xenomai on CPU1):
> >   - Linux version 4.4.0-xilinx (gcc version 8.3.0 (Buildroot 2019.02-00080-gc31d48e) ) #1 SMP PREEMPT
> >   - ipipe ARM patch #8
> >   - Xenomai 3.0.10
> >
> > Lately we have been experiencing that our highest priority real time Xenomai thread sort of halts for around 1ms every now and then.
> > After some investigation and tests we decided to enable ipipe trace to measure IRQs-off times. See below the output of /proc/ipipe/trace/max
> >
> > I-pipe worst-case tracing service on 4.4.0-xilinx/ipipe release #8
> > -------------------------------------------------------------
> > CPU: 0, Begin: 2944366216549 cycles, Trace Points: 2 (-10/+1), Length: 780 us
> > Calibrated minimum trace-point overhead: 0.288 us
> >
> >   +----- Hard IRQs ('|': locked)
> >   |+-- Xenomai
> >   ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> >   |||                      +---------- Delay flag ('+': > 1 us, '!': > 10 us)
> >   |||                      |        +- NMI noise ('N')
> >   |||                      |        |
> >            Type    User Val.   Time    Delay  Function (Parent)
> >   | +begin   0x80000001   -12      0.414  ipipe_stall_root+0x54 (<00000000>)
> >   | #end     0x80000001   -11      0.822  ipipe_stall_root+0x8c (<00000000>)
> >   | #begin   0x80000001   -11      0.414  ipipe_test_and_stall_root+0x5c (<00000000>)
> >   | #end     0x80000001   -10      1.095  ipipe_test_and_stall_root+0x98 (<00000000>)
> >   | #begin   0x90000000    -9      0.665  __irq_svc+0x58 (arch_cpu_idle+0x0)
> >   | #begin   0x00000025    -8      2.883  __ipipe_grab_irq+0x38 (<00000000>)
> >   |#*[  558] SampleI 49    -5      2.619  xnthread_resume+0x88 (<00000000>)
> >   |#*[    0] -<?>-   -1    -3      2.052  ___xnsched_run+0xfc (<00000000>)
> >   | #end     0x00000025    -1      0.760  __ipipe_grab_irq+0x7c (<00000000>)
> >   | #end     0x90000000     0      0.530  __ipipe_fast_svc_irq_exit+0x1c (arch_cpu_idle+0x0)
> >> | #begin   0x80000000     0! 780.110  arch_cpu_idle+0x9c (<00000000>)
> > <| +end     0x80000000   780      0.570  ipipe_unstall_root+0x64 (<00000000>)
> >   | +begin   0x90000000   780      0.000  __irq_svc+0x58 (ipipe_unstall_root+0x68)
>
> Looks like the CPU was idle and received no IRQ during that time. Is
> some power management active? Is some timer misprogrammed? Or where
> should the next interrupt have from?
>
> >
> > We have trouble understanding the output but we can see a max length of 780us on CPU0. We find this value extremely high.
> > With our current requirements anything beyond 10us is not acceptable.
>
> 780 us is definitely off on that target, but 10 us will likely be too
> ambitious as well. Maybe, maybe, with well configured strict core
> isolation, practically no Linux load on the RT core and your critical RT
> code path always in cache... But I would consider that highly risky,
> given this low-end CPU on that target SoC.
>
> Jan
>
Just to add, this chip (like most cortex-A9's) uses the PL-310 cache
controller.  This controller has high latency, in the past it has
impacted the performance of  a number of SOC's.

This link shows the an issue found on the imx6:
https://www.xenomai.org/pipermail/xenomai/2018-July/039268.html

You may run into this issue with the Zynq as well.

-Greg
> >
> > Can someone with experience with the ipipe tracer please help us understand what is going on and how can we fix it?
> >
> > Thanks in advance for your support.
> >
> > Best regards.
> > Peter Bradley
> >
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

