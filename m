Message-ID: <7289437c0706070509h26132566l3ee75ff72e826a1f@domain.hid>
Date: Thu, 7 Jun 2007 14:09:09 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <1181211452.4998.57.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_28218_1127164.1181218149041"
References: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01FAF561@domain.hid>
	<1181143109.17978.101.camel@domain.hid>
	<7289437c0706062254v2a386894oeb498459877d5086@domain.hid>
	<4667AA4D.6070505@domain.hid>
	<7289437c0706070042gf4346ddj1c4ee3ac20a068d2@domain.hid>
	<4667BBBE.1040405@domain.hid> <4667CEF2.2050509@domain.hid>
	<1181210822.4998.54.camel@domain.hid> <1181211452.4998.57.camel@domain.hid>
Subject: Re: [Xenomai-help] Cyclictest
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

------=_Part_28218_1127164.1181218149041
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Perrine, what version of the I-pipe patch are you using ?

I use adeos-ipipe-2.6.19-arm-1.6-04.patch.


On 6/7/07, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Thu, 2007-06-07 at 12:07 +0200, Philippe Gerum wrote:
> > On Thu, 2007-06-07 at 11:25 +0200, Gilles Chanteperdrix wrote:
> > > Jan Kiszka wrote:
> > > > Perrine Martignoni wrote:
> > > >
> > > >>Ok. I'll do this.
> > > >>
> > > >>But I don't understand why the same application compiled without any
> links
> > > >>with Xenomai give different results if there is Xenomai in the
> kernel.
> > > >
> > > >
> > > > [Looking at your numbers again] Hmm, maybe some rounding issue of
> ticks
> > > > due to whatever side-effect of I-pipe. We would first of all need
> the
> > > > usual set of information (.config, involved versions) and also
> > > > /sys/devices/system/clocksource/clocksource0/current_clocksource.
> > >
> > > Maybe what Perrine is observing is simply the overhead of the I-pipe ?
> > > I mean, Linux is Xenomai idle task, so it is acceptable for Linux
> > > numbers to be a bit worse than when Xenomai is not running.
> > >
> >
> > Most of the "known" overhead has disappeared with the PF_EVNOTIFY
> > extension, so that we relay Linux-originated events (e.g. syscalls) only
> > to subscribed domains (e.g. Xenomai).
>
> ... to subscribed tasks from suscribed domains, more precisely. In
> effect, Xenomai does not filter syscalls issued from plain Linux tasks
> anymore.
>
> >  In the test case we are discussing
> > of, no relay should be done since no domain did subscribe to receive
> > those events.
> >
> > The best way to check if the I-pipe still adds a noticeable overhead is
> > to compare:
> >
> > - a vanilla kernel running cyclic test,
> > with
> > - an I-pipe patched kernel, without Xenomai, using the same .config than
> > the vanilla kernel used. Without Xenomai either means to not run the
> > prepare-kernel.sh script, but only patch the kernel with the I-pipe
> > support, or disable CONFIG_XENOMAI entirely if the preparation script
> > has been run on the target kernel tree.
> >
> > _Having both kernel setups share the very same kernel configuration is
> > mandatory, otherwise you would end up comparing apples and oranges._
> > The best way to make sure of this is to copy the .config file used for
> > the vanilla kernel to the I-pipe patched one, and run "make oldconfig".
> > You should be prompted only once, for the new CONFIG_IPIPE switch. Any
> > other behaviour would be the sign of some discrepancy in your test
> > configuration.
> >
> > Since we can't have any temporal predictability for such configs, the
> > max value the cyclic test reports has no meaning. The useful figures are
> > the min and average values, as observed for a few minutes while the
> > board/box is sitting doing nothing but running the test.
> >
> > A better way measure such artefacts is to run something like hackbench,
> > and compare the execution times, on kernels w/ and w/o the I-pipe.
> > http://developer.osdl.org/craiger/hackbench/src/hackbench.c
> > Tune the argument representing the number of process groups which you
> > pass to this program, so that it runs for a few minutes without putting
> > your box/board on its knees. There should be no significant difference
> > between the time reported at the end of both tests, at the very least,
> > not a 30% increase as your first report suggested. If the difference is
> > noticeable, then, there might be an issue (the final conclusion really
> > depends on the underlying hw).
> >
> --
> Philippe.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_28218_1127164.1181218149041
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&gt; Perrine, what version of the I-pipe patch are you using ?</div>
<div>&nbsp;</div>
<div>I use adeos-ipipe-2.6.19-arm-1.6-04.patch.<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 6/7/07, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Thu, 2007-06-07 at 12:07 +0200, Philippe Gerum wrote:<br>&gt; On Thu, 2007-06-07 at 11:25 +0200, Gilles Chanteperdrix wrote:
<br>&gt; &gt; Jan Kiszka wrote:<br>&gt; &gt; &gt; Perrine Martignoni wrote:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;&gt;Ok. I&#39;ll do this.<br>&gt; &gt; &gt;&gt;<br>&gt; &gt; &gt;&gt;But I don&#39;t understand why the same application compiled without any links
<br>&gt; &gt; &gt;&gt;with Xenomai give different results if there is Xenomai in the kernel.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; [Looking at your numbers again] Hmm, maybe some rounding issue of ticks<br>
&gt; &gt; &gt; due to whatever side-effect of I-pipe. We would first of all need the<br>&gt; &gt; &gt; usual set of information (.config, involved versions) and also<br>&gt; &gt; &gt; /sys/devices/system/clocksource/clocksource0/current_clocksource.
<br>&gt; &gt;<br>&gt; &gt; Maybe what Perrine is observing is simply the overhead of the I-pipe ?<br>&gt; &gt; I mean, Linux is Xenomai idle task, so it is acceptable for Linux<br>&gt; &gt; numbers to be a bit worse than when Xenomai is not running.
<br>&gt; &gt;<br>&gt;<br>&gt; Most of the &quot;known&quot; overhead has disappeared with the PF_EVNOTIFY<br>&gt; extension, so that we relay Linux-originated events (e.g. syscalls) only<br>&gt; to subscribed domains (e.g
. Xenomai).<br><br>... to subscribed tasks from suscribed domains, more precisely. In<br>effect, Xenomai does not filter syscalls issued from plain Linux tasks<br>anymore.<br><br>&gt;&nbsp;&nbsp;In the test case we are discussing<br>
&gt; of, no relay should be done since no domain did subscribe to receive<br>&gt; those events.<br>&gt;<br>&gt; The best way to check if the I-pipe still adds a noticeable overhead is<br>&gt; to compare:<br>&gt;<br>&gt; - a vanilla kernel running cyclic test,
<br>&gt; with<br>&gt; - an I-pipe patched kernel, without Xenomai, using the same .config than<br>&gt; the vanilla kernel used. Without Xenomai either means to not run the<br>&gt; prepare-kernel.sh script, but only patch the kernel with the I-pipe
<br>&gt; support, or disable CONFIG_XENOMAI entirely if the preparation script<br>&gt; has been run on the target kernel tree.<br>&gt;<br>&gt; _Having both kernel setups share the very same kernel configuration is<br>&gt; mandatory, otherwise you would end up comparing apples and oranges._
<br>&gt; The best way to make sure of this is to copy the .config file used for<br>&gt; the vanilla kernel to the I-pipe patched one, and run &quot;make oldconfig&quot;.<br>&gt; You should be prompted only once, for the new CONFIG_IPIPE switch. Any
<br>&gt; other behaviour would be the sign of some discrepancy in your test<br>&gt; configuration.<br>&gt;<br>&gt; Since we can&#39;t have any temporal predictability for such configs, the<br>&gt; max value the cyclic test reports has no meaning. The useful figures are
<br>&gt; the min and average values, as observed for a few minutes while the<br>&gt; board/box is sitting doing nothing but running the test.<br>&gt;<br>&gt; A better way measure such artefacts is to run something like hackbench,
<br>&gt; and compare the execution times, on kernels w/ and w/o the I-pipe.<br>&gt; <a href="http://developer.osdl.org/craiger/hackbench/src/hackbench.c">http://developer.osdl.org/craiger/hackbench/src/hackbench.c</a><br>
&gt; Tune the argument representing the number of process groups which you<br>&gt; pass to this program, so that it runs for a few minutes without putting<br>&gt; your box/board on its knees. There should be no significant difference
<br>&gt; between the time reported at the end of both tests, at the very least,<br>&gt; not a 30% increase as your first report suggested. If the difference is<br>&gt; noticeable, then, there might be an issue (the final conclusion really
<br>&gt; depends on the underlying hw).<br>&gt;<br>--<br>Philippe.<br><br><br><br>_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a>
<br><a href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><br></blockquote></div><br>

------=_Part_28218_1127164.1181218149041--

