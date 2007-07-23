Message-ID: <2862c2c80707230233l67823789v41c85729bf0335ce@domain.hid>
Date: Mon, 23 Jul 2007 17:33:56 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2ff1a98a0707230210md987ad0la2adaef2210c6f46@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_103601_31455438.1185183236455"
References: <2862c2c80707222152t2037a987mca3f70d1da9865dd@domain.hid>
	<18084.23878.661537.272573@domain.hid>
	<2862c2c80707230104y5e5c9cc0v8038458e8bcc5f1c@domain.hid>
	<2ff1a98a0707230117n6407f270o9f58f44eeb4f9d9d@domain.hid>
	<2862c2c80707230129m143232d1n2dcfbec22c05962d@domain.hid>
	<2ff1a98a0707230150j216dd5bapbaf08d3df91b4e0e@domain.hid>
	<2ff1a98a0707230210md987ad0la2adaef2210c6f46@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Testsuite for AT91 - Illegal Instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_103601_31455438.1185183236455
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

But the ARM GNU toolchain requires the kernel to have EABI feature to
support BusyBox.

Is this going to affect the application compiled with no EABI support?
Please advice.

By the way, here the result of GDB:

415             finished = 1;
416     }
417
418     int main(int argc, char **argv)
419     {
420             int c, err;
421             char task_name[16];
422             int cpu = 0;
423
424             fprintf(stderr, "latency test\n");
425
(gdb) break 425
Breakpoint 1 at 0x99cc: file latency.c, line 425.
(gdb) continue
Continuing.
[New Thread 261]

Program received signal SIGILL, Illegal instruction.
[Switching to Thread 261]
__init_rtdm_interface () at ../../../include/asm-generic/bits/bind.h:76

Any ideas?

regards,
chun yeow


On 7/23/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> On 7/23/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > On 7/23/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> > > On 7/23/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> wrote:
> > > > On 7/23/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> > > > > Dear Gilles,
> > > > >
> > > > > The same problem still occurs. Here is the /proc/xenomai/faults
> output:
> > > > >
> > > > >
> > > [root@domain.hid]
> > > > > cat /proc/xenomai/faults
> > > > > TRAP         CPU0
> > > > >   0:            0    (Data or instruction access)
> > > > >   1:            0    (Section fault)
> > > > >   2:            0    (Generic data abort)
> > > > >   3:            0    (Unknown exception)
> > > > >   4:            0    (Instruction breakpoint)
> > > > >   5:            0    (Floating point exception)
> > > > >   6:            0    (VFP Floating point exception)
> > > > >   7:            0    (Undefined instruction)
> > > > >
> > > > > Any ideas?
> > > >
> > > > Did you compile Xenomai as module or in the kernel ? If compiled as
> > > > module, are the module loaded ? If yes, then try running your test
> > > > inside gdb to know which instruction triggers this error message.
> > > >
> > > Dear Gilles,
> > >
> > > I compiled xenomai in the kernel.  Here , the kernel initial log
> messages;
> > >
> > > I-pipe: Domain Xenomai registered.
> > > Xenomai: hal/arm started.
> > > I-pipe: Domain IShield registered.
> > > Xenomai: real-time nucleus v2.3.2 (The Forgotten) loaded.
> > > Xenomai: starting native API services.
> > > Xenomai: starting POSIX services.
> > > Xenomai: starting RTDM services.
> > >
> > > Did I miss out any required modules?
> >
> > I do not think so. Last idea: check the EABI setting. If it is not the
> > culprit, try running your application in gdb. Really, this will tell
> > you what goes wrong right away instead of trying to guess.
>
> I have just checked the v2.3 branch, it does not support EABI, only
> trunk does. So, if you are using Xenomai v2.3.2, pass whatever flag is
> necessary for gcc not to use EABI.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_103601_31455438.1185183236455
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>But the ARM GNU toolchain requires the kernel to have EABI feature to support BusyBox.<br><br>Is this going to affect the application compiled with no EABI support? Please advice.<br><br>By the way, here the result of GDB:
<br><br>415&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; finished = 1;<br>416&nbsp;&nbsp;&nbsp;&nbsp; }<br>417<br>418&nbsp;&nbsp;&nbsp;&nbsp; int main(int argc, char **argv)<br>419&nbsp;&nbsp;&nbsp;&nbsp; {<br>420&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int c, err;<br>421&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char task_name[16];<br>422&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cpu = 0;<br>423
<br>424&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;latency test\n&quot;);<br>425<br>(gdb) break 425<br>Breakpoint 1 at 0x99cc: file latency.c, line 425.<br>(gdb) continue<br>Continuing.<br>[New Thread 261]<br><br style="color: rgb(204, 0, 0);">
<span style="color: rgb(204, 0, 0);">Program received signal SIGILL, Illegal instruction.</span><br>[Switching to Thread 261]<br>__init_rtdm_interface () at ../../../include/asm-generic/bits/bind.h:76<br><br>Any ideas?<br>
<br>regards,<br>chun yeow<br><br><br><div><span class="gmail_quote">On 7/23/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On 7/23/07, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">
gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>&gt; On 7/23/07, Yeoh Chun Yeow &lt;<a href="mailto:yeohchunyeow@domain.hid">yeohchunyeow@domain.hid</a>&gt; wrote:<br>&gt; &gt; On 7/23/07, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">
gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>&gt; &gt; &gt; On 7/23/07, Yeoh Chun Yeow &lt;<a href="mailto:yeohchunyeow@domain.hid">yeohchunyeow@domain.hid</a>&gt; wrote:<br>&gt; &gt; &gt; &gt; Dear Gilles,<br>&gt; &gt; &gt; &gt;
<br>&gt; &gt; &gt; &gt; The same problem still occurs. Here is the /proc/xenomai/faults output:<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; [root@domain.hid]<br>
&gt; &gt; &gt; &gt; cat /proc/xenomai/faults<br>&gt; &gt; &gt; &gt; TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>&gt; &gt; &gt; &gt;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Data or instruction access)<br>&gt; &gt; &gt; &gt;&nbsp;&nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Section fault)<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp; 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Generic data abort)<br>&gt; &gt; &gt; &gt;&nbsp;&nbsp; 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Unknown exception)<br>&gt; &gt; &gt; &gt;&nbsp;&nbsp; 4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Instruction breakpoint)<br>&gt; &gt; &gt; &gt;&nbsp;&nbsp; 5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Floating point exception)
<br>&gt; &gt; &gt; &gt;&nbsp;&nbsp; 6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(VFP Floating point exception)<br>&gt; &gt; &gt; &gt;&nbsp;&nbsp; 7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Undefined instruction)<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; Any ideas?<br>&gt; &gt; &gt;<br>
&gt; &gt; &gt; Did you compile Xenomai as module or in the kernel ? If compiled as<br>&gt; &gt; &gt; module, are the module loaded ? If yes, then try running your test<br>&gt; &gt; &gt; inside gdb to know which instruction triggers this error message.
<br>&gt; &gt; &gt;<br>&gt; &gt; Dear Gilles,<br>&gt; &gt;<br>&gt; &gt; I compiled xenomai in the kernel.&nbsp;&nbsp;Here , the kernel initial log messages;<br>&gt; &gt;<br>&gt; &gt; I-pipe: Domain Xenomai registered.<br>&gt; &gt; Xenomai: hal/arm started.
<br>&gt; &gt; I-pipe: Domain IShield registered.<br>&gt; &gt; Xenomai: real-time nucleus v2.3.2 (The Forgotten) loaded.<br>&gt; &gt; Xenomai: starting native API services.<br>&gt; &gt; Xenomai: starting POSIX services.<br>
&gt; &gt; Xenomai: starting RTDM services.<br>&gt; &gt;<br>&gt; &gt; Did I miss out any required modules?<br>&gt;<br>&gt; I do not think so. Last idea: check the EABI setting. If it is not the<br>&gt; culprit, try running your application in gdb. Really, this will tell
<br>&gt; you what goes wrong right away instead of trying to guess.<br><br>I have just checked the v2.3 branch, it does not support EABI, only<br>trunk does. So, if you are using Xenomai v2.3.2, pass whatever flag is<br>necessary for gcc not to use EABI.
<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_103601_31455438.1185183236455--

