Message-ID: <b647ffbd0601111140p38b6229bq@domain.hid>
Date: Wed, 11 Jan 2006 21:40:36 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH, RFC] nucleus:shared irq, draft v.2
In-Reply-To: <17346.54589.751654.349370@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_18695_10176371.1137008436139"
References: <b647ffbd0601091221h5596da2fg@domain.hid>
	<17346.54589.751654.349370@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_18695_10176371.1137008436139
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 09/01/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Dmitry Adamushko wrote:
> > Hi everybody,
> >
> > I'm presenting it one last time as a draft, so it's a right time to giv=
e
> all
> > the remarks concerning design/implementation issues for all interested
> > parties.
> >
> > Any feedback is wellcome.
>
> Maybe I missed some recent changes in Xenomai HAL or Adeos, in which
> case, please forget my remark, but calling xnarch_hook_irq,
> i.e. rthal_irq_request when nklock is locked, irq off, may lead to
> deadlock on multi-processor machines. The situation is (or used to be)
> as follows:
>
> CPU1
> holds the nklock
> calls rthal_irq_request, which calls ipipe_critical_enter, which:
>    triggers the critical IPI
>    spins, waiting for other CPUs to enter __ipipe_do_critical_sync
>
> CPU2
> spins on nklock, irq off
> never handles the critical IPI, because irqs are off


So this a generic "problem" here with spinning on _any_ lock when irqs are
off. And we can't use just a irq_save/restore -less counterparts (even if w=
e
would have those) since there is a need to be synchronized wrt the
irq-handler.

Ok, maybe there is another way rather than the nklock (or any other lock) o=
r
the lock can be used in a different way to avoid deadlock.



I only skimmed over the discussion about ipipe_virtualize_irq_from. I do
> not know if it finally flushes all pending interrupts an all CPUs when
> called with a NULL handler. But if it does, the call to
> xnintr_shirq_spin seems redundant in xnintr_detach.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>



--
Best regards,
Dmitry Adamushko

------=_Part_18695_10176371.1137008436139
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 09/01/06, <b class=3D"gmail_sendern=
ame">Gilles Chanteperdrix</b> &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
poste.net">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquot=
e class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204);=
 margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dmitry Adamushko wrote:<br> &gt; Hi everybody,<br> &gt;<br> &gt; I'm presen=
ting it one last time as a draft, so it's a right time to give all<br> &gt;=
 the remarks concerning design/implementation issues for all interested
<br> &gt; parties.<br> &gt;<br> &gt; Any feedback is wellcome.<br><br>Maybe=
 I missed some recent changes in Xenomai HAL or Adeos, in which<br>case, pl=
ease forget my remark, but calling xnarch_hook_irq,<br>i.e. rthal_irq_reque=
st when nklock is locked, irq off, may lead to
<br>deadlock on multi-processor machines. The situation is (or used to be)<=
br>as follows:<br><br>CPU1<br>holds the nklock<br>calls rthal_irq_request, =
which calls ipipe_critical_enter, which:<br>&nbsp;&nbsp; triggers the criti=
cal IPI
<br>&nbsp;&nbsp; spins, waiting for other CPUs to enter __ipipe_do_critical=
_sync<br><br>CPU2<br>spins on nklock, irq off<br>never handles the critical=
 IPI, because irqs are off</blockquote><div><br>
So this a generic &quot;problem&quot; here with spinning on _any_ lock when=
 irqs
are off. And we can't use just a irq_save/restore -less counterparts
(even if we would have those) since there is a need to be synchronized
wrt the irq-handler.<br>
<br>
Ok, maybe there is another way rather than the nklock (or any other
lock) or the lock can be used in a different way to avoid deadlock.<br>
<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I=
 only skimmed over the discussion about ipipe_virtualize_irq_from. I do<br>=
not know if it finally flushes all pending interrupts an all CPUs when
<br>called with a NULL handler. But if it does, the call to<br>xnintr_shirq=
_spin seems redundant in xnintr_detach.<br><br>--<br><br><br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;Gilles
Chanteperdrix.<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Best =
regards,<br>Dmitry Adamushko

------=_Part_18695_10176371.1137008436139--

