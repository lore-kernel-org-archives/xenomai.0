Message-ID: <7289437c0705110056o130c4fd4t419e37f573110d5d@domain.hid>
Date: Fri, 11 May 2007 09:56:18 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <46433E26.8040307@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_68564_3324694.1178870178427"
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
	<17986.20728.617772.991566@domain.hid>
	<1178784303.11688.108.camel@domain.hid> <4642D901.9050304@domain.hid>
	<1178789171.11688.142.camel@domain.hid> <4642E706.7000500@domain.hid>
	<1178808027.11688.150.camel@domain.hid> <464331CF.3090505@domain.hid>
	<1178810494.11688.188.camel@domain.hid> <46433E26.8040307@domain.hid>
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

------=_Part_68564_3324694.1178870178427
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tested the final patch and it doesn't work on the file heap.h.
It seems I haven't the same code in the file at start. I use xenomai-2.3.1.
For which version is the patch?
Thanks

On 5/10/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Philippe Gerum wrote:
> > On Thu, 2007-05-10 at 16:53 +0200, Gilles Chanteperdrix wrote:
> >
> >>Philippe Gerum wrote:
> >>
> >>>On Thu, 2007-05-10 at 11:33 +0200, Gilles Chanteperdrix wrote:
> >>>
> >>>
> >>>>Philippe Gerum wrote:
> >>>>
> >>>>>xnfreesafe was meant to prevent the caller from releasing some memory
> it
> >>>>>could still rely on, e.g. stack space, by postponing the actual
> release
> >>>>>until the idle thread is resumed. In your case, the problem is that
> it
> >>>>>does not account for the primary/secondary mode of a shadow thread.
> >>>>
> >>>>I am not so sure. I mean, even if the thread was deleted from the
> >>>>context of another thread, the two hooks would be invoked and we would
> >>>>need the free operation to be deferred until after the execution of
> the
> >>>>second hook.
> >>>>
> >>>
> >>>
> >>>The point is that deletion hooks are always called on behalf of the
> >>>exiting thread in secondary mode, so if xnfreesafe properly identifies
> >>>the caller as the current thread - regardless of its exec mode - then
> >>>the deferral should always take place. But I agree on the fact that we
> >>>should always end up running the deferred call in this context anyway,
> >>>so we would be better off calling xnheap_schedule_free() directly.
> >>
> >>That is why, since xnfreesafe was only called in this precise context, I
> >>redefined it to call xnheap_schedule_free directly.
> >>
> >
> >
> > Well, ok. But we may need the xnfreesafe() interface in the future, the
> > way it was designed initially, I mean. So let's call
> > xnheap_schedule_free directly when needed.
> >
>
> Hence the final patch:
>
> --
>                                                 Gilles Chanteperdrix
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>
>

------=_Part_68564_3324694.1178870178427
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I tested the final patch and it doesn&#39;t work on the file heap.h.</div>
<div>It seems I haven&#39;t the same code in the file at start. I use xenomai-2.3.1.<br>For which version&nbsp;is the patch?</div>
<div>Thanks</div>
<div>&nbsp;</div>
<div><span class="gmail_quote">On 5/10/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Philippe Gerum wrote:<br>&gt; On Thu, 2007-05-10 at 16:53 +0200, Gilles Chanteperdrix wrote:<br>&gt;<br>&gt;&gt;Philippe Gerum wrote:
<br>&gt;&gt;<br>&gt;&gt;&gt;On Thu, 2007-05-10 at 11:33 +0200, Gilles Chanteperdrix wrote:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;Philippe Gerum wrote:<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;xnfreesafe was meant to prevent the caller from releasing some memory it
<br>&gt;&gt;&gt;&gt;&gt;could still rely on, e.g. stack space, by postponing the actual release<br>&gt;&gt;&gt;&gt;&gt;until the idle thread is resumed. In your case, the problem is that it<br>&gt;&gt;&gt;&gt;&gt;does not account for the primary/secondary mode of a shadow thread.
<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;I am not so sure. I mean, even if the thread was deleted from the<br>&gt;&gt;&gt;&gt;context of another thread, the two hooks would be invoked and we would<br>&gt;&gt;&gt;&gt;need the free operation to be deferred until after the execution of the
<br>&gt;&gt;&gt;&gt;second hook.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;The point is that deletion hooks are always called on behalf of the<br>&gt;&gt;&gt;exiting thread in secondary mode, so if xnfreesafe properly identifies
<br>&gt;&gt;&gt;the caller as the current thread - regardless of its exec mode - then<br>&gt;&gt;&gt;the deferral should always take place. But I agree on the fact that we<br>&gt;&gt;&gt;should always end up running the deferred call in this context anyway,
<br>&gt;&gt;&gt;so we would be better off calling xnheap_schedule_free() directly.<br>&gt;&gt;<br>&gt;&gt;That is why, since xnfreesafe was only called in this precise context, I<br>&gt;&gt;redefined it to call xnheap_schedule_free directly.
<br>&gt;&gt;<br>&gt;<br>&gt;<br>&gt; Well, ok. But we may need the xnfreesafe() interface in the future, the<br>&gt; way it was designed initially, I mean. So let&#39;s call<br>&gt; xnheap_schedule_free directly when needed.
<br>&gt;<br><br>Hence the final patch:<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix<br><br>_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">
Xenomai-help@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><br><br><br></blockquote></div><br>

------=_Part_68564_3324694.1178870178427--

