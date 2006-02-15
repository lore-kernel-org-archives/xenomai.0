Message-ID: <fd6a47a90602151458sc34625g@domain.hid>
Date: Wed, 15 Feb 2006 23:58:35 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <fd6a47a90602151250k4eb0b3b0s@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22852_23054282.1140044315452"
References: <fd6a47a90602140744lc1d4365q@domain.hid>
	<fd6a47a90602141052u1e136db8y@domain.hid>
	<fd6a47a90602141133v6aeae6e1n@domain.hid>
	<fd6a47a90602141341j21ce1b77l@domain.hid>
	<43F2521E.7040200@domain.hid>
	<fd6a47a90602150300y5e435a22i@domain.hid>
	<fd6a47a90602151002q3f38748ep@domain.hid>
	<fd6a47a90602151034q8ed6920r@domain.hid>
	<43F38A5E.9030402@domain.hid>
	<fd6a47a90602151250k4eb0b3b0s@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_22852_23054282.1140044315452
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> I=B4m also investigating why MSI also doesn=B4t work under RTDM. It=B4s m=
erely a
> coincidence that the above bug (MSI interrupts from Linux devices getting
> blocked) emerged and produced exactly the same behaviour (system hanging)=
.


It turns out not to be coincidential. rtdm_irq_request() (through passing
iack=3DNULL to virtualize_irq()) uses the default Linux driver as an
acknowledgement routine for that interrupt. So fixing regular Linux
interrupts also fixed RTDM operation.

I'll have to sleep over the best solution in msi.c . For now, I have
implemented an __ack_APIC_irq() in an routine ack_msi_irq_wo_maskbit(). How
do I make a patch for that ?

As for the bitmasked varieties, I need to be careful here. First I'll have =
a
look at the details of MSI with maskbits. Some of this stuff has actually
been devised to allow deferral of IRQ acknowledgement. I wouldn't want to
break that feature.

Anyway, with this simple fix, I'm finally able to use my Dell GX270 without
IRQ sharing for the first time :-) .


Jeroen.

------=_Part_22852_23054282.1140044315452
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I=B4m also i=
nvestigating
why MSI also doesn=B4t work under RTDM. It=B4s merely a coincidence that
the above bug (MSI interrupts from Linux devices getting blocked)
emerged and produced exactly the same behaviour (system hanging).</blockquo=
te><div><br>
It turns out not to be coincidential. rtdm_irq_request() (through
passing iack=3DNULL to virtualize_irq()) uses the default Linux driver as
an acknowledgement routine for that interrupt. So fixing regular Linux
interrupts also fixed RTDM operation.<br>
<br>
I'll have to sleep over the best solution in msi.c . For now, I have
implemented an __ack_APIC_irq() in an routine ack_msi_irq_wo_maskbit().
How do I make a patch for that ?<br>
<br>
As for the bitmasked varieties, I need to be careful here. First I'll
have a look at the details of MSI with maskbits. Some of this stuff has
actually been devised to allow deferral of IRQ acknowledgement. I
wouldn't want to break that feature.<br>
<br>
</div>Anyway, with this simple fix, I'm finally able to use my Dell GX270 w=
ithout IRQ sharing for the first time :-) .<br>
<br>
</div><br>
Jeroen.<br>

------=_Part_22852_23054282.1140044315452--

