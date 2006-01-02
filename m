Message-ID: <b647ffbd0601021014w170115cg@domain.hid>
Date: Mon, 2 Jan 2006 20:14:10 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [rt shared irqs] changes on the adeos-ipipe layer
	v.2
In-Reply-To: <43B81ADC.9090002@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11554_10415964.1136225650805"
References: <b647ffbd0512291103y383a96c1i@domain.hid>
	<43B81ADC.9090002@domain.hid>
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

------=_Part_11554_10415964.1136225650805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
>
> >
> > er.. I was confused by the fact that sum of all apcs in
> > /proc/xenomai/apc !=3D virq from /proc/xenomai/irq, but ipipe_printk_vi=
rq
> > is not listed since it's registered without rthal::apc interface. Ok,
> > should take a look at it closer, i.e. maybe at least rthal_linux_irq ca=
n
> > be reworked now.
> >
>
> APCs are multiplexed on a single virq.


Yep, I know. Don't know why but I thought that printk_flush is multiplexed
on the same virq, OTOH it's an APC too. Well, the easiest argument against
that could have been that the APC interface is implemented in the hal but
printk_virq is registered in the ipipe, i.e. when there is no APC interface
yet, mea culpa.



> --
>
> Philippe.
>

--
Best regards,
Dmitry Adamushko

------=_Part_11554_10415964.1136225650805
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>&gt;<br>=
&gt; er.. I was confused by the fact that sum of all apcs in<br>&gt; /proc/=
xenomai/apc !=3D virq from /proc/xenomai/irq, but ipipe_printk_virq
<br>&gt; is not listed since it's registered without rthal::apc interface. =
Ok,<br>&gt; should take a look at it closer, i.e. maybe at least rthal_linu=
x_irq can<br>&gt; be reworked now.<br>&gt;<br><br>APCs are multiplexed on a=
 single virq.
</blockquote><div><br>
Yep, I know. Don't know why but I thought that printk_flush is
multiplexed on the same virq, OTOH it's an APC too. Well, the easiest
argument against that could have been that the APC interface is
implemented in the hal but printk_virq is registered in the ipipe, i.e.
when there is no APC interface yet, mea culpa.<br>
<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>--<=
br><br>Philippe.<br></blockquote></div><br>-- <br>Best regards,<br>Dmitry A=
damushko

------=_Part_11554_10415964.1136225650805--

