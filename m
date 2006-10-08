Message-ID: <4528FBE5.7020803@domain.hid>
Date: Sun, 08 Oct 2006 15:23:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <OFACF3C5AC.1F615263-ONC12571FD.004ACE3C-C12571FD.004F1995@domain.hid>
In-Reply-To: <OFACF3C5AC.1F615263-ONC12571FD.004ACE3C-C12571FD.004F1995@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4B9984C13D13F0D6B865F6EF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Compiler and linker flags (was: Please remove "-I."
 in "xeno-config --*-cflags)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B9984C13D13F0D6B865F6EF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thomas Wiedemann wrote:
>> BTW, providing a patch, even if it's trivial, is always welcome in suc=
h
>> cases.
>=20
> I had already attached it to the email, but then i thought it was so
> ridiculously small ... and removed it :)
> So here it is again.

The point is if you start a thread like "[PATCH] Remove -I. from
xeno-config" and attach a full patch (including ChangeLog fragment) you
make it more likely to gain full attention and help to get it applied
quickly.

>=20
> =20
>> Well, -Wall should be considered a reasonable policy to keep code clea=
n.
>> Me feeling is that this switch is fairly appropriate, specifically for=

>> real-time applications. But it can easily be relaxed by adding specifi=
c
>> -Wno-xxx after the Xenomai flags. And *that* should happen explicitly.=

>>
>> -pipe is an optimisation of the build process, something one may
>> discuss, though I don't see an immediate reason why it could fail in t=
he
>> context of Xenomai applications (that should use the GNU toolchain=20
> anyway).
>=20
> I definitley agree on the use of "-Wall" and "-pipe", but i think these=

> optional flags should be set in the main project, and not by external
> libraries or tools. It's not that i think they would conflict with
> other flags or that they are wrong or inappropriate, but just because
> i expect *-config-tools to not specify any flags that affect the
> compiler behaviour. I just don't want every libraries' config-script
> to place the authors favorite compiler-flags into my own flags.

I agree now, for the sake of cleanness and as we are not just discussing
-Wall and -pipe here:

# xeno-config --xeno-cflags
-I. -I<xenomai-inst>/include -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__
-Wall -pipe -fstrict-aliasing -Wno-strict-aliasing

# xeno-config --posix-cflags
-I. -I<xenomai-inst>/include -I<xenomai-inst>/include/posix -O2
-D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -fstrict-aliasing
-Wno-strict-aliasing

# xeno-config --xeno-ldflags
-L<xenomai-inst>/lib -lpthread -rdynamic

# xeno-config --posix-ldflags
-Wl,@<xenomai-inst>/lib/posix.wrappers -L<xenomai-inst>/lib -lpthread_rt
-lpthread -lrt -rdynamic

(all x86, other platforms may vary)

@All: What flags are *really* required to build and link some *user*
application against Xenomai? Beside that -I. at least -O2 can be fairly
problematic I guess - if not even more. Also the debug mode of the
Xenomai build leaks to the user if (s)he wants it or not.

Time for a cleanup?

Jan


--------------enig4B9984C13D13F0D6B865F6EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFKPvlniDOoMHTA+kRAshLAJwK+Sg9KqQVMIOcpl9YaGGAEL2TZgCfQTcc
ZWIxzj5MNX8HdEOnn+Pq6G8=
=Il9M
-----END PGP SIGNATURE-----

--------------enig4B9984C13D13F0D6B865F6EF--

