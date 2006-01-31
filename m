Message-ID: <b647ffbd0601311150t6092a758w@domain.hid>
Date: Tue, 31 Jan 2006 21:50:25 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Shared irqs v.6
In-Reply-To: <43DFB5F9.50406@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_23465_19887500.1138737025170"
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>
	<43DFB5F9.50406@domain.hid>
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

------=_Part_23465_19887500.1138737025170
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 31/01/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> > Hi,
> >
> > the previous version contained an ugly bug, namely the misuse of the
> > test_and_set/clear_bit interface
> > that led to a broken system from time to time.
> >
>
> What about the ISA/edge-triggered stuff? :D
>
> My problem is that we cannot test here on real hardware because all our
> shared IRQs reside on PC104 cards.


Could you provide me with some real piece of such code as an example?

Anyway, design-wise, it's about introducing a separate xnintr_handler() for
such a special case to avoid getting a mixture with the rest of "sane" code=
.
I mean that the support of shared interrupts for ISA boards (edge-triggered
stuff) is a kind of emulation to overcome the shortcommings of the initial
design on the hardware level. The hardware was just not supposed to support
shared interrupt channels. So, let's keep it a bit aside from another code
:o)

xnintr_attach() will check for a special flag like XN_ISR_ISASHARED and
attach e.g. xnintr_isairq_handler() instead of xnintr_irq_handler().

I'll post an extension to the rt_intr_create(..., const char *name, ...)
tomorrow - made but not tested yet -

as well as the /proc support.


Jan
>


--
Best regards,
Dmitry Adamushko

------=_Part_23465_19887500.1138737025170
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 31/01/06, <b class=3D"gmail_sendern=
ame">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid=
.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Dmitry Adamushko wrote:<br>&gt; Hi,<br>&gt;<br>&gt; the previous version co=
ntained an ugly bug, namely the misuse of the<br>&gt; test_and_set/clear_bi=
t interface<br>&gt; that led to a broken system from time to time.<br>&gt;
<br><br>What about the ISA/edge-triggered stuff? :D<br><br>My problem is th=
at we cannot test here on real hardware because all our<br>shared IRQs resi=
de on PC104 cards.</blockquote><div><br>
Could you provide me with some real piece of such code as an example?<br>
<br>
Anyway, design-wise, it's about introducing a separate xnintr_handler()
for such a special case to avoid getting a mixture with the rest of
&quot;sane&quot; code. I mean that the support of shared interrupts for ISA
boards (edge-triggered stuff) is a kind of emulation to overcome the
shortcommings of the initial design on the hardware level. The hardware
was just not supposed to support shared interrupt channels. So, let's
keep it a bit aside from another code :o)<br>
<br>
xnintr_attach() will check for a special flag like XN_ISR_ISASHARED and
attach e.g. xnintr_isairq_handler() instead of xnintr_irq_handler().<br>
&nbsp;<br>
I'll post an extension to the rt_intr_create(..., const char *name, ...) to=
morrow - made but not tested yet -<br>
<br>
as well as the /proc support.<br>
<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br>=
</blockquote></div><br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry Ada=
mushko
<br>
<br>


------=_Part_23465_19887500.1138737025170--

