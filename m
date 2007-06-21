Message-ID: <467A42F6.8080706@domain.hid>
Date: Thu, 21 Jun 2007 11:20:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46782305.4080501@domain.hid>	
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>	
	<4679A302.2060403@domain.hid>
	<b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>
In-Reply-To: <b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1459607C82926B719C92BEC5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1459607C82926B719C92BEC5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 20/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> [ ... ]
>> > xnintr_attach/detach()).. your approach does increase a worst case
>> > length of the lock(&intrlock) --> unlock(&intrlock) section... but
>> > that's unlikely to be critical.
>> >
>> > I think, the patch I sent before addresses a reported earlier case
>> > with xnintr_edge_shirq_handler().. but your approach does make code
>> > shorter (and likely simpler), right? I don't see any problems it wou=
ld
>> > possibly cause (maybe I'm missing smth yet :)
>>
>> I must confess I didn't get your idea immediately. Later on (cough,
>> after hacking my own patch, cough) I had a closer look, and it first
>> appeared fairly nice, despite the additional "ifs". But then I realise=
d
>> that "end =3D=3D old_end" may produce false positives in case we have
>> several times the same (and only the same) IRQ in a row.
>> So, I'm afraid
>> we have to live with only one candidate. :->
>=20
> It's not clear, can you elaborate your (non-working) scenario in more
> details? :-)
>=20
> Note: I sent the second patch with the following correction :
>=20
> ...
>                } else if (code =3D=3D XN_ISR_NONE && end =3D=3D NULL) {=

>                        end =3D intr;
> +                        old_end =3D NULL;
>                }
> ...
>=20
> I don't see why this idea can't work (even if I made yet another error)=
=2E
> Under some circumstances the following code will be triggered to end a
> loop even when 'end' is still valid
>=20
>                        if (end && old_end =3D=3D end)
>                                intr =3D NULL;
>=20
> _but_ it'd be exactly a case when "intr =3D=3D end" and hence, the loop=

> would be finished anyway by the "while (intr && intr !=3D end)"
> condition.. So sometimes it acts as yet _another_ check to exit the
> loop, IOW "while (intr && intr !=3D end)" may be converted to just
> "while (intr)".

Yeah, looks like you are right again, should work as well.


Unfortunately, that whole thing make me meditate about the whole issue
again. And now I wonder why we make such a fuss about locking for shared
IRQs (where it should be correct with any of the new patches) while we
do not care about the non-shared, standard scenario. I currently find no
reason why we shouldn't race when some non-shared IRQ pops up on one CPU
and deregistration takes place on another. Also in this case, the xnintr
object must remain valid for the whole handler execution time. Do we need=


struct xnintr_irq {
	xnintr_t *handler;
	<whatever-lock>;
} xnirqs[RTHAL_NR_IRQS];

unconditionally? Or should we better move the whole locking thing into
i-pipe somehow? Argh.

Well, and I wonder what this xnarch_memory_barrier() at each handler
entry is for. Seems to be there for ages, don't see why right now. (The
kernel has a golden rule for this: no barrier without comments!)

Sigh, the never ending IRQ story...

Jan


--------------enig1459607C82926B719C92BEC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGekL2niDOoMHTA+kRAuUfAJ9DexcXTl+72AbgQs4aIMUxGpxIegCeJF6O
S6IP7FSoiMPNpWiKnCEv4W8=
=eBC6
-----END PGP SIGNATURE-----

--------------enig1459607C82926B719C92BEC5--

