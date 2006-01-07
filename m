Message-ID: <b647ffbd0601071105p746bf2ebx@domain.hid>
Date: Sat, 7 Jan 2006 21:05:06 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <43B69CEC.1040606@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3408_23838151.1136660706742"
References: <b647ffbd0512310437x6e92487es@domain.hid>
	<43B69CEC.1040606@domain.hid>
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

------=_Part_3408_23838151.1136660706742
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 31/12/05, Philippe Gerum <rpm@xenomai.org> wrote:
> ...

> 2) xnintr_irq_handler() gets a cookie which is =3D=3D xnshared_irq_t* (se=
e
> > xnintr_attach) that may already be invalid at that time or, and that's =
a
> > problem, become invalid during the execution of xnintr_irq_handler().
> > To prevent that, we could add a flag like IRQ_INPROGRESS but
> >
> > either we have to set/remove it on the adeos layer before the control i=
s
> > passed to the xnintr_irq_handler() (to be sure that cookie is not
> > xnfree()'d. xnintr_detach() will do busy waiting)
> >
>
> Synchronizing the pending IRQs in ipipe_virtualize_irq() should be done
> by polling the proper irq_pending count (and _not_ the hi/lo bits which
> get cleared before the handler is run).


But irq_pending counter (pending_hits in the recent adeos patch) gets
cleared before running the isr handler too.

In ipipe_sync_stage() :
...
            if (--cpudata->irq_pending_hits[irq] =3D=3D 0) {
                 __clear_bit(rank,
                         &cpudata->irq_pending_lo[level]);
                 ipipe_mark_irq_delivery(ipd,irq,cpuid);
            }
(*)

// run the corresponding isr handler

This code drops the irq_pending_hits to 0 before running the handler.

Doesn't it make the following code wrong ?

for (_cpuid =3D 0; _cpuid < nr_cpus; _cpuid++)
>         while (ipd->cpudata[_cpuid].irq_pending_hits[irq] > 0)
>                 cpu_relax();


as the handler still can be running / or even about to be run when
ipd->cpudata[_cpuid].irq_pending_hits[irq] is already 0.

We can remove the (*) code at the end of ipipe_sync_stage() so that
irq_pending_hits[irq] may become 0 only after the corresponding isr handler
has completed.

At the same time, the irq_pending counter can't be increased anymore since
we clear the IPIPE_HANDLE_FLAG before doing the busy waiting in
ipipe_unregister_domain() or ipipe_virtualize_irq().


--
>
> Philippe.
>

--
Best regards,
Dmitry Adamushko

------=_Part_3408_23838151.1136660706742
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 31/12/05, <b class=3D"gmail_sen=
dername">Philippe Gerum</b> &lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
mai.org</a>&gt; wrote:</span><div><br>
&gt; ... <br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; 2)=
 xnintr_irq_handler() gets a cookie which is =3D=3D xnshared_irq_t* (see<br=
>&gt; xnintr_attach) that may already be invalid at that time or, and that'=
s a
<br>&gt; problem, become invalid during the execution of xnintr_irq_handler=
().<br>&gt; To prevent that, we could add a flag like IRQ_INPROGRESS but<br=
>&gt;<br>&gt; either we have to set/remove it on the adeos layer before the=
 control is
<br>&gt; passed to the xnintr_irq_handler() (to be sure that cookie is not<=
br>&gt; xnfree()'d. xnintr_detach() will do busy waiting)<br>&gt;<br><br>Sy=
nchronizing the pending IRQs in ipipe_virtualize_irq() should be done<br>
by polling the proper irq_pending count (and _not_ the hi/lo bits which<br>=
get cleared before the handler is run). </blockquote><div><br>
But irq_pending counter (pending_hits in the recent adeos patch) gets clear=
ed before running the isr handler too.<br>
<br>
In ipipe_sync_stage() :<br>
...<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (--cpudata-&gt;=
irq_pending_hits[irq] =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; __clear_bit(rank,<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&amp;cpudata-&gt;irq_pending_lo[level]);<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; ipipe_mark_irq_delivery(ipd,irq,cpuid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
(*)<br>
<br>
// run the corresponding isr handler<br>
<br>
This code drops the irq_pending_hits to 0 before running the handler.<br>
<br>
Doesn't it make the following code wrong ?<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">for (_cpuid=
 =3D 0; _cpuid &lt; nr_cpus; _cpuid++)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;while (ipd-&gt;cpudata[_cpuid].irq_pending_hits[irq] &gt; 0)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;cpu_relax();</blockquote><div><br>
as the handler still can be running / or even about to be run when ipd-&gt;=
cpudata[_cpuid].irq_pending_hits[irq] is already 0.<br>
<br>
We can remove the (*) code at the end of ipipe_sync_stage() so that
irq_pending_hits[irq] may become 0 only after the corresponding isr
handler has completed.<br>
<br>
At the same time, the irq_pending counter can't be increased anymore
since we clear the IPIPE_HANDLE_FLAG before doing the busy waiting in
ipipe_unregister_domain() or ipipe_virtualize_irq().<br>
&nbsp;<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br><br>P=
hilippe.<br></blockquote></div><br>-- <br>Best regards,<br>Dmitry Adamushko
<br>
<br>


------=_Part_3408_23838151.1136660706742--

