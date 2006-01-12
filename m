Message-ID: <43C62195.8070101@domain.hid>
Date: Thu, 12 Jan 2006 10:29:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
References: <200601111655.57020.lbocseg@domain.hid> <43C56124.4040407@domain.hid>
	<200601111921.05544.lbocseg@domain.hid> <43C58755.2040407@domain.hid>
	<1137032878.43c5beae139f5@domain.hid>
In-Reply-To: <1137032878.43c5beae139f5@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE4632F22B46EE0D96EDEF2BC"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vdkeybus <Jeroen.VandenKeybus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE4632F22B46EE0D96EDEF2BC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

vdkeybus wrote:
>> Argh, I confused something here.
>>
>> Yes, this is a way to obtain this continous memory. The other, more
>> organised way is via the old bigphysarea patch. It's still being
>> update
>> even for 2.6
>> (http://pv105234.reshsg.uci.edu/~jfeise/Downloads/zr36120).
>> Anyway, as long as you are alone with this requirement on your
>> system,
>> this is the simpler way to go.
>=20
>>>>> continuous physic memory area and I can't get it through kmalloc
>=20
> I did a quick check and I could easily allocate a 2MB contiguous,=20
> aligned buffer on my system using the following calls. (See DMA-
> mapping.txt in your kernel Documentation folder):
>=20
> struct pci_dev *p;
>=20
> ...
>=20
> pci_set_master(p);
> pci_set_consistent_dma_mask(p, DMA_32BIT_MASK);
> pci_alloc_consistent(p, 2097152, &phys_ptr);

I think this depends on how long your system already ran, how much of
the physical memory had already been allocated and how it was released
again, probably causing heavy fragmentation. But if you have, say, 512
MB and only require that 2 MB, the probability to get obtain this block
during system startup is quite high. So it's best to place he request in
the driver's module init routine.

>=20
> ...
>=20
> You can also get the irq line number here from p->irq . Use this for=20
> rtdm_irq_request().
>=20
>>>>> Please, what do you suggest about the design of my driver?
>=20
> 1. Use RTDM and write a kernel module. It allows you to write a=20
> specific test program on it, which you can reuse later on every=20
> occasion where you need to know whether the driver or the program=20
> contains causes a problem. You can also shut an RTDM driver down=20
> manually if your RT program ever bails out 'ungracefully'.=20

More precisely, you can try to kill stalled RT file descriptors by
writing their number to /proc/xenomai/rtdm/open_fildes. Depends on the
driver if this works, i.e. its closure handler has to support the
enforced cleanup from every device state.

>=20
> 2. Use 2 framebuffers and implement a ping-pong buffer, so that the=20
> grabber may fill in a second buffer while you're using the contents of =

> number one. Avoid copying of the data.
>=20
> 3. Remember to use the PCI DMA API. It is the easiest way to guarantee =

> that CPU L1/2 caching is not going to fool you some day. You do not=20
> want to mess yourself with MTRR and friends (?) on the CPU. (Something =

> I think may be a serious issue when using tricks like the ones=20
> mentioned earlier.)
>=20
> 4. Use portable functions to access your PCI card, such as read[b/w/l]
> () and write[b/w/l](). Don't do *(unsigned int *)ptr =3D val. Where=20
> needed, use memory write barriers such as wmb(), to avoid instruction=20
> reordering by the compiler.=20
>=20
> 5. Don't catch interrupts that weren't meant for you. If your ISR gets =

> called, check some status register of your card to see if it was the=20
> cause of the interrupt. If so, finish with return(RTDM_IRQ_ENABLE).=20
> Otherwise, return(RTDM_IRQ_PROPAGATE), so other handlers may catch it=20
> (and reset the possibly shared IRQ line, which is never going to be=20
> deasserted otherwise (=3D=3D stuck)).

Currently, RTDM_IRQ_PROPAGATE tells the RT-IRQ subsystem to forward
unhandled IRQs to the Linux domain. If you have to do this as there is
an IRQ sharing between a RT and a non-RT device, you are generally
doomed anyway. The non-RT device can then easily break the determinism
of the RT subsystem. We should rework this flag or at least its
documentation soon when RTDM will be extended (slightly) to support
RT-IRQ sharing (which is RT-safe by design).

>=20
> (Anyone, feel free to comment on these lines.)
>=20
> BTW, when specifying mem=3D510M, how would you access the range 510-512=
=20
> without causing a segmentation fault ?
>=20
>>> Well, there is only one thing I can see at the moment. I would need
>> to rewrite=20
>>> the interrupt part to use a real-time interrupt routine instead of
>> the PCI=20
>>> interrupt method, am I right?
>=20
> I think you are. I have used an RTDM event (rtdm_event_t) to signal the=
=20
> blocking read function that a frame has arrived.
>=20
> Also see the 16550A RTDM driver example to see how events are used to=20
> accomplish this.
>=20

Yep, another example, just "a bit" more complicated than xeno_timerbench.=


>=20
> Jeroen.
>=20
> Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm
>=20

Jan


--------------enigE4632F22B46EE0D96EDEF2BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDxiGVniDOoMHTA+kRAmKRAJ4481tWz93yXEIFIzIjc4TK6iuprACfYT8F
K6tG8vOmrO2UCPw6hPNTOkQ=
=OZkX
-----END PGP SIGNATURE-----

--------------enigE4632F22B46EE0D96EDEF2BC--

