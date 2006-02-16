Message-ID: <43F48832.7060804@domain.hid>
Date: Thu, 16 Feb 2006 15:12:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	
	<43F3C4EA.7050303@domain.hid>
	<b647ffbd0602160220we254aacx@domain.hid>	
	<43F47705.90309@domain.hid>
	<b647ffbd0602160558i4112313an@domain.hid>
In-Reply-To: <b647ffbd0602160558i4112313an@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB714DF0D430F50D0F452C9DA"
Sender: jan.kiszka@domain.hid
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
--------------enigB714DF0D430F50D0F452C9DA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Dmitry Adamushko wrote:
>>> On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>
>>> Hmm, I still find XN_ISR_NOINT in the patch. Shouldn't we solve this
>>>> before merging (i.e. make XN_ISR_HANDLED non-zero)?
>>>
>>> Ok, XN_ISR_NOINT is removed in favor of XN_ISR_HANDLED which is now
>>> non-zero.
>>> Actually, at first I wanted to make it just the other way about.
>>>
>> Hmm, thinking about this again, I would like to revert my suggestion i=
n
>> favour of a third approach (trying to keep you busy ;) ).
>=20
>=20
> Ok, you are wellcome :)
>=20
> I didn't get it, at least while looking briefly. To make it a bit easie=
r, at
> least for me, let's go another way.
>=20
> At the left is the list of allowed values as Philippe pointed out.
> At the right is another list which corresponds to the left one but when=

> NOINT is used instead of HANDLED. Moreover, I have added another case -=
 pure
> NOINT. The ISR says it's not mine and, well, it doesn't know whether it=

> should be propagated or no
> (ok, so far CHAINED standed for NOINT).
>=20
> 1.) HANDLED                     ->  0
> 2.) HANDLED | ENABLE     ->  ENABLE
> 3.) HANDLED | CHAINED    ->  CHAINED
> 4.) CHAINED                      ->  CHAINED | NOINT
> 5.)                                    ->   NOINT
>=20
> Could you provide the 3-d corresponding table using your new flags?
>=20

Still not 3D, but hopefully clarifying: :)

1.) XN_ISR_HANDLED |XN_ISR_NO_ENABLE
2.) XN_ISR_HANDLED
3.) XN_ISR_HANDLED | XN_ISR_PROPAGATE
    (nucleus ignores implicit IRQ enable)
4.) XN_ISR_NOINT | XN_ISR_PROPAGATE
5.) XN_ISR_NOINT

2.) and 5.) are most common, the others for special scenarios.
Especially, as long as we have no API for ending IRQs outside the
handler, 1.) is of limited usage I think.

Jan


--------------enigB714DF0D430F50D0F452C9DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD9IgyniDOoMHTA+kRAk2sAJ9EkDsogYo4mwfTM80JvAK3YfQOQgCdEuR7
nukguiIZpydwZCvfWhQO2bM=
=VcFn
-----END PGP SIGNATURE-----

--------------enigB714DF0D430F50D0F452C9DA--

