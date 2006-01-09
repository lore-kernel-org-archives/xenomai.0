Message-ID: <b647ffbd0601091214p18fbd37s@domain.hid>
Date: Mon, 9 Jan 2006 22:14:27 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <43C0F792.3000300@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_25763_10438636.1136837667817"
References: <b647ffbd0512310437x6e92487es@domain.hid>
	<43B69CEC.1040606@domain.hid>
	<b647ffbd0601071105p746bf2ebx@domain.hid>
	<43C0F792.3000300@domain.hid>
Subject: [Xenomai-core] Re: [PATCH,
	RFC] nucleus:shared irq and possible ipipe problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_25763_10438636.1136837667817
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 08/01/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
> > [skiped]

> In ipipe_sync_stage() :

> > ...
> >             if (--cpudata->irq_pending_hits[irq] =3D=3D 0) {
> >                  __clear_bit(rank,
> >                          &cpudata->irq_pending_lo[level]);
> >                  ipipe_mark_irq_delivery(ipd,irq,cpuid);
> >             }
> > (*)
> >
> > // run the corresponding isr handler
> >
> > This code drops the irq_pending_hits to 0 before running the handler.
> >
>
> > Doesn't it make the following code wrong ?
> >
> >     for (_cpuid =3D 0; _cpuid < nr_cpus; _cpuid++)
> >             while (ipd->cpudata[_cpuid].irq_pending_hits[irq] > 0)
> >                     cpu_relax();
> >
> >
> > as the handler still can be running / or even about to be run when
> > ipd->cpudata[_cpuid].irq_pending_hits[irq] is already 0.
> >
> > We can remove the (*) code at the end of ipipe_sync_stage() so that
> > irq_pending_hits[irq] may become 0 only after the corresponding isr
> > handler has completed.
> >
>
> I don't like the idea of having the interrupt bookkeeping stuff
> incompletely updated while calling a handler that might sleep and/or
> migrate to another CPU.
>
> Another option would be to check for SYNC flag; the syncer sets it
> before entering the dispatch loop.


It's unset for all domains but root when the corresponding irq handler is
running.

ipipe_sync_stage() :
...
            __clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);
            ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
            __set_bit(IPIPE_SYNC_FLAG, &cpudata->status);

So it doesn't help here as it is used now.

Ok, so far I have built all synchronization completely on the nucleus layer=
,
provided that the "cookie" param is not used as it is passed to the handler
but is taken via the rthal_irq_cookie() service being in a protected
section.

The disadvantage so far is that the recently extended adeos irq interface i=
s
not used as it is supposed to be (the "cookie" argument of the handler).

I'll post the current version of the patch in the separate mail.

--
>
> Philippe.
>



--
Best regards,
Dmitry Adamushko

------=_Part_25763_10438636.1136837667817
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 08/01/06, <b class=3D"gmail_sendern=
ame">Philippe Gerum</b> &lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org.=
org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
&gt; [skiped]</blockquote>&gt; In ipipe_sync_stage() :<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; ...<br>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(--cpudata-&gt;irq_pending_hits[irq] =3D=3D 0) {<br>&gt;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;__clear_bit(rank,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&amp;cpudata-&gt;irq_pending_lo[level]);<br>&gt;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;ipipe_mark_irq_delivery(ipd,irq,cpuid);<br>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt; =
(*)<br>&gt;<br>&gt; // run the corresponding isr handler
<br>&gt;<br>&gt; This code drops the irq_pending_hits to 0 before running t=
he handler.<br>&gt;<br><br>&gt; Doesn't it make the following code wrong ?<=
br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; for (_cpuid =3D 0; _cpuid &lt; nr_c=
pus; _cpuid++)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; while (ipd-&gt;cpudata[_cpuid].irq_pending_hits[irq] &gt; 0)<br>&gt;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
cpu_relax();<br>&gt;<br>&gt;<br>&gt; as the handler still can be running / =
or even about to be run when<br>&gt; ipd-&gt;cpudata[_cpuid].irq_pending_hi=
ts[irq] is already 0.<br>&gt;<br>&gt; We can remove the (*) code at the end=
 of ipipe_sync_stage() so that
<br>&gt; irq_pending_hits[irq] may become 0 only after the corresponding is=
r<br>&gt; handler has completed.<br>&gt;<br><br>I don't like the idea of ha=
ving the interrupt bookkeeping stuff<br>incompletely updated while calling =
a handler that might sleep and/or
<br>migrate to another CPU.<br><br>Another option would be to check for SYN=
C flag; the syncer sets it<br>before entering the dispatch loop.</blockquot=
e><div><br>
It's unset for all domains but root when the corresponding irq handler is r=
unning.<br>
<br>
ipipe_sync_stage() :<br>
...<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __clear_bit(IPIPE_=
SYNC_FLAG, &amp;cpudata-&gt;status);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ipd-&gt;irqs[irq].=
handler(irq, ipd-&gt;irqs[irq].cookie);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __set_bit(IPIPE_SY=
NC_FLAG, &amp;cpudata-&gt;status);<br>
<br>
So it doesn't help here as it is used now.<br>
</div><br>
Ok, so far I have built all synchronization completely on the nucleus
layer, provided that the &quot;cookie&quot; param is not used as it is pass=
ed to
the handler but is taken via the rthal_irq_cookie() service being in a
protected section.<br>
<br>
The disadvantage so far is that the recently extended adeos irq
interface is not used as it is supposed to be (the &quot;cookie&quot; argum=
ent of
the handler).<br>
<div><br>
I'll post the current version of the patch in the separate mail.<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br><=
br>Philippe.<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Best re=
gards,
<br>Dmitry Adamushko

------=_Part_25763_10438636.1136837667817--

