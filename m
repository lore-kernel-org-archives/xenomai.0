Message-ID: <b647ffbd0602071124g2b43366bi@domain.hid>
Date: Tue, 7 Feb 2006 21:24:49 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
In-Reply-To: <43E86F4D.4050400@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_23190_7612946.1139340289638"
References: <b647ffbd0602070104s63275903q@domain.hid>
	<43E86F4D.4050400@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_23190_7612946.1139340289638
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 07/02/06, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> Hello,
>
> > [skip-skip-skip]
> > Happy testing ! :)
>
> My concern is code size. I see that the patches add substantial amount
> of code to the ISR. What about make this feature configurable?


Yes, I though about making the new stuff optionally configurable.

But another option would be to leave the xnintr_irq_handler() as it was
before and to introduce a separate handler for the shared interrupts.
edge-triggeres interrupts already have the distinct handler
(xnintr_edgeirq_handler()).

I guess the additional code in xnintr_attach/detach() and a few (~1 for UP
and ~2 for SMP) KBs of data are not that critical taking into account where
and how they are used, both latency and cache-wise.


Wolfgang.
>
> > --
> > Best regards,
> > Dmitry Adamushko
> >
> >
> > -----------------------------------------------------------------------=
-
> >
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
>
>

--
Best regards,
Dmitry Adamushko

------=_Part_23190_7612946.1139340289638
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 07/02/06, <b class=3D"gmail_sen=
dername">Wolfgang Grandegger</b> &lt;<a href=3D"mailto:wg@domain.hid">w=
g@domain.hid</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
Hello,<br><br>&gt; [skip-skip-skip]<br>&gt; Happy testing ! :)<br><br>My co=
ncern is code size. I see that the patches add substantial amount<br>of cod=
e to the ISR. What about make this feature configurable?</blockquote><div>
<br>
Yes, I though about making the new stuff optionally configurable. <br>
<br>
But another option would be to leave the xnintr_irq_handler() as it was
before and to introduce a separate handler for the shared interrupts.
edge-triggeres interrupts already have the distinct handler
(xnintr_edgeirq_handler()).<br>
<br>
</div>I guess the additional code in xnintr_attach/detach() and a few
(~1 for UP and ~2 for SMP) KBs of data are not that critical taking
into account where and how they are used, both latency and cache-wise.<br>
<br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Wolfgang.<br>=
<br>&gt; --<br>&gt; Best regards,<br>&gt; Dmitry Adamushko<br>&gt;<br>&gt;
<br>&gt; ------------------------------------------------------------------=
------<br>&gt;<br>&gt; _______________________________________________<br>&=
gt; Xenomai-core mailing list<br>&gt; <a href=3D"mailto:Xenomai-core@domain.hid=
g">
Xenomai-core@domain.hid</a><br>&gt; <a href=3D"https://mail.gna.org/listinfo/x=
enomai-core">https://mail.gna.org/listinfo/xenomai-core</a><br><br></blockq=
uote></div><br><br clear=3D"all">-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_23190_7612946.1139340289638--

