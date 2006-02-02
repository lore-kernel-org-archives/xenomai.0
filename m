Message-ID: <b647ffbd0602020401k6c33eb00h@domain.hid>
Date: Thu, 2 Feb 2006 14:01:45 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (base,
	/proc support, edge-triggered stuff)
In-Reply-To: <43E1E423.7040908@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_21344_7210276.1138881705428"
References: <b647ffbd0602011323o9ac08b3x@domain.hid>
	<43E1E423.7040908@domain.hid>
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

------=_Part_21344_7210276.1138881705428
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 02/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> > Hi there,
> >
> > as I promised, here go the following patches (ordered as they have to b=
e
> > applied one by one) :
> >
> >
> > 1) shirq-base.patch
> >
> > Adds the "name" field to the interrupt object of the nucleus layer.
> > Reworks the related bits of the native skin (+ a few minor changes for
> > posix and rtdm) to support the named interrupt objects.
> >
> >
> > 2) shirq-v7.patch
> >
> > Generic support for shared interrupts.
> >
> >
> > 3) shirq-proc.patch
> >
> > /proc support.
> >
> > Now /proc/xenomai/irq shows the names of handlers.
> >
> > The related code have been removed from the hal layer to nucleus.
> >
> >
> > -----
> >
> > 4) shirq-isa.patch
> >
> > Trying to handle the edge-triggered stuff.
> >
> > This is a very preliminary version so the only thing I promise so far
> > is that it compiles successfully.
>
> Why not name it XN_ISR_EDGE or so (also the related functions etc.)?
> Although it mostly targets ISA hardware, it's about the edge-triggered
> characteristic of that devices after all.


Ack.

I forgot to apply your earlier fixes so it will be done too.


>
> >
> > The functionality added by first 3 patches seem to be working.
> >
> > --
> > Best regards,
> > Dmitry Adamushko
> >
>
> I'm now trying to organise a full test scenario with shared UART
> ISA-IRQs at our institute. May take till beginning of next week, some
> regressions in our own software need to be fixed first.


That's good. Thanks. Keep me informed on progress.


Jan
>
>
>
>

--
Best regards,
Dmitry Adamushko

------=_Part_21344_7210276.1138881705428
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
<div><span class=3D"gmail_quote">On 02/02/06, <b class=3D"gmail_sendername"=
>Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid<=
/a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-left=
: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1e=
x;">
Dmitry Adamushko wrote:<br>&gt; Hi there,<br>&gt;<br>&gt; as I promised, he=
re go the following patches (ordered as they have to be<br>&gt; applied one=
 by one) :<br>&gt;<br>&gt;<br>&gt; 1) shirq-base.patch<br>&gt;<br>&gt; Adds=
 the &quot;name&quot; field to the interrupt object of the nucleus layer.
<br>&gt; Reworks the related bits of the native skin (+ a few minor changes=
 for<br>&gt; posix and rtdm) to support the named interrupt objects.<br>&gt=
;<br>&gt;<br>&gt; 2) shirq-v7.patch<br>&gt;<br>&gt; Generic support for sha=
red interrupts.
<br>&gt;<br>&gt;<br>&gt; 3) shirq-proc.patch<br>&gt;<br>&gt; /proc support.=
<br>&gt;<br>&gt; Now /proc/xenomai/irq shows the names of handlers.<br>&gt;=
<br>&gt; The related code have been removed from the hal layer to nucleus.
<br>&gt;<br>&gt;<br>&gt; -----<br>&gt;<br>&gt; 4) shirq-isa.patch<br>&gt;<b=
r>&gt; Trying to handle the edge-triggered stuff.<br>&gt;<br>&gt; This is a=
 very preliminary version so the only thing I promise so far<br>&gt; is tha=
t it compiles successfully.
<br><br>Why not name it XN_ISR_EDGE or so (also the related functions etc.)=
?<br>Although it mostly targets ISA hardware, it's about the edge-triggered=
<br>characteristic of that devices after all.</blockquote><div><br>
Ack.<br>
<br>
I forgot to apply your earlier fixes so it will be done too. <br>
<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br=
>&gt;<br>&gt; The functionality added by first 3 patches seem to be working=
.
<br>&gt;<br>&gt; --<br>&gt; Best regards,<br>&gt; Dmitry Adamushko<br>&gt;<=
br><br>I'm now trying to organise a full test scenario with shared UART<br>=
ISA-IRQs at our institute. May take till beginning of next week, some<br>
regressions in our own software need to be fixed first.</blockquote><div><b=
r>
That's good. Thanks. Keep me informed on progress.<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">J=
an<br><br><br><br></blockquote></div><br><br>-- <br>Best regards,<br>Dmitry=
 Adamushko

------=_Part_21344_7210276.1138881705428--

