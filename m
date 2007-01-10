Message-ID: <45A502A9.3060800@domain.hid>
Date: Wed, 10 Jan 2007 16:13:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads
	to Kernel oops in /proc/xenomai/irq
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>	
	<45A4DDA8.6090800@domain.hid>	
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>	
	<45A4F18A.4040209@domain.hid>	
	<b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>	
	<45A4F9CC.6070807@domain.hid>
	<b647ffbd0701100655wd47af96y244c74d5227d6e85@domain.hid>
In-Reply-To: <b647ffbd0701100655wd47af96y244c74d5227d6e85@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE05235125A969B92093FC2FC"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE05235125A969B92093FC2FC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>> >>
>> >> This will set xnintr_t::name to "" if name is NULL - intentionally?=

>> >
>> > xnintr_t::name becomes a reference to RT_INTR::name. The later one
>> > exists as long as the former anyway so there shoudn't be a broken
>> > reference.
>>
>> Yes, this specifically addresses Mathias' concern about passed names
>> that are temporary variables.
>>
>> It just leaves xnintr_t::name with an emptry string instead of "unknow=
n"
>> in some cases. Either xnintr_init needs to take care of this, or we
>> should catch that case already here. I think empty strings in
>> /proc/xenomai/irq are bad in case of shared IRQ lists.
>>
>=20
> Yes, this is what I've mentioned as a possible exception in my previous=

> mail.
>=20
> This patch should address it (although, it makes a code flow a bit
> obscure but not too much :)
>=20

I'm fine with it.

Mind bundling all the snippets to one complete patch so that people
don't have to collect the pieces?

Thanks,
Jan


--------------enigE05235125A969B92093FC2FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFpQKpniDOoMHTA+kRAjXkAJ9CJ+WFCSvxxhvS+ufH4sfSXP9NqQCfSM3B
FoTXivu7P7jBKeeVBuLumxo=
=qzkq
-----END PGP SIGNATURE-----

--------------enigE05235125A969B92093FC2FC--

