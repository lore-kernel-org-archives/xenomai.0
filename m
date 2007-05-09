Message-ID: <7289437c0705090643gc9f0ddax6fa6cff44895c9ed@domain.hid>
Date: Wed, 9 May 2007 15:43:09 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <4641CD8B.8050309@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_54679_18317919.1178718189273"
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
	<4641CD8B.8050309@domain.hid>
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

------=_Part_54679_18317919.1178718189273
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'll do that as soon as I can.
Thanks

On 5/9/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Noren, Andrew wrote:
> > Hi Gilles,
> >
> > I too have encountered this issue with the POSIX skin.
> > I think it may have to do with the order in which the posix skin hooks
> > are run on thread deletion.
> >
> > In ksrc/skins/posix/syscall.c
> > xnpod_remove_hook(XNHOOK_THREAD_DELETE, &__shadow_delete_hook);
> >
> > and ksrc/skins/posix/thread.c
> > xnpod_add_hook(XNHOOK_THREAD_DELETE, thread_delete_hook);
> >
> > The thread_delete_hook seems to run first causing the thread data to be
> > destroyed before __shadow_delete_hook has a chance to run.
> >
> > This results in __shadow_delete_hook failing in various cases.
> >
> > An example of an error case linked with this would be the failure to
> > remove the thread key from the hash bucket after application exit.  The
> > next run of an application can then result in pthread_setschedparam
> > failing to create a shadow since it likely finds an id in the hash
> > bucket already.
>
> Hi,
>
> thanks for pointing this out, I see other skins use xnfreesafe in their
> thread deletion hook instead of xnfree. The attached patch fixes this.
>
> Perrine, could you apply this patch and check that it solves your issue ?
>
> --
>                                                 Gilles Chanteperdrix
>
>

------=_Part_54679_18317919.1178718189273
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I&#39;ll do that as soon as I can.</div>
<div>Thanks<br>&nbsp;</div>
<div><span class="gmail_quote">On 5/9/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Noren, Andrew wrote:<br>&gt; Hi Gilles,<br>&gt;<br>&gt; I too have encountered this issue with the POSIX skin.
<br>&gt; I think it may have to do with the order in which the posix skin hooks<br>&gt; are run on thread deletion.<br>&gt;<br>&gt; In ksrc/skins/posix/syscall.c<br>&gt; xnpod_remove_hook(XNHOOK_THREAD_DELETE, &amp;__shadow_delete_hook);
<br>&gt;<br>&gt; and ksrc/skins/posix/thread.c<br>&gt; xnpod_add_hook(XNHOOK_THREAD_DELETE, thread_delete_hook);<br>&gt;<br>&gt; The thread_delete_hook seems to run first causing the thread data to be<br>&gt; destroyed before __shadow_delete_hook has a chance to run.
<br>&gt;<br>&gt; This results in __shadow_delete_hook failing in various cases.<br>&gt;<br>&gt; An example of an error case linked with this would be the failure to<br>&gt; remove the thread key from the hash bucket after application exit.&nbsp;&nbsp;The
<br>&gt; next run of an application can then result in pthread_setschedparam<br>&gt; failing to create a shadow since it likely finds an id in the hash<br>&gt; bucket already.<br><br>Hi,<br><br>thanks for pointing this out, I see other skins use xnfreesafe in their
<br>thread deletion hook instead of xnfree. The attached patch fixes this.<br><br>Perrine, could you apply this patch and check that it solves your issue ?<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix
<br><br></blockquote></div><br>

------=_Part_54679_18317919.1178718189273--

