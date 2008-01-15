Message-ID: <db67beef0801151526o79074308o18f2bd486df68b72@domain.hid>
Date: Wed, 16 Jan 2008 00:26:01 +0100
From: bite <anonimo.passante@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9011_8240907.1200439561118"
Subject: Re: [Xenomai-help] rtpipe problem not solved by 2.4.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_9011_8240907.1200439561118
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Hi,
>
> intentionally dropped the CC?
>

No, just an occasional gmail user. Not intuitive, at least for me. Hitting
"reply" to your message, this is what I got. (Looking again, your message
appears to have me as the only addressee, so no surprise).


> bite wrote:
> > I know, but if it was easy to do, i would already have posted an
> example.
> >
> > The problem arises in a numerical controller application having the
> > following organization:
> >
> > - rt periodic task, receiving commands thru ring buffers and sending
> replies
> > thru rtp.
> > - non-rt server working as a bridge, pending on select both for tcp/ip
> > sockets and /dev/rtp*.
> > - c++ client talking to the server thru tcp/ip sockets
> > - java user interface talking to the server thru tcp/ip sockets, too.
> >
> > The java UI asks for status information (axis position etc) about twice
> a
> > second, while the c++ client transacts only upon user request.
> >
> > No problem ever occurs when the java UI is not working.
> >
> > The problem occasionally occurs only when the java UI is up.
> >
> > You can see that it is not easy to nail down an example, sorry.
>
> An alternative to reproducing the bug on one of our systems is to debug
> it on yours, either with the help of the I-pipe tracer or with LTTng.
>
> The former marks each and ever function call inside the kernel and is
> specifically helpful to track the call history temporally close to the
> failure (the application could issue a trace freeze on detecting the
> issue).
>
> The latter, LTTng, traces at a higher level and can therefore run over a
> longer time. But it also requires some help of the application to mark
> the failure in order to find it later on in the trace log.
>
> Both methods need a specifically prepared kernels (for LTTng, I would
> have to provide some patches from my private repository, the I-pipe
> trace just needs a config switch), and both methods may need interactive
> debugging, ie. some rounds where we put additional instrumentation in
> your kernel to collect rt-pipe specific states. Would you have the time
> and motivation to work together with us on this?
>

Surely yes for the motivation. For what concerns the time, yes too, but
please leave me one week to ten days to complete my work and deliver it to
my customer, then I will be glad to cooperate.

I will inform you when ready and if I don't, please remind me.

Thank you,

Bite


Jan
>
>

------=_Part_9011_8240907.1200439561118
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote"><div style="direction: ltr;">Hi,<br><br>intentionally dropped the CC?</div></blockquote><div>
<br>No, just an occasional gmail user. Not intuitive, at least for me. Hitting &quot;reply&quot; to your message, this is what I got. (Looking again, your message appears to have me as the only addressee, so no surprise).
<br></div><br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote"><div style="direction: ltr;"><span class="q"><br>bite wrote:<br>&gt; I know, but if it was easy to do, i would already have posted an example.
<br>&gt;<br>&gt; The problem arises in a numerical controller application having the<br>&gt; following organization:<br>&gt;<br>&gt; - rt periodic task, receiving commands thru ring buffers and sending replies<br>&gt; thru rtp.
<br>&gt; - non-rt server working as a bridge, pending on select both for tcp/ip<br>&gt; sockets and /dev/rtp*.<br>&gt; - c++ client talking to the server thru tcp/ip sockets<br>&gt; - java user interface talking to the server thru tcp/ip sockets, too.
<br>&gt;<br>&gt; The java UI asks for status information (axis position etc) about twice a<br>&gt; second, while the c++ client transacts only upon user request.<br>&gt;<br>&gt; No problem ever occurs when the java UI is not working.
<br>&gt;<br>&gt; The problem occasionally occurs only when the java UI is up.<br>&gt;<br>&gt; You can see that it is not easy to nail down an example, sorry.<br><br></span></div><div style="direction: ltr;">An alternative to reproducing the bug on one of our systems is to debug
<br>it on yours, either with the help of the I-pipe tracer or with LTTng.<br><br>The former marks each and ever function call inside the kernel and is<br>specifically helpful to track the call history temporally close to the
<br>failure (the application could issue a trace freeze on detecting the issue).<br><br>The latter, LTTng, traces at a higher level and can therefore run over a<br>longer time. But it also requires some help of the application to mark
<br>the failure in order to find it later on in the trace log.<br><br>Both methods need a specifically prepared kernels (for LTTng, I would<br>have to provide some patches from my private repository, the I-pipe<br>trace just needs a config switch), and both methods may need interactive
<br>debugging, ie. some rounds where we put additional instrumentation in<br>your kernel to collect rt-pipe specific states. Would you have the time<br>and motivation to work together with us on this?</div></blockquote><div>
<br>Surely yes for the motivation. For what concerns the time, yes too, but please leave me one week to ten days to complete my work and deliver it to my customer, then I will be glad to cooperate.<br><br>I will inform you when ready and if I don&#39;t, please remind me.
<br><br>Thank you,<br><br>Bite<br><br></div><br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote"><div style="direction: ltr;"><span class="sg">
Jan<br><br></span></div></blockquote>

------=_Part_9011_8240907.1200439561118--

