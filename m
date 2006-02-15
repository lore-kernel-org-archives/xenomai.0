Message-ID: <43F3AFD1.3030807@domain.hid>
Date: Wed, 15 Feb 2006 23:48:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <fd6a47a90602140744lc1d4365q@domain.hid>	
	<43F220D7.6040705@domain.hid>	
	<fd6a47a90602141052u1e136db8y@domain.hid>	
	<fd6a47a90602141133v6aeae6e1n@domain.hid>	
	<fd6a47a90602141341j21ce1b77l@domain.hid>	
	<43F2521E.7040200@domain.hid>	
	<fd6a47a90602150300y5e435a22i@domain.hid>	
	<fd6a47a90602151002q3f38748ep@domain.hid>	
	<fd6a47a90602151034q8ed6920r@domain.hid>	
	<43F38A5E.9030402@domain.hid>
	<fd6a47a90602151250k4eb0b3b0s@domain.hid>
In-Reply-To: <fd6a47a90602151250k4eb0b3b0s@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
>     It's definitely an Adeos issue and msi.c needs fixing. What about
>     this patch, do
>     things improve with it (against 2.6.15-ipipe-1.2-00)?
>=20
> I going to try the patch later on. I have currently a =B4fully=20
> instrumented=B4 kernel against which this patch would not ever work... =
I=B4m=20
> keeping that kernel for now, because I=B4m also investigating why MSI a=
lso=20
> doesn=B4t work under RTDM. It=B4s merely a coincidence that the above b=
ug=20
> (MSI interrupts from Linux devices getting blocked) emerged and produce=
d=20
> exactly the same behaviour (system hanging).
>=20
> But, normally, that path is not used in RT mode, is it ? So something=20
> else is getting in the way.
>=20
> At the first look of it, I=B4m a bit wary of touching that msi.c . I wa=
s=20
> rather thinking of kicking out __ack_APIC() altogether ? Or is that not=
=20
> possible ? (I see only problems in p4.c and smp.c - but I haven=B4t loo=
ked=20
> at these very closely.)
>=20
>=20

We do need __ack_APIC_irq() to run the actual APIC ack code all over the =
place in=20
the APIC/IO-APIC support code, so that former regular uses of ack_APIC_ir=
q() can=20
be left untouched. Adeos already changes significant areas within Linux's=
 innards=20
in order to control its interrupt sub-system anyway, which in turn hides =
the gory=20
details of interrupt prioritization to client software like Xenomai.=20
drivers/pci/msi.c simply brings a new set of interrupt controllers we nee=
d to make=20
Adeos-aware, just like it has been done for the i8259, the LAPIC and the =
IO-APIC=20
supports.

--=20

Philippe.

