Message-ID: <4AC6603B.7030801@domain.hid>
Date: Fri, 02 Oct 2009 22:19:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC2448B.1080500@domain.hid>	
	<1254396765.2703.234.camel@domain.hid>
	<4AC62883.1080908@domain.hid>	 <4AC653A2.2030302@domain.hid>
	<1254513132.2703.375.camel@domain.hid>
In-Reply-To: <1254513132.2703.375.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE815F8974FB149980AB9CC3A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE815F8974FB149980AB9CC3A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2009-10-02 at 21:25 +0200, Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Philippe Gerum wrote:
>>>> On Tue, 2009-09-29 at 19:31 +0200, Gilles Chanteperdrix wrote:
>>>>> Hi guys,
>>>>>
>>>>> full of energy after this tremendous first XUM,
>>>> Agreed, thanks to the DENX folks for having thought of it in the fir=
st
>>>> place, and organized it nicely.
>>>>
>>>>>  I would like to start a
>>>>> discussion about what people would like to see in the 2.5 branch.
>>>>>
>>>> Jan has described the situation quite accurately already, regarding =
the
>>>> trade-off between getting everything we want into 2.5 so that no 2.6=
 is
>>>> required, and releasing the too long-awaited 2.5 asap.
>>>>
>>>> As you mentioned already, the key issue is ABI stability.
>>>> Any change we want before 3.0 that breaks the ABI should preferably =
go
>>>> to 2.5, so that we don't end up maintaining 2.5.x, 2.6.x and 3.x. At=
 any
>>>> rate, we could not afford the latter anyway. This is a different mat=
ter
>>>> than API issues; we already allowed API extensions during a stable
>>>> cycle, provided they do not break existing application code (except =
in
>>>> emergency cases), so I see no problem in pushing a few more services=
 to
>>>> 2.5.1 and beyond, provided that condition is met.
>>>>
>>>>> Here is a first list, please feel free to criticize it:
>>>>> - signals in primary domain (something that we almost forgot)
>>>> Yes, this one must be in. At least, we should break the ABI one more=

>>>> time for this before releasing 2.5.0. This item has priority #1 for
>>>> me, since providing that infrastructure will enable a series of
>>>> additional services to be implemented properly. In fact, this is mor=
e a
>>>> matter of allowing nucleus callouts to user-space than anything else=
;
>>>> POSIX RT signals in full primary mode being an application of them.
>>> Ok. So, if we add the core skin fdtable, this leaves us with two item=
s:
>>> - signals in primary domain
>> Sorry, I neither see the need nor feel comfortable about the impact /
>> side effects of such an extension.
>>
>=20
> This extension is mandatory to allow callouts from the nucleus to a
> user-space application without forcing the latter to leave primary mode=
=2E
> This is direly needed when implementing some legacy RTOS services, and
> currently only available from kernel to kernel. We need this 1) to
> implement POSIX RT signals (a long term maintenance release like 2.5
> must have those), 2) implement missing services from existing skins
> (VxWorks comes to mind), 3) provide an upgrade path from 2.5.x to 3.x,
> for people who will have to move their apps to userland in v3, and as
> such should be able to anticipate that move with 2.5.
>=20
> The impact is minimal, we have discussed the general idea in a previous=

> thread actually. This is typically something that is implemented betwee=
n
> the shadow support code and the generic syscall code, this does not hav=
e
> to leak anywhere else.

I understand the need for it now, but I will likely not share your
optimism regarding the orthogonality of this change until I saw the
code. My worries about when we will see 2.5.0 are increasing again.

Jan


--------------enigE815F8974FB149980AB9CC3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrGYDsACgkQitSsb3rl5xTz3QCeNL8QlX9VfJXksrBRW3e/h8s0
aNAAoIUfT7d6vLOnPpgSRB2LArKQHgwk
=soAU
-----END PGP SIGNATURE-----

--------------enigE815F8974FB149980AB9CC3A--

