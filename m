Message-ID: <441ADFAA.9040602@domain.hid>
Date: Fri, 17 Mar 2006 17:11:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: FW: [Xenomai-help] Xenomai thread runtime statistics
References: <067C9A1F6AFEB643895EA4513E116884178FC4@domain.hid>
	<441ADC6B.5010909@domain.hid>
In-Reply-To: <441ADC6B.5010909@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE48E77052266EBE06767CE0"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, "Moser, Dan" <DMoser@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE48E77052266EBE06767CE0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Moser, Dan wrote:
>> Hi,
>>
>> I am still searching for ways (hopefully via some API(s)) to get Xenom=
ai
>> run-time thread execution info (my original post is below).
>>
>> Being a newbie, I apologize if the answer "should be obvious".  I am
>> still getting up to speed with both Linux and Xenomai.
>>
>> Is there a better list on which I should post this question?
>>
>=20
> This question is perfectly relevant to this list, the thing is that
> there's no simple, built-in way of getting execution stats for real-tim=
e
> threads yet. The best way to find out the execution time of your work
> cycle would be to measure it using the high precision clock information=
=2E

Hmm, wouldn't it be feasible to add such statistics to I-pipe level? I'm
thinking of something like time spent in domain X, Y, Z vs. the overall
runtime, preferably converted to percentage usage.

Jan


--------------enigEE48E77052266EBE06767CE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGt+qniDOoMHTA+kRAgvOAJ9wmP4rdrbfas7akqI23qruSkTtSgCfR0E/
yZ8dLwciMxf0EJwn//Fvyag=
=yuha
-----END PGP SIGNATURE-----

--------------enigEE48E77052266EBE06767CE0--

