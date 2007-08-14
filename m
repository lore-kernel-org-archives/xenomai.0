Message-ID: <3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>
Date: Tue, 14 Aug 2007 17:26:31 +0200
From: "andy motten" <andy.motten@domain.hid>
In-Reply-To: <46C08E61.9060204@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_377_33180705.1187105191572"
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<1186676576.4978.12.camel@domain.hid> <46BC1494.2010303@domain.hid>
	<Pine.LNX.4.64.0708100951160.23969@domain.hid>
	<3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>
	<46BC8074.3090104@domain.hid>
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>
	<18112.1512.506911.608273@domain.hid>
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>
	<46C08E61.9060204@domain.hid>
Subject: Re: [Xenomai-help] hard lock-up
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

------=_Part_377_33180705.1187105191572
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/8/13, Jan Kiszka <jan.kiszka@domain.hid>:
>
> andy motten wrote:
> >> Klaas Gadeyne wrote:
> >>> On Fri, 10 Aug 2007, Jan Kiszka wrote:
> >>> [..]
> >>>> BTW, given that the SMI workaround is infunctional on your system: Do
> >>>> you get reasonable latencies ATM? It looked to me like the NMI
> >> watchdog
> >>>> might have triggered due to SMI-related delays.
> >>> We do get very reasonable latencies once the AGP functionality is
> >>> turned off (otherwise, latencies are pathetic).  Note that we haven't
> >>> sorted out whether the buggy behaviour and huge latencies are due to
> >>> the AGP bus in general or too the specific intel_something_els_here
> >>> driver.
> >> Did you try the "noaccel" option, as explained in the FAQ ?
> >>
> >
> > Yes, but there was no change in performance.
>
> You mean latency?


Yes, I meant latency. There is no difference with or without the option
"noaccel".

>
> > We have tried several configurations of the system, and we get no hard
> > lockups anymore.
> > Even the configurations that used to lockup are working now without a
> > problem.
> >
> > Maybe we forget something, but to be honest, we have no idea what
> triggered
> > this change in behavior.
> > Thanks for all the help.
> > As soon as we know something more about this 'random' behavior, We will
> post
> > it.


The lock-ups are back (very randomly). Disabling the AGP bus didn't make a
difference.

And the pathetic latencies might be worth a look using the latency
> tracer.


I will run continuously several tests on the pc (including "latency -f") for
the rest of this week. Since I am not in the office during this period  (so
not in the neighborhood of this problematic pc).
And I hope (I hope not in vain) that the latency tracer will give us a hint
for the reason of the hard lock ups (if a hard lock up happens during this
period).

Just to be sure it's no software issue. Is there any known
> non-broken real-time Linux installation for your board, or did you just
> try it out for the first time?


This is the first time that Xenomai has been installed AND tested thoroughly
on this pc.

andy

------=_Part_377_33180705.1187105191572
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/8/13, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
andy motten wrote:<br>&gt;&gt; Klaas Gadeyne wrote:<br>&gt;&gt;&gt; On Fri, 10 Aug 2007, Jan Kiszka wrote:<br>&gt;&gt;&gt; [..]<br>&gt;&gt;&gt;&gt; BTW, given that the SMI workaround is infunctional on your system: Do<br>
&gt;&gt;&gt;&gt; you get reasonable latencies ATM? It looked to me like the NMI<br>&gt;&gt; watchdog<br>&gt;&gt;&gt;&gt; might have triggered due to SMI-related delays.<br>&gt;&gt;&gt; We do get very reasonable latencies once the AGP functionality is
<br>&gt;&gt;&gt; turned off (otherwise, latencies are pathetic).&nbsp;&nbsp;Note that we haven&#39;t<br>&gt;&gt;&gt; sorted out whether the buggy behaviour and huge latencies are due to<br>&gt;&gt;&gt; the AGP bus in general or too the specific intel_something_els_here
<br>&gt;&gt;&gt; driver.<br>&gt;&gt; Did you try the &quot;noaccel&quot; option, as explained in the FAQ ?<br>&gt;&gt;<br>&gt;<br>&gt; Yes, but there was no change in performance.<br><br>You mean latency?</blockquote><div>
<br>Yes, I meant latency. There is no difference with or without the option &quot;noaccel&quot;. <br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt;<br>&gt; We have tried several configurations of the system, and we get no hard<br>&gt; lockups anymore.<br>&gt; Even the configurations that used to lockup are working now without a<br>&gt; problem.<br>&gt;<br>&gt; Maybe we forget something, but to be honest, we have no idea what triggered
<br>&gt; this change in behavior.<br>&gt; Thanks for all the help.<br>&gt; As soon as we know something more about this &#39;random&#39; behavior, We will post<br>&gt; it.</blockquote><div><br>The lock-ups are back (very randomly). Disabling the AGP bus didn&#39;t make a difference.
<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">And the pathetic latencies might be worth a look using the latency<br>tracer. 
</blockquote><div><br>I will run continuously several tests on the pc (including &quot;latency -f&quot;) for the rest of this week. Since I am not in the office during this period&nbsp; (so not in the neighborhood of this problematic pc).
<br>And I hope (I hope not in vain) that the latency tracer will give us a hint for the reason of the hard lock ups (if a hard lock up happens during this period). <br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Just to be sure it&#39;s no software issue. Is there any known<br>non-broken real-time Linux installation for your board, or did you just<br>try it out for the first time?</blockquote><div><br>This is the first time that Xenomai has been installed AND tested thoroughly on this pc. 
<br></div></div><br>andy<br>

------=_Part_377_33180705.1187105191572--

