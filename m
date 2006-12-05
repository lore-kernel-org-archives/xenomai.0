Message-ID: <4575A2C0.6000305@domain.hid>
Date: Tue, 05 Dec 2006 17:48:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid> <457584DD.90600@domain.hid>
	<4575888D.8090904@domain.hid> <E1GrdKV-00048O-FF@mailer.emlix.com>
In-Reply-To: <E1GrdKV-00048O-FF@mailer.emlix.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig370954A2DABAB7585C8E6DDD"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig370954A2DABAB7585C8E6DDD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Sebastian Smolorz wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Are you tracing into vmalloc'ed memory?
>>>>>> Yes, without CONFIG_IPIPE_TRACE_VMALLOC the system does not boot.
>>>>> Hmm, makes me wonder of some laziness of the page mapping or a miss=
ing
>>>>> lock-against-swapping causes this. Could you have a closer look at =
the
>>>>> tracer code if we are lacking some magic for the vmalloc trace buff=
er
>>>>> (compare to the xnheap code, e.g.)?
>>>> This is a known issue, the ARM architecture lacks the set_pgdir
>>>> function, needed in mm/vmalloc.c to workaround the lazy page mapping=
 of
>>>> vmalloced areas.
>>> Would vmalloc+memset help to be safe for the remaining system runtime=
?
>> Probably not, the vmalloced area is added only to the page table of th=
e
>> process that calls vmalloc, it is added to other processes table page
>> only once they use it.
>=20
> Are there any alternatives? Or do we have to live with this restriction=
?
>=20

Try if smaller CONFIG_IPIPE_TRACE_SHIFT makes it boot without
CONFIG_IPIPE_TRACE_VMALLOC.

On the longer term: Gilles, what does "lacks the set_pgdir" means? Is
this fixable?

Jan


--------------enig370954A2DABAB7585C8E6DDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdaLAniDOoMHTA+kRAvhJAJ9Ys20ees9+qIdlQO0W1oFByhS83ACfYJUJ
4rkFCSgJYCWcvomL5c1Z7iU=
=xrTV
-----END PGP SIGNATURE-----

--------------enig370954A2DABAB7585C8E6DDD--

