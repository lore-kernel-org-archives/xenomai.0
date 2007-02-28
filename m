Message-ID: <45E58FB4.6070603@domain.hid>
Date: Wed, 28 Feb 2007 15:20:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [BUG] trunk: oops with Stephan's stress test
References: <45DEDED6.4070202@domain.hid>
	<1172237401.26738.13.camel@domain.hid>		<45DEED50.4070007@domain.hid>
	<1172238537.26738.15.camel@domain.hid>	<45DEF482.9030903@domain.hid>
	<45E58CE3.20807@domain.hid>
In-Reply-To: <45E58CE3.20807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig237AD169B4CD067E9FCEFBF5"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig237AD169B4CD067E9FCEFBF5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Jan Kiszka schrieb:
>> Philippe Gerum wrote:
>>> On Fri, 2007-02-23 at 14:34 +0100, Jan Kiszka wrote:
>>>
>>>> Attached with 3000 points (to play safe).
>>> Great, thanks.
>>>
>>
>> FYI: Switching prio-coupling off doesn't let it trigger anymore. Which=

>> /may/ mean that it's related to this feature, but which may also mean
>> that this corner-case race is just far more unlikely in non-RPI setups=

>> (and the effects Stephan see are all related to the same bug -
>> hopefully).
>>
>> Jan
>>
>=20
> To trigger you again, I just updated my Pentium M Notebook to 2.3.x svn=

> revision 2264, recompiled everything and gave it a try. (kernel 2.6.20)=

> Some runs of my already well-known software and the machine freezes
> during shutdown. No oops, no backtrace, no error message. It doesn't
> matter if priority coupling is enabled or not, when it tells me
> 'Stopping K Display Manager: kdm' the cursor freezes, that's it. My
> colleague report's the same beahviour on his AMD SMP mashine. The
> Celeron M crashes during reboot showing ugly backtraces like before.
>=20

Grr. OK, one by one, back to your .config: Could you try to disable
CONFIG_HPET_TIMER and see if this changes the picture at least regarding
crash-on-boot?

Then, what compiler do you (and your colleague) use?

Jan


--------------enig237AD169B4CD067E9FCEFBF5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5Y+0niDOoMHTA+kRAkhmAJ9G3X7lzsc1+puX0WMpmBYQvRZ/BgCfXNdu
0C41NeT735XsR7HYx5Z50OU=
=QzXm
-----END PGP SIGNATURE-----

--------------enig237AD169B4CD067E9FCEFBF5--

