MIME-Version: 1.0
In-Reply-To: <4C46F0D9.4030906@domain.hid>
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>
	<4C46D49F.6030102@domain.hid>
	<AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>
	<4C46F0D9.4030906@domain.hid>
Date: Thu, 22 Jul 2010 08:49:26 +0100
Message-ID: <AANLkTilP98GMfCx1rcgWto9eBmnDwtuavBteD8inFM6V@mail.gmail.com>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=001636a7d85e562546048bf528cc
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority thread
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
Cc: xenomai@xenomai.org

--001636a7d85e562546048bf528cc
Content-Type: text/plain; charset=ISO-8859-1

On 21 July 2010 14:06, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Stephen Bryant wrote:
> > On 21 July 2010 12:06, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org
> > <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >
> >     Stephen Bryant wrote:
> >     > Hi,
> >     >
> >     > I have some code (simplified example below) which uses
> >     > 'pthread_wait_np(&Overrun)' within a while loop, using a period of
> >     > 1,000,000ns (1ms) which has been set using
> >     'pthread_make_periodic_np()'.
> >     > This wakes the thread up less than 2,000ns late in general,
> sometimes
> >     > 20,000ns late, and at most less than 45,000ns late.
> >
> >     Since you do not tell us, I guess you are running on x86. Depending
> on
> >     the x86 you are running, 45 us may be high.
> >
> >
> > Yes, it is x86, sorry for the omission. What sort of latencies would you
> > expect me to see?
>
> If it is for instance, a core 2 duo, it should be around, say, 10 or
> 20us. If on the other hand, it is a geode, then 45us may be OK. The
> actual results also depend on the system load, an unloaded core 2 will
> have average latencies under 10us.
>
> >     This reasoning is flawed: you may be preempted by interrupts any
> time.
> >     Including just about at the time where you were going to exit the
> busy
> >     loop. Unless you spin irqs off, and only reenable irqs when the job
> the
> >     thread is supposed to be doing is done. And if you have an SMI issue,
> >     even turning off the interrupts will not help.
> >
> >
> > I was under the (apparently flawed) impression that Adeos was used to
> > prevent interrupts preempting a running high priority task in primary
> > mode, only forwarding the interrupts to Linux once the task was waiting
> > / finished. I guess that it only prevents a subset of all interrupts,
> > and the rest must be specifically disabled then re-enabled by the
> > program, or maybe it does not intercept any interrupts?
>
> It prevents secondary domain interrupts from being executed, but the
> primary domain interrupt such as the timer interrupt are still executed,
> and the secondary domain interrupts are still ticking and cause a
> context switch, even if masked immediately.
>
> >     The question is: is the SMI workaround working for your chipset? If
> that
> >     is the case, you should get messages in the kernel logs.
> >
> >
> > I've had a look at dmesg, but cannot find any references to SMI - what
> > should I be looking for?
>
> What is described in the TROUBLESHOOTING file.
>
>
I have tried disabling the SMI workaround, ensuring that SMI detection is
not disabled, and logging the kernel output (setting the kernel log level to
8 in grub and sending the output to the serial port to be picked up by
another machine). The troubleshooting file states that I should see
"Xenomai: Intel chipset found and SMI workaround not
enabled, you may encounter high interrupt latencies." in this output,
however this does not occur - I am using an Intel Core 2 Duo but with SMP
disabled, if this has any relevance.

Steve

--001636a7d85e562546048bf528cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On 21 July 2010 14:06, Gilles Chanteperdrix <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gille=
s.chanteperdrix@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Stephen Bryant wrote:<br>
&gt; On 21 July 2010 12:06, Gilles Chanteperdrix<br>
&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a><br>
</div><div class=3D"im">&gt; &lt;mailto:<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 Stephen Bryant wrote:<br>
&gt; =A0 =A0 &gt; Hi,<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; I have some code (simplified example below) which uses<br=
>
&gt; =A0 =A0 &gt; &#39;pthread_wait_np(&amp;Overrun)&#39; within a while lo=
op, using a period of<br>
&gt; =A0 =A0 &gt; 1,000,000ns (1ms) which has been set using<br>
&gt; =A0 =A0 &#39;pthread_make_periodic_np()&#39;.<br>
&gt; =A0 =A0 &gt; This wakes the thread up less than 2,000ns late in genera=
l, sometimes<br>
&gt; =A0 =A0 &gt; 20,000ns late, and at most less than 45,000ns late.<br>
&gt;<br>
&gt; =A0 =A0 Since you do not tell us, I guess you are running on x86. Depe=
nding on<br>
&gt; =A0 =A0 the x86 you are running, 45 us may be high.<br>
&gt;<br>
&gt;<br>
&gt; Yes, it is x86, sorry for the omission. What sort of latencies would y=
ou<br>
&gt; expect me to see?<br>
<br>
</div>If it is for instance, a core 2 duo, it should be around, say, 10 or<=
br>
20us. If on the other hand, it is a geode, then 45us may be OK. The<br>
actual results also depend on the system load, an unloaded core 2 will<br>
have average latencies under 10us.<br>
<div class=3D"im"><br>
&gt; =A0 =A0 This reasoning is flawed: you may be preempted by interrupts a=
ny time.<br>
&gt; =A0 =A0 Including just about at the time where you were going to exit =
the busy<br>
&gt; =A0 =A0 loop. Unless you spin irqs off, and only reenable irqs when th=
e job the<br>
&gt; =A0 =A0 thread is supposed to be doing is done. And if you have an SMI=
 issue,<br>
&gt; =A0 =A0 even turning off the interrupts will not help.<br>
&gt;<br>
&gt;<br>
&gt; I was under the (apparently flawed) impression that Adeos was used to<=
br>
&gt; prevent interrupts preempting a running high priority task in primary<=
br>
&gt; mode, only forwarding the interrupts to Linux once the task was waitin=
g<br>
&gt; / finished. I guess that it only prevents a subset of all interrupts,<=
br>
&gt; and the rest must be specifically disabled then re-enabled by the<br>
&gt; program, or maybe it does not intercept any interrupts?<br>
<br>
</div>It prevents secondary domain interrupts from being executed, but the<=
br>
primary domain interrupt such as the timer interrupt are still executed,<br=
>
and the secondary domain interrupts are still ticking and cause a<br>
context switch, even if masked immediately.<br>
<div class=3D"im"><br>
&gt; =A0 =A0 The question is: is the SMI workaround working for your chipse=
t? If that<br>
&gt; =A0 =A0 is the case, you should get messages in the kernel logs.<br>
&gt;<br>
&gt;<br>
&gt; I&#39;ve had a look at dmesg, but cannot find any references to SMI - =
what<br>
&gt; should I be looking for?<br>
<br>
</div>What is described in the TROUBLESHOOTING file.<br>
<br></blockquote><div><br>I have tried disabling the SMI workaround, ensuri=
ng that SMI detection is not disabled, and logging the kernel output (setti=
ng the kernel log level to 8 in grub and sending the output to the serial p=
ort to be picked up by another machine). The troubleshooting file states th=
at I should see &quot;Xenomai: Intel chipset found and SMI workaround not<b=
r>
enabled, you may encounter high interrupt latencies.&quot; in this output, =
however this does not occur - I am using an Intel Core 2 Duo but with SMP d=
isabled, if this has any relevance.<br>=A0</div></div>Steve<br>

--001636a7d85e562546048bf528cc--

