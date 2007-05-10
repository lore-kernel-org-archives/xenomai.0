Message-ID: <7289437c0705100441l4f9e8cd9l7e7c447cedd1e5c2@domain.hid>
Date: Thu, 10 May 2007 13:41:07 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <4642E706.7000500@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_61945_32887328.1178797267109"
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
	<7289437c0705090735n58b4a0fbm7e31c8571efb7514@domain.hid>
	<17986.12574.488256.997900@domain.hid>
	<17986.15326.243315.427529@domain.hid>
	<1178748178.11688.45.camel@domain.hid>
	<17986.20728.617772.991566@domain.hid>
	<1178784303.11688.108.camel@domain.hid> <4642D901.9050304@domain.hid>
	<1178789171.11688.142.camel@domain.hid> <4642E706.7000500@domain.hid>
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_61945_32887328.1178797267109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It works fine when I disable RPI.
Thanks.

The patch xeno-safer-xnfreesafe allows to enable RPI?

On 5/10/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Philippe Gerum wrote:
> > On Thu, 2007-05-10 at 10:34 +0200, Gilles Chanteperdrix wrote:
> >
> >>>> >
> >>>> > Ok, I could reproduce the problem. The issue is most likely an
> access to
> >>>> > the thread memory after it has been freed which breaks the
> allocator
> >>>> > linked list of free pages by replacing a link to a next free page
> by a
> >>>> > NULL pointer. xnheap_alloc interprets this NULL pointer as the end
> of the
> >>>> > linked list and hence considers that it is out of memory.
> >>>>
> >>>>And the winner is... RPI! The offset of the thread structure member
> that
> >>>>is set to NULL is the one of the rpi pointer. Disabling RPI makes the
> >>>>problem vanish.
> >>>>
> >>>>Philippe, when is this pointer set to NULL ?
> >>>>
> >>>
> >>>When the thread leaves secondary mode or exits, which in turn removes
> it
> >>>from the queue the nucleus considers for priority boosting the root
> >>>thread. Check rpi_none().
> >>
> >>Conclusion: the problem is the one Andrew spotted, there are two
> >>hooks and the shadow hook (which calls xnshadow_unmap, which in turn
> >>calls rpi_pop, which sets the rpi pointer to null) gets called after the
> >>other thread deletion hook which initially called xnfree, and now calls
> >>xnfreesafe.
> >>
> >>But it seems that even xnfreesafe is not safe enough, and it frees the
> >>thread pointer immediately whereas we would like the operation to be
> >>deferred.
> >>
> >
> >
> > xnfreesafe was meant to prevent the caller from releasing some memory it
> > could still rely on, e.g. stack space, by postponing the actual release
> > until the idle thread is resumed. In your case, the problem is that it
> > does not account for the primary/secondary mode of a shadow thread.
>
> I am not so sure. I mean, even if the thread was deleted from the
> context of another thread, the two hooks would be invoked and we would
> need the free operation to be deferred until after the execution of the
> second hook.
>
> --
>                                                 Gilles Chanteperdrix
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_61945_32887328.1178797267109
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>It works fine when I disable RPI.</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>The patch xeno-safer-xnfreesafe allows to enable RPI?<br>&nbsp;</div>
<div><span class="gmail_quote">On 5/10/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Philippe Gerum wrote:<br>&gt; On Thu, 2007-05-10 at 10:34 +0200, Gilles Chanteperdrix wrote:<br>&gt;<br>&gt;&gt;&gt;&gt; &gt;
<br>&gt;&gt;&gt;&gt; &gt; Ok, I could reproduce the problem. The issue is most likely an access to<br>&gt;&gt;&gt;&gt; &gt; the thread memory after it has been freed which breaks the allocator<br>&gt;&gt;&gt;&gt; &gt; linked list of free pages by replacing a link to a next free page by a
<br>&gt;&gt;&gt;&gt; &gt; NULL pointer. xnheap_alloc interprets this NULL pointer as the end of the<br>&gt;&gt;&gt;&gt; &gt; linked list and hence considers that it is out of memory.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;And the winner is... RPI! The offset of the thread structure member that
<br>&gt;&gt;&gt;&gt;is set to NULL is the one of the rpi pointer. Disabling RPI makes the<br>&gt;&gt;&gt;&gt;problem vanish.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;Philippe, when is this pointer set to NULL ?<br>&gt;&gt;&gt;&gt;
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;When the thread leaves secondary mode or exits, which in turn removes it<br>&gt;&gt;&gt;from the queue the nucleus considers for priority boosting the root<br>&gt;&gt;&gt;thread. Check rpi_none().
<br>&gt;&gt;<br>&gt;&gt;Conclusion: the problem is the one Andrew spotted, there are two<br>&gt;&gt;hooks and the shadow hook (which calls xnshadow_unmap, which in turn<br>&gt;&gt;calls rpi_pop, which sets the rpi pointer to null) gets called after the
<br>&gt;&gt;other thread deletion hook which initially called xnfree, and now calls<br>&gt;&gt;xnfreesafe.<br>&gt;&gt;<br>&gt;&gt;But it seems that even xnfreesafe is not safe enough, and it frees the<br>&gt;&gt;thread pointer immediately whereas we would like the operation to be
<br>&gt;&gt;deferred.<br>&gt;&gt;<br>&gt;<br>&gt;<br>&gt; xnfreesafe was meant to prevent the caller from releasing some memory it<br>&gt; could still rely on, e.g. stack space, by postponing the actual release<br>&gt; until the idle thread is resumed. In your case, the problem is that it
<br>&gt; does not account for the primary/secondary mode of a shadow thread.<br><br>I am not so sure. I mean, even if the thread was deleted from the<br>context of another thread, the two hooks would be invoked and we would
<br>need the free operation to be deferred until after the execution of the<br>second hook.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix<br><br>_______________________________________________
<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><br></blockquote></div>
<br>

------=_Part_61945_32887328.1178797267109--

