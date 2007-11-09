Message-ID: <e4ef24880711091408p44b25f94i43ebb06d04e9c40f@domain.hid>
Date: Fri, 9 Nov 2007 15:08:36 -0700
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <18228.55287.695219.531113@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14400_25985415.1194646116917"
References: <e4ef24880711091329g3dd27f0ds6fe033ef79993022@domain.hid>
	<18228.55287.695219.531113@domain.hid>
Subject: Re: [Xenomai-help] Synchronizing CLOCK_REALTIME between networked
	computers
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

------=_Part_14400_25985415.1194646116917
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I found it in the Xenomai POSIX skin API Reference Manual; dated: Sun Sep 16
18:35:26 2007.  Perhaps doxygen didn't pick up the change for some reason..

Well, I'll play around with it to see how quickly the clocks are drifting
and how much of a hit on performance I get when calling clock_settime().  I
am hoping for accuracy within 1 or 2 mS.  I figured calling clock_settime()
once a second would be "good enough."  I could instead call it every 5 or 10
seconds.  If you have any suggestions I'd love to hear them.

-Rob



On 11/9/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Robert Gubler wrote:
> > Hello,
> >
> > I'd like to synchronize CLOCK_REALTIME between some computers that share
> an
> > Ethernet switch.  I am using RTNet as my networking stack.  My approach
> > right now is very simplistic.  I have a central server that will be
> sending
> > out one 1 packet per second, with its struct timespec it got as a result
> of
> > calling clock_gettime(CLOCK_REALTIME,...). The computers listening for
> this
> > packet would then call clock_settime(CLOCK_REALTIME,..).
> >
> > In the Xenomai POSIX skin API doc it says clock_settime() isn't
> supported.
> > Is there a recommended approach to accomplishing this?   I am using
> Xenomai
> > 2.4-rc4.
>
> clock_settime IS supported by Xenomai 2.4, where does it still say in
> the doc that it is not supported ?
>
> However clock_settime is a costly service since it walks the system
> timers list to recompute their expiration date, so calling it often may
> not be a good idea.
>
> Also note that xenomai CLOCK_REALTIME clock is set to the value of Linux
> CLOCK_REALTIME clock on system startup, but then does not follow the
> corrections made by ntp, which means that it drifts if you compare them.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_14400_25985415.1194646116917
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I found it in the Xenomai POSIX skin API Reference Manual; dated: Sun Sep 16 18:35:26 2007.&nbsp; Perhaps doxygen didn&#39;t pick up the change for some reason..<br><br>Well, I&#39;ll play around with it to see how quickly the clocks are drifting and how much of a hit on performance I get when calling clock_settime().&nbsp; I am hoping for accuracy within 1 or 2 mS.&nbsp; I figured calling clock_settime() once a second would be &quot;good enough.&quot;&nbsp; I could instead call it every 5 or 10 seconds.&nbsp; If you have any suggestions I&#39;d love to hear them.
<br><br>-Rob<br><br><br>&nbsp;<br><div><span class="gmail_quote">On 11/9/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Robert Gubler wrote:<br> &gt; Hello,<br> &gt;<br> &gt; I&#39;d like to synchronize CLOCK_REALTIME between some computers that share an
<br> &gt; Ethernet switch.&nbsp;&nbsp;I am using RTNet as my networking stack.&nbsp;&nbsp;My approach<br> &gt; right now is very simplistic.&nbsp;&nbsp;I have a central server that will be sending<br> &gt; out one 1 packet per second, with its struct timespec it got as a result of
<br> &gt; calling clock_gettime(CLOCK_REALTIME,...). The computers listening for this<br> &gt; packet would then call clock_settime(CLOCK_REALTIME,..).<br> &gt;<br> &gt; In the Xenomai POSIX skin API doc it says clock_settime() isn&#39;t supported.
<br> &gt; Is there a recommended approach to accomplishing this?&nbsp;&nbsp; I am using Xenomai<br> &gt; 2.4-rc4.<br><br>clock_settime IS supported by Xenomai 2.4, where does it still say in<br>the doc that it is not supported ?<br>
<br>However clock_settime is a costly service since it walks the system<br>timers list to recompute their expiration date, so calling it often may<br>not be a good idea.<br><br>Also note that xenomai CLOCK_REALTIME clock is set to the value of Linux
<br>CLOCK_REALTIME clock on system startup, but then does not follow the<br>corrections made by ntp, which means that it drifts if you compare them.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.
<br></blockquote></div><br>

------=_Part_14400_25985415.1194646116917--

