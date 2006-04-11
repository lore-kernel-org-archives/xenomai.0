Message-ID: <443C15F2.1060600@domain.hid>
Date: Tue, 11 Apr 2006 22:47:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <067C9A1F6AFEB643895EA4513E116884178FF2@domain.hid>
	<443C11CF.7030905@domain.hid>
In-Reply-To: <443C11CF.7030905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE444BF996CC9D63A1ABDC56D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] deleting a left over heap (shared
	memory segment)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, "Moser, Dan" <DMoser@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE444BF996CC9D63A1ABDC56D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Moser, Dan wrote:
>> Hi,
>>
>> I was wondering if there was a command line method for deleting left
>> over heaps (i.e., those that were not properly deleted with a call to
>> rt_heap_delete()) from /proc/xenomai/registry/native/heaps.
>>
>> Just a simple rm command (as root) yields the following:
>>
>> # rm -f myshmem
>> cannot remove `myshmem': Operation not permitted
>>
>=20
> For the moment, there is way to remove lingering native API objects fro=
m
                         ^^^
                         no?!
> the /proc interface. On the other hand, the RTDM API allows this for
> some of its objects by writing a magic value to the proper /proc entry,=

> and we might use the same technique to provide this feature to the
> native one.

Err, before adding to much stuff in this style (I'm allowed to diss it,
I introduced it ;) ), I would rather suggest to start thinking about a
scalable(!) cleanup hook for kernel objects.

We would need, e.g., per-process ownership of things like IPC objects or
RTDM devices instances. Then we could simply walk the chain on cleanup,
preferable in Linux context. This is a concept I already implemented in
an experimental skin. If this robustness should add too much overhead
(but I don't think so), we could make it optional. RTDM is already
prepared for it ("forced closure")!

Jan


--------------enigE444BF996CC9D63A1ABDC56D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPBXyniDOoMHTA+kRApd0AJ9iGv0mtidlJyUJt9prY78hB103GgCfUuq/
brfQAPDel1FXwhR9A04iLjY=
=eW2G
-----END PGP SIGNATURE-----

--------------enigE444BF996CC9D63A1ABDC56D--

