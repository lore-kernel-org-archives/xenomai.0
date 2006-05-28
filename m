Message-ID: <44797F49.7020705@domain.hid>
Date: Sun, 28 May 2006 12:45:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
References: <200605252134.08614.niklaus.giger@domain.hid>
	<200605261852.45980.niklaus.giger@domain.hid>
	<44788191.2000405@domain.hid>
	<200605281200.18974.niklaus.giger@domain.hid>
In-Reply-To: <200605281200.18974.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE3AAC57C575B68CF868FC8DB"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3AAC57C575B68CF868FC8DB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Am Samstag, 27. Mai 2006 18:42 schrieb Jan Kiszka:
>> Niklaus Giger wrote:
> <..>
>> Still broken:
> <..>
> Sorry for not catching this part, but my kernel config did not set=20
> CONFIG_IKCONFIG. Fixed now.
>> Resolves to "zcat | grep -E '...' /proc/config.gz" or to "cat
>> /proc/config.gz". Both doesn't work. I would suggest this:
>>
>>     local filter=3D"| grep -E '$whatconf'"
>>     [ "$verbose" =3D 1 ] && filter=3D
>>
>>     if [ -f /proc/config.gz ]; then     # get the config
>>         loudly zcat /proc/config.gz $filter
>>
>>>     elif [ -f /lib/modules/`uname -r`/build/.config ]; then
>>>         loudly $cmd /lib/modules/`uname -r`/build/.config
>> And here we need
>>
>>     loudly cat /lib/modules/`uname -r`/build/.config $filter
>>
>>>     fi
> Should be fixed with the attached patch
>> There is another occurrence of "zcat | grep" which needs fixing.
> This one too.
>>>>> /bin/xeno-test: /bin/xeno-test: 264: getopts: not found
> <..>
>> Did so, and also awk need to be switched on. What about testing for
>> those features when bb was detected? Anyway, the latency tests work no=
w
>> (in my qemu box). But I do not find the workload (dd?) in the process =
list:
> Added to procedure checkUtilities and checkHelpers (after having parsed=
 the=20
> options). Added them unconditionally as there might be even *nix system=
s=20
> around which are lacking coreutilities like awk, cut, curl, mail, scrip=
t.
>=20
> Added a "ps | grep $_j" to show whether a dd job is still running befor=
e=20
> killing it. Now, at least running under the busybox. the dd jobs get ki=
lled=20
> as they should. Therefore I added a "killall dd" for the case the dd_jo=
bs=20
> variable is empty.

But there is still no load during the tests, correct?

>=20
> You should be able to xeno-test under the BusyBox without any parameter=
, I=20
> added however often a "-T 1" to make them run faster.=20
>=20
> Could you give this patch another try? Thanks for your patience, but th=
e=20
> variability is very high as both the kernel and the busybox have a lot =
of=20
> config options.

Yeah, I know. Therefore it takes someone looking at it from different
perspectives. :)

Basically works now, but I found two oddities:

- special characters in line 152 of xeno-test:

> @@ -83,20 +141,19 @@
>
>
>  boxinfo() { # static info, show once
> +    loudly `dirname $0`/xeno-config --verbose
> +    loudly `dirname $0`/xeno-info
>
> -    loudly ./xeno-config --verbose
> -    loudly ./xeno-info
> -
>      loudly cat /proc/cpuinfo	# bogomips changes under CPU_FREQ
>
>      # how much of the config do we want ?
> -    local cmd=3D"zgrep -E '$whatconf'"
> -    [ "$verbose" =3D 1 ] && cmd=3Dcat
> -
> -    if [ -f /proc/config.gz ]; then	# get the config
> -	loudly $cmd /proc/config.gz
> -    elif [ -f /lib/modules/`uname -r`/build/.config ]; then
> -	loudly $cmd /lib/modules/`uname -r`/build/.config
> +    local filter=3D" grep -E '$whatconf'"
> +    [ "$verbose" =3D 1 ] && filter=3D
> +    if test -f /proc/config.gz; then =C2  =C2  # get the config
                                        ^^^^

- the output of xeno-test contains this error:

running: cat /proc/cpuinfo
processor       : 0
[...]
bogomips        : 2628.76

/bin/xeno-test: /bin/xeno-test: 325:  : not found
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy
CONFIG_IPIPE=3Dy

???

Jan


--------------enigE3AAC57C575B68CF868FC8DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEeX9JniDOoMHTA+kRAkLAAJ9MsmPHFz33FqSa8LapnqQhbWRnpgCfRezO
KkQuP8UyG64daXbZYLAibBE=
=egeL
-----END PGP SIGNATURE-----

--------------enigE3AAC57C575B68CF868FC8DB--

