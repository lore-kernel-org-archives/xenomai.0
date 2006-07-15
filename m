Message-ID: <44B8A811.2070507@domain.hid>
Date: Sat, 15 Jul 2006 10:32:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Different performance in irq handling between
	native	skin and rtdm?
References: <44B87D16.7030407@domain.hid>
In-Reply-To: <44B87D16.7030407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBF413E2F52F80453BF63F051"
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
To: ferretliu@domain.hid
Cc: xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF413E2F52F80453BF63F051
Content-Type: text/plain; charset=gb18030
Content-Transfer-Encoding: quoted-printable

Liu Zhenghui wrote:
> I have an A/D card which has a shared irq number 16 with the Radeon 750=
0
> video card. So I have to in isr tell whether this interrupt is from AD
> card. If not, then let other isr handle it. For native skin, this is
> done by returning RT_INTR_PROPAGATE in isr, while for rtdm, by using
> RTDM_IRQTYPE_SHARED flag when request the interrupt. I found both works=
,
> but rtdm solution make the xorg very slow (open a new window, animation=

> etc.), while native skin not. It seems that it take a much longer
> latency for rtdm to propagate the irq to video card than for native
> skin. How did this happen?

The point with RTDM is that is simple doesn't propagate the IRQ to Linux
like the native skin is able to. The reason: there is no common RT-safe
(priority-inversion-free) way to share IRQs between real-time and
non-real-time devices. That's a sad fact. Thus, I decided to drop the
propagation flag from the RTDM API. This way RTDM just tries to make you
reconsider your system design.

What you can do is to try flipping the A/D card in some PCI slots in the
hope that its IRQ changes. If this doesn't help: don't know, is there a
way to run your ATI driver without IRQ help? Otherwise, you would have
to hack the video driver so that IRQ requests are handled in a real-time
stub first (i.e. the reason is logged and removed from the hardware) and
then propagated to Linux via some virtual IRQ. Feasible, but a log of
work, thus only a last resort.

Jan


--------------enigBF413E2F52F80453BF63F051
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEuKgSniDOoMHTA+kRAp2QAJ96yISrnCOnK7DwiyP3a5e17c0TiQCdEZxh
dsd9sUM/d+KIduoNice5ZfM=
=6ckG
-----END PGP SIGNATURE-----

--------------enigBF413E2F52F80453BF63F051--

