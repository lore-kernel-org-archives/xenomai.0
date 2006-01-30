Message-ID: <b647ffbd0601300337g2387b9f5w@domain.hid>
Date: Mon, 30 Jan 2006 13:37:07 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
In-Reply-To: <43D62B07.3030703@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1285_20778180.1138621027107"
References: <43D21144.8040005@domain.hid>
	<b647ffbd0601220010x3cc023an@domain.hid>
	<fd6a47a90601220819n3f4cd382t@domain.hid>
	<E1F16LA-0001ku-C4@domain.hid>
	<b647ffbd0601240514m11a11a64u@domain.hid>
	<43D62B07.3030703@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_1285_20778180.1138621027107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>> ...

> I have not checked it yet but my presupposition that something as easy as
> :
> >
> > preempt_disable()
> >
> > wake_up_interruptible_sync();
> > schedule();
> >
> > preempt_enable();
>
> It's a no-go: "scheduling while atomic". One of my first attempts to
> solve it.


My fault. I meant the way preempt_schedule() and preempt_irq_schedule() cal=
l
schedule() while being non-preemptible.
To this end, ACTIVE_PREEMPT is set up.
The use of preempt_enable/disable() here is wrong.


The only way to enter schedule() without being preemptible is via
> ACTIVE_PREEMPT. But the effect of that flag should be well-known now.
> Kind of Gordian knot. :(


Maybe I have missed something so just for my curiosity : what does prevent
the use of PREEMPT_ACTIVE here?
We don't have a "preempted while atomic" message here as it seems to be a
legal way to call schedule() with that flag being set up.


>
> >
> > could work... err.. and don't blame me if no, it's some one else who ha=
s
> > written that nonsense :o)
> >
> > --
> > Best regards,
> > Dmitry Adamushko
> >
>
> Jan
>
>
>
>


--
Best regards,
Dmitry Adamushko

------=_Part_1285_20778180.1138621027107
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>&gt;&gt; ...<br>
<div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; I h=
ave not checked it yet but my presupposition that something as easy as :<br=
>
&gt;<br>&gt; preempt_disable()<br>&gt;<br>&gt; wake_up_interruptible_sync()=
;<br>&gt; schedule();<br>&gt;<br>&gt; preempt_enable();<br><br>It's a no-go=
: &quot;scheduling while atomic&quot;. One of my first attempts to<br>solve=
 it.
</blockquote><div><br>
My fault. I meant the way preempt_schedule() and preempt_irq_schedule() cal=
l schedule() while being non-preemptible.<br>
To this end, ACTIVE_PREEMPT is set up.<br>
The use of preempt_enable/disable() here is wrong.<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">T=
he only way to enter schedule() without being preemptible is via<br>ACTIVE_=
PREEMPT. But the effect of that flag should be well-known now.
<br>Kind of Gordian knot. :(</blockquote><div><br>
Maybe I have missed something so just for my curiosity : what does prevent =
the use of PREEMPT_ACTIVE here?<br>
We don't have a &quot;preempted while atomic&quot; message here as it seems=
 to be
a legal way to call schedule() with that flag being set up.<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&=
gt;<br>&gt;<br>&gt; could work... err.. and don't blame me if no, it's some=
 one else who has
<br>&gt; written that nonsense :o)<br>&gt;<br>&gt; --<br>&gt; Best regards,=
<br>&gt; Dmitry Adamushko<br>&gt;<br><br>Jan<br><br><br><br></blockquote></=
div><br><br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_1285_20778180.1138621027107--

