Message-ID: <45616F13.5080305@domain.hid>
Date: Mon, 20 Nov 2006 10:02:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Buildbot: Errors building rtnet since at least
	r1834
References: <200611181818.17629.niklaus.giger@domain.hid>
	<455F4A24.8060408@domain.hid>
	<200611182116.20647.niklaus.giger@domain.hid>
In-Reply-To: <200611182116.20647.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A8FD2C81743663591D3FBEE"
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A8FD2C81743663591D3FBEE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Am Samstag, 18. November 2006 19:00 schrieb Jan Kiszka:
>> Niklaus Giger wrote:
>>> Hi
>>>
>>> Unfortunately I cannot say since when this build is broken, as I had =
to
>>> reinstall the buildbot on my main server. But this particular build
>>> target should not have been affected. (Same compiler, same build slav=
e,
>>> same scripts)
>>>
>>> But since at November 12 I get the following errors in my builds:
>>> See http://ngiger.dyndns.org/buildbot-full/tqm_f/builds/0/step-mk_RTn=
et/1
>>> libtool: link: warning: library
>>> `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/libpthread_rt.la' =
was
>>> moved.
>>> libtool: link: warning: library
>>> `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/librtdm.la' was mo=
ved.
>>> libtool: link: warning: library
>>> `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/libpthread_rt.la' =
was
>>> moved.
>>> libtool: link: warning: library
>>> `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/librtdm.la' was mo=
ved.
>>>
>>> Has anybody a hint, what the reason could be?
>> DESTDIR issue? Are you compiling both Xenomai and RTnet with the same
>> DESTDIR?
> Calling manuall make install like the following line did not change the=
=20
> result:
> DESTDIR=3D/var/buildbot/install/tqm_q make prefix=3D/var/buildbot/insta=
ll/tqm_q=20
> install=20

make install of ...? Also, the prefix is not needed unless you modify
the layout *on the target*.

>=20
> My steps to compile the xenomai kernel were:
> cd /var/buildbot/slave/tqm_q/linux
> export CROSS_COMPILE=3Dpowerpc-860-linux-gnu-=20
> make oldconfig
> make --jobs=3D4 uImage modules
> make INSTALL_MOD_PATH=3D/var/buildbot/install/tqm_q modules_install
> make DESTDIR=3D/var/buildbot/install/tqm_q install

[has no influence here]

> cd /var/buildbot/slave/tqm_q/build
> ../xenomai/configure --host=3Dppc-linux --enable-debug
> make=20

No install? I'll assume there is one with DESTDIR passed appropriately,
right?

> cd /var/buildbot/slave/tqm_q/rtnet
> ./configure --host=3Dpowerpc-860-linux-gnu --enable-rtwlan --enable-rou=
te-src --enable-net-routing --enable-router --enable-rtcfg-dbg --enable-n=
omac --enable-rtcap --enable-proxy --enable-examples --enable-checks --en=
able-fec-enet --enable-scc-enet --with-rtext-config=3D/var/buildbot/insta=
ll/tqm_q/usr/xenomai/bin/xeno-config --with-linux=3D../linux --prefix=3D/=
var/buildbot/install/tqm_q=20
> DESTDIR=3D/var/buildbot/install/tqm_q
> make prefix=3D/var/buildbot/install/tqm_q install
>=20
> Is this okay? Or do I have an error here?

DESTDIR belongs to which command?

In any case, ./configure needs it in order to get the correct paths from
xeno-config, and make install requires it, as usual, too. So it's likely
best to simply export DESTDIR before starting the whole batch.

>=20
> Isn't it more the problem that xeno-config since a few weeks ago output=
s wrong=20
> paths (forgets about its DESTDIR when installed). E.g. look at this out=
put of
> /var/buildbot/install/tqm_q/usr/xenomai/bin/xeno-config
> xeno-config --verbose
>     --version=3D"2.2.91"
>     --cc=3D"gcc"
>     --arch=3D"powerpc"
>     --prefix=3D"/usr/xenomai"
>     --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT"=

>     --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
>     --posix-cflags=3D"-I/usr/xenomai/include -I/usr/xenomai/include/pos=
ix -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
>     --posix-ldflags=3D"-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "=

>     --library-dir=3D"/usr/xenomai/lib"
>=20
> I think --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread " should return
> --xeno-ldflags=3D"-L/var/buildbot/install/usr/xenomai/lib -lpthread "

That's correct. Note that xeno-config is first of all intended to run on
the *target* and provide correct paths there. To use it also on the
build host, you have to invoke it with DESTDIR set appropriately (see
above).

>=20
>=20
>> Check what's stated in those .la files and compare with the RTnet buil=
d
>> parameters.
> *.la files are attached
>> Jan
>>
>> PS: This is a *warning*, not a fatal *error*. Or did you just want to
>> receive more attention? ;)
> Sorry. I forgot to include the line with the real error.
>=20
> powerpc-860-linux-gnu-gcc -I/var/buildbot/install/tqm_q/usr/xenomai/inc=
lude -I/var/buildbot/install/tqm_q/usr/xenomai/include/posix -D_GNU_SOURC=
E -D_REENTRANT -D__XENO__ -Wall -pipe -O2 -fstrict-aliasing -I../../../st=
ack/include -g -Wl,@/var/buildbot/install/tqm_q/usr/xenomai/lib/posix.wra=
ppers -o=20
> rtt-sender=20
> rtt-sender.o  -L/var/buildbot/install/tqm_q/usr/xenomai/lib /var/buildb=
ot/install/tqm_q/usr/xenomai/lib/libpthread_rt.so -lrt -lpthread /var/bui=
ldbot/install/tqm_q/usr/xenomai/lib/librtdm.so -Wl,--rpath -Wl,/var/build=
bot/install/tqm_q/usr/xenomai/lib -Wl,--rpath -Wl,/var/buildbot/install/t=
qm_q/usr/xenomai/lib
> /opt/crosstool/gcc-3.4.1-glibc-2.3.3/powerpc-860-linux-gnu/lib/gcc/powe=
rpc-860-linux-gnu/3.4.1/../../../../powerpc-860-linux-gnu/bin/ld:=20
> @/var/buildbot/install/tqm_q/usr/xenomai/lib/posix.wrappers: No such fi=
le: No=20
> such file or directory
> collect2: ld returned 1 exit status

Is /var/buildbot/install/tqm_q/usr/xenomai/lib/posix.wrappers the
correct path? Does the file exist?

=2E..
>=20
> # Directory that this library needs to be installed in:
> libdir=3D'/usr/xenomai/lib'

That's ok from the target's POV. Unfortunately, we then see those "was
moved" warnings. I don't know if one can avoid them via some magic, but
they are harmless.

@All: Does anyone know how to pass a prefix (DESTDIR) to an
automake-based linking step - and how to code this into .am files? The
scenario is linking against libs (represented via .la files) that were
installed for the target, i.e. without the DESTDIR part the host needs.

Jan


--------------enig0A8FD2C81743663591D3FBEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYW8TniDOoMHTA+kRAn0XAJ9vREpz2omJ7o/YHRyj2UU9wJEdOACfVcS9
feTmUbvEMFeCc5M9Uu80L4s=
=u0eT
-----END PGP SIGNATURE-----

--------------enig0A8FD2C81743663591D3FBEE--

