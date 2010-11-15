MIME-Version: 1.0
In-Reply-To: <1289818592.1933.113.camel@domain.hid>
References: <AANLkTing6YXQzXTiGG8PsOPnWM6b2bc0u+Lv3Rmn96je@domain.hid>
	<1289818592.1933.113.camel@domain.hid>
Date: Mon, 15 Nov 2010 21:31:14 +0100
Message-ID: <AANLkTimoU26ON8tys9K5j332ndRWnKJ7V9X7YNECfFeP@mail.gmail.com>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=0016364c743b4f592004951d5292
Subject: Re: [Xenomai-core] Is anybody using the pSOS skin in userland?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-core@domain.hid

--0016364c743b4f592004951d5292
Content-Type: text/plain; charset=ISO-8859-1

Philippe,

The sm_ident patch is fine.

Thanks
Ronny

On Mon, Nov 15, 2010 at 11:56 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Wed, 2010-11-03 at 22:42 +0100, ronny meeus wrote:
> > Hello
> >
> > we are investigating to usage of the pSOS+ skin to port a large legacy
> > pSOS application to Linux.
> > The application model consist of several processes in which the
> > application lives. All processes will make use of the pSOS library.
> >
> > After playing around with the library for some time we have observed
> > several missing service calls, bugs and differences in behaviour
> > compared to a real pSOS implementation:
> > - missing sm_ident
>
>
> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=26e916ecc3f8b71cd8ce4c4194555ee0cc4aa018
>
>
> > - missing t_getreg / t_setreg in userland (patch already included in
> > 2.5.5)
> > - not possible to use skin from the context of different processes
> > (patch already included in 2.5.5)
> > - added support for identical task/queue/semaphore/region names by
> > making names unique.
> > - strange behaviour in pSOS message queue (see post "Possible memory
> > leak in psos skin message queue handling").
> >
> > I can (and will) deliver patches for all issues I have found, but I'm
> > wondering whether there are other people using the pSOS skin (in
> > userland) in a real live application. The target for my project would
> > be an embedded system with strong reliability requirements (very
> > stable / long running etc).
> > Any feedback is welcome and appreciated.
> >
> > It is not clear to me either which tests are executed before a new
> > version is released. Is there any test-suite available for the pSOS
> > skin?
> >
> > Best regards,
> > Ronny
> >
> >
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
>
> --
> Philippe.
>
>
>

--0016364c743b4f592004951d5292
Content-Type: text/html; charset=ISO-8859-1

Philippe,<br><br>The sm_ident patch is fine.<br><br>Thanks<br>Ronny<br><br><div class="gmail_quote">On Mon, Nov 15, 2010 at 11:56 AM, Philippe Gerum <span dir="ltr">&lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class="im">On Wed, 2010-11-03 at 22:42 +0100, ronny meeus wrote:<br>
</div><div class="im">&gt; Hello<br>
&gt;<br>
&gt; we are investigating to usage of the pSOS+ skin to port a large legacy<br>
&gt; pSOS application to Linux.<br>
&gt; The application model consist of several processes in which the<br>
&gt; application lives. All processes will make use of the pSOS library.<br>
&gt;<br>
&gt; After playing around with the library for some time we have observed<br>
&gt; several missing service calls, bugs and differences in behaviour<br>
&gt; compared to a real pSOS implementation:<br>
&gt; - missing sm_ident<br>
<br>
</div><a href="http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=26e916ecc3f8b71cd8ce4c4194555ee0cc4aa018" target="_blank">http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=26e916ecc3f8b71cd8ce4c4194555ee0cc4aa018</a><br>

<div class="im"><br>
<br>
&gt; - missing t_getreg / t_setreg in userland (patch already included in<br>
&gt; 2.5.5)<br>
&gt; - not possible to use skin from the context of different processes<br>
&gt; (patch already included in 2.5.5)<br>
&gt; - added support for identical task/queue/semaphore/region names by<br>
&gt; making names unique.<br>
&gt; - strange behaviour in pSOS message queue (see post &quot;Possible memory<br>
&gt; leak in psos skin message queue handling&quot;).<br>
&gt;<br>
&gt; I can (and will) deliver patches for all issues I have found, but I&#39;m<br>
&gt; wondering whether there are other people using the pSOS skin (in<br>
&gt; userland) in a real live application. The target for my project would<br>
&gt; be an embedded system with strong reliability requirements (very<br>
&gt; stable / long running etc).<br>
&gt; Any feedback is welcome and appreciated.<br>
&gt;<br>
&gt; It is not clear to me either which tests are executed before a new<br>
&gt; version is released. Is there any test-suite available for the pSOS<br>
&gt; skin?<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Ronny<br>
&gt;<br>
&gt;<br>
</div><div><div></div><div class="h5">&gt; _______________________________________________<br>
&gt; Xenomai-core mailing list<br>
&gt; <a href="mailto:Xenomai-core@domain.hid">Xenomai-core@domain.hid</a><br>
&gt; <a href="https://mail.gna.org/listinfo/xenomai-core" target="_blank">https://mail.gna.org/listinfo/xenomai-core</a><br>
<br>
--<br>
Philippe.<br>
<br>
<br>
</div></div></blockquote></div><br>

--0016364c743b4f592004951d5292--

