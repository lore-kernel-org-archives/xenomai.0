Message-ID: <4D70A485.4000402@domain.hid>
Date: Fri, 04 Mar 2011 09:36:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>
	<20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid> <1299156880.2072.6.camel@domain.hid>
	<4D702802.5080001@domain.hid> <1299225060.2107.20.camel@domain.hid>
	<4D709E55.8010904@domain.hid>
	<20110304083030.GB12640@domain.hid>
In-Reply-To: <20110304083030.GB12640@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD62CF9AEAE6F136B2CB0F759"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD62CF9AEAE6F136B2CB0F759
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-03-04 09:30, Richard Cochran wrote:
> On Fri, Mar 04, 2011 at 09:09:57AM +0100, Jan Kiszka wrote:
>>
>> I'm not disagreeing. I'm just betting that MSI will quickly gain
>> relevance there as well - up to the point where first devices no longe=
r
>> include with INTx support (perfectly legal, but I haven't seen one yet=
).
>=20
> IFAICT, PCIe cards are allowed, not required to offer INTx.

Yep.

>=20
> In my case, I already asked HW if they could enable INTx in the
> design. The IP core would offer this, but there seems not to be
> possible in combination with the particular SoC core attached.
>=20
> So, for now, it looks like I will have to find a way to support MSI...

I see, you found that first example. :)

Jan


--------------enigD62CF9AEAE6F136B2CB0F759
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk1wpIUACgkQitSsb3rl5xQGdgCfQ87lvTERNmkG5MXoGeipW6zj
WjUAnR6pO37qaUxt4Mt2nEY8iSmFPTpG
=LvlB
-----END PGP SIGNATURE-----

--------------enigD62CF9AEAE6F136B2CB0F759--

