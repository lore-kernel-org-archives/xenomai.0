Message-ID: <b647ffbd0609060527o13a077f4ue1fd1b445b1379c7@domain.hid>
Date: Wed, 6 Sep 2006 14:27:11 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <44FE943F.9000803@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_114704_30528236.1157545631238"
References: <44FD7463.7010601@domain.hid> <44FD99E9.6030500@domain.hid>
	<44FD9F92.4050802@domain.hid>
	<b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>
	<44FE6C55.1030900@domain.hid>
	<b647ffbd0609060159q7677cd30y80208afc58caf17@domain.hid>
	<44FE943F.9000803@domain.hid>
Subject: [Xenomai-core] Re: Move rtdm_irq_enable close to rtdm_irq_request
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

------=_Part_114704_30528236.1157545631238
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 06/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> > If such a driver (that requires EDGE_SHARED) is a part of the mainline,
> > then
> > we may use Kconfig features either (1) to make it "selectable" only when
> > XENO_OPT_SHIRQ_EDGE is on or (2) select XENO_OPT_SHIRQ_EDGE
> automatically
> > when the driver has been choosen.
> >
>
> Let's do both, the runtime check + some Kconfig magic for mainline
> drivers.
>
> For the latter we should reorganise the config options slightly.
> XENO_OPT_SHIRQ_* may better depend on a new switch XENO_OPT_SHIRQ. Thus,
> when the user enables IRQ sharing and some in-tree driver requires
> edge-triggering support, XENO_OPT_SHIRQ_EDGE will be selected by the
> driver's Kconfig: select XENO_OPT_SHIRQ_EDGE if XENO_OPT_SHIRQ. With the
> current layout it would look like this: select XENO_OPT_SHIRQ_EDGE if
> XENO_OPT_SHIRQ_LEVEL.


XENO_OPT_SHIRQ_LEVEL doesn't need to be on in order to use
XENO_OPT_SHIRQ_EDGE.

Or you probably mean the following behavior :

(1)
some driver with XN_ISR_EDGE is selected :

if XENO_OPT_IRQ
     select XENO_OPT_SHIRQ_EDGE

else
     "run-time" check in xnintr_attach() will report -EBUSY in case the line
is already busy

What I meant is

(2)
some driver with XN_ISR_EDGE is selected :

o   select XENO_OPT_SHIRQ_EDGE

So that shared irq support (only for edge-triggered interrupts) gets
unconditionally enabled.

in case of (1), XENO_OPT_SHIRQ can't be enabled on its own, i.e. without any
of XENO_OPT_SHIRQ_*.

Well, your proposal is probably better. With XN_ISR_EDGE a driver only
declares that it's ready to work in shared mode but it doesn't mean it can't
work in non-shared one.

If a user has a separate line for it, then the shared-IRQ infrastracture
adds just non-used overhead. Yep, you are right (heh... you are asking who
had doubts? :)




> Jan
>
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_114704_30528236.1157545631238
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 06/09/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt; If such a driver (that requires EDGE_SHARED) is a part of the mainline,<br>&gt; then<br>&gt; we may use Kconfig features either (1) to make it &quot;selectable&quot; only when<br>&gt; XENO_OPT_SHIRQ_EDGE is on or (2) select XENO_OPT_SHIRQ_EDGE automatically
<br>&gt; when the driver has been choosen.<br>&gt;<br><br>Let's do both, the runtime check + some Kconfig magic for mainline drivers.<br><br>For the latter we should reorganise the config options slightly.<br>XENO_OPT_SHIRQ_* may better depend on a new switch XENO_OPT_SHIRQ. Thus,
<br>when the user enables IRQ sharing and some in-tree driver requires<br>edge-triggering support, XENO_OPT_SHIRQ_EDGE will be selected by the<br>driver's Kconfig: select XENO_OPT_SHIRQ_EDGE if XENO_OPT_SHIRQ. With the<br>
current layout it would look like this: select XENO_OPT_SHIRQ_EDGE if<br>XENO_OPT_SHIRQ_LEVEL.</blockquote><div><br>
XENO_OPT_SHIRQ_LEVEL doesn't need to be on in order to use XENO_OPT_SHIRQ_EDGE.<br>
<br>
Or you probably mean the following behavior :<br>
<br>
(1)<br>
some driver with XN_ISR_EDGE is selected :<br>
<br>
if XENO_OPT_IRQ<br>
&nbsp;&nbsp;&nbsp;&nbsp; select XENO_OPT_SHIRQ_EDGE<br>
<br>
</div>else<br>
&nbsp;&nbsp;&nbsp;&nbsp; &quot;run-time&quot; check in xnintr_attach() will report -EBUSY in case the line is already busy<br>
<br>
What I meant is <br>
<br>
(2)<br>

some driver with XN_ISR_EDGE is selected :<br>
<br>
o&nbsp;&nbsp; select XENO_OPT_SHIRQ_EDGE<br>
<br>
So that shared irq support (only for edge-triggered interrupts) gets unconditionally enabled.<br>
<br>
in case of (1), XENO_OPT_SHIRQ can't be enabled on its own, i.e. without any of XENO_OPT_SHIRQ_*.<br>
<br>
Well, your proposal is probably better. With XN_ISR_EDGE a driver only
declares that it's ready to work in shared mode but it doesn't mean it
can't work in non-shared one.<br>
<br>
If a user has a separate line for it, then the shared-IRQ
infrastracture adds just non-used overhead. Yep, you are right (heh...
you are asking who had doubts? :)<br>
<br>
<br>
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Jan<br><br></blockquote></div><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_114704_30528236.1157545631238--

