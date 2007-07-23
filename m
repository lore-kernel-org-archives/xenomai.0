Message-ID: <2862c2c80707230129m143232d1n2dcfbec22c05962d@domain.hid>
Date: Mon, 23 Jul 2007 16:29:49 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2ff1a98a0707230117n6407f270o9f58f44eeb4f9d9d@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_102973_24307148.1185179389800"
References: <2862c2c80707222152t2037a987mca3f70d1da9865dd@domain.hid>
	<18084.23878.661537.272573@domain.hid>
	<2862c2c80707230104y5e5c9cc0v8038458e8bcc5f1c@domain.hid>
	<2ff1a98a0707230117n6407f270o9f58f44eeb4f9d9d@domain.hid>
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

------=_Part_102973_24307148.1185179389800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

I compiled xenomai in the kernel.  Here , the kernel initial log messages;

I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
I-pipe: Domain IShield registered.
Xenomai: real-time nucleus v2.3.2 (The Forgotten) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.

Did I miss out any required modules?

regards,
chun yeow

On 7/23/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> On 7/23/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> > Dear Gilles,
> >
> > The same problem still occurs. Here is the /proc/xenomai/faults output:
> >
> > [root@domain.hid]
> > cat /proc/xenomai/faults
> > TRAP         CPU0
> >   0:            0    (Data or instruction access)
> >   1:            0    (Section fault)
> >   2:            0    (Generic data abort)
> >   3:            0    (Unknown exception)
> >   4:            0    (Instruction breakpoint)
> >   5:            0    (Floating point exception)
> >   6:            0    (VFP Floating point exception)
> >   7:            0    (Undefined instruction)
> >
> > Any ideas?
>
> Did you compile Xenomai as module or in the kernel ? If compiled as
> module, are the module loaded ? If yes, then try running your test
> inside gdb to know which instruction triggers this error message.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_102973_24307148.1185179389800
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>I compiled xenomai in the kernel.&nbsp; Here , the kernel initial log messages;<br><br>I-pipe: Domain Xenomai registered.<br>Xenomai: hal/arm started.<br>I-pipe: Domain IShield registered.<br>Xenomai: real-time nucleus 
v2.3.2 (The Forgotten) loaded.<br>Xenomai: starting native API services.<br>Xenomai: starting POSIX services.<br>Xenomai: starting RTDM services.<br><br>Did I miss out any required modules?<br><br>regards,<br>chun yeow<br>
<br><div><span class="gmail_quote">On 7/23/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 7/23/07, Yeoh Chun Yeow &lt;<a href="mailto:yeohchunyeow@domain.hid">yeohchunyeow@domain.hid</a>&gt; wrote:<br>&gt; Dear Gilles,<br>&gt;<br>&gt; The same problem still occurs. Here is the /proc/xenomai/faults output:<br>
&gt;<br>&gt; [root@domain.hid]<br>&gt; cat /proc/xenomai/faults<br>&gt; TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>&gt;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Data or instruction access)<br>&gt;&nbsp;&nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Section fault)
<br>&gt;&nbsp;&nbsp; 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Generic data abort)<br>&gt;&nbsp;&nbsp; 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Unknown exception)<br>&gt;&nbsp;&nbsp; 4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Instruction breakpoint)<br>&gt;&nbsp;&nbsp; 5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Floating point exception)<br>&gt;&nbsp;&nbsp; 6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(VFP Floating point exception)
<br>&gt;&nbsp;&nbsp; 7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;(Undefined instruction)<br>&gt;<br>&gt; Any ideas?<br><br>Did you compile Xenomai as module or in the kernel ? If compiled as<br>module, are the module loaded ? If yes, then try running your test
<br>inside gdb to know which instruction triggers this error message.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_102973_24307148.1185179389800--

