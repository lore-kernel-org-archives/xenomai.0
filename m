Message-ID: <b647ffbd0601021043n1e8704aco@domain.hid>
Date: Mon, 2 Jan 2006 20:43:05 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <b647ffbd0601021042h140c0f7dk@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12011_21543055.1136227385479"
References: <b647ffbd0512310437x6e92487es@domain.hid>
	<43B69CEC.1040606@domain.hid>
	<b647ffbd0601021042h140c0f7dk@domain.hid>
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
To: xenomai@xenomai.org

------=_Part_12011_21543055.1136227385479
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> Nope, good spot, that could indeed happen in SMP configs. The code is
> expected to shut the given interrupt source _before_ calling
> rthal_irq_release(). But, the root of the problem is that
> rthal_irq_release() doesn't make sure that all _pending_ IRQs from the
> given kind are synchronized before processing. We need the equivalent of
> Linux's synchronize_irq() here, and I would tend to implement this in
> the Adeos layer directly, in ipipe_virtualize_irq() for the NULL handler
> case, since it's a matter of general consistency.


Yep, I thought about the analogue of Linux's synchronize_irq() too.
I guess, what we need to provide is the guarantee that the "cookie" argumen=
t
(as well as a "handler") remains valid as long as there is a given irq
handler in execution.

i.e.

o  ipipe_virtualize_irq(THIS_IRQ, handler=3DNULL, cookie=3DNULL) call _remo=
ves_
the IPIPE_HANDLE_FLAG so that new occurences of the THIS_IRQ is no more
accepted for the given domain;

o  then ipipe_virtualize_irq is buzy waiting (ipipe_synchronize_irq() or
smth like this) until the active ipd->irqs[THIS_IRQ].handler() is completed=
.
If there is not currently active handler we may drop all
cpudata->irq_pending_hits for THIS_IRQ to zero. But ipipe_sync_stage()
should check for IPIPE_HANDLE_FLAG then since this is a sign that a given
irq is no more handled (even if there are some pending ones).

o  as a final step, ipd->irqs[THIS_IRQ].handler/cookie are set to zero.

Ok, repeating myself, the main idea is to keep the "cookie" unchanged as
long as the corresponding handler is active. This would partialy resolve th=
e
sync. problem I have got on the nucleus layer.

err... I have to orginize some issues next few days so I'll be out of my
notebook. Then I'll finilize the ipipe-irq-related patch so to be ready for
the .01 version.

--
Best regards,
Dmitry Adamushko

------=_Part_12011_21543055.1136227385479
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"><br></span><div><span class=3D"q"><blockquote c=
lass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); ma=
rgin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Nope, good spot, that coul=
d indeed happen in SMP configs. The code is
<br>expected to shut the given interrupt source _before_ calling
<br>rthal_irq_release(). But, the root of the problem is that<br>rthal_irq_=
release() doesn't make sure that all _pending_ IRQs from the<br>given kind =
are synchronized before processing. We need the equivalent of<br>Linux's sy=
nchronize_irq() here, and I would tend to implement this in
<br>the Adeos layer directly, in ipipe_virtualize_irq() for the NULL handle=
r<br>case, since it's a matter of general consistency.</blockquote></span><=
div><br>
Yep, I thought about the analogue of Linux's synchronize_irq() too.<br>
I guess, what we need to provide is the guarantee that the &quot;cookie&quo=
t;
argument (as well as a &quot;handler&quot;) remains valid as long as there =
is a
given irq handler in execution.<br>
<br>
i.e. <br>
<br>
o&nbsp; ipipe_virtualize_irq(THIS_IRQ, handler=3DNULL, cookie=3DNULL) call
_removes_ the IPIPE_HANDLE_FLAG so that new occurences of the THIS_IRQ
is no more accepted for the given domain;<br>
<br>
o&nbsp; then ipipe_virtualize_irq is buzy waiting
(ipipe_synchronize_irq() or smth like this) until the active
ipd-&gt;irqs[THIS_IRQ].handler() is completed.<br>
If there is not currently active handler we may drop all
cpudata-&gt;irq_pending_hits for THIS_IRQ to zero. But
ipipe_sync_stage() should check for IPIPE_HANDLE_FLAG then since this
is a sign that a given irq is no more handled (even if there are some
pending ones).<br>
<br>
o&nbsp; as a final step, ipd-&gt;irqs[THIS_IRQ].handler/cookie are set to z=
ero.<br>
&nbsp;<br>
Ok, repeating myself, the main idea is to keep the &quot;cookie&quot; uncha=
nged
as long as the corresponding handler is active. This would partialy
resolve the sync. problem I have got on the nucleus layer.<br>
<br>
</div></div>err... I have to orginize some issues next few days so I'll
be out of my notebook. Then I'll finilize the ipipe-irq-related patch
so to be ready for the .01 version.<br>
<br>
-- <br>Best regards,<br><span class=3D"sg">Dmitry Adamushko

</span><br clear=3D"all"><br>

------=_Part_12011_21543055.1136227385479--

