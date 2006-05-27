Message-ID: <44788191.2000405@domain.hid>
Date: Sat, 27 May 2006 18:42:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
References: <200605252134.08614.niklaus.giger@domain.hid>
	<44770814.5040009@domain.hid>
	<200605261852.45980.niklaus.giger@domain.hid>
In-Reply-To: <200605261852.45980.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4A6ABFBBEC95841E65B2CDAC"
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
--------------enig4A6ABFBBEC95841E65B2CDAC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
>> When using this variant, I get the following messages:
>>> /bin/xeno-test: /bin/xeno-test: 177: zgrep: not found
>> What about zcat | grep instead? Moreover, I failed to find a zgrep bb
>> applet. Did you copy that stuff on your box?
> Sorry. As I had segmentation faults, my run did not get so far/or I mis=
sed=20
> this error. Running it manually I confirmed your bug and the proposed=20
> solution works for me, too. Integrated in the new version (attached) of=
 the=20
> patch.

Still broken:

> boxinfo() { # static info, show once
>     loudly `dirname $0`/xeno-config --verbose
>     loudly `dirname $0`/xeno-info
>=20
>     loudly cat /proc/cpuinfo    # bogomips changes under CPU_FREQ
>=20
>     # how much of the config do we want ?
>     local cmd=3D"zcat | grep -E '$whatconf'"
>     [ "$verbose" =3D 1 ] && cmd=3Dcat
>=20
>     if [ -f /proc/config.gz ]; then     # get the config
>         loudly $cmd /proc/config.gz

Resolves to "zcat | grep -E '...' /proc/config.gz" or to "cat
/proc/config.gz". Both doesn't work. I would suggest this:

    local filter=3D"| grep -E '$whatconf'"
    [ "$verbose" =3D 1 ] && filter=3D

    if [ -f /proc/config.gz ]; then     # get the config
        loudly zcat /proc/config.gz $filter

>     elif [ -f /lib/modules/`uname -r`/build/.config ]; then
>         loudly $cmd /lib/modules/`uname -r`/build/.config

And here we need

    loudly cat /lib/modules/`uname -r`/build/.config $filter

>     fi
>=20

There is another occurrence of "zcat | grep" which needs fixing.

>=20
>>> /bin/xeno-test: /bin/xeno-test: 264: getopts: not found
>> getopts is off by default in bb. Is this essential for xeno-test? Then=

>> you should state this requirement somewhere.
> I checked out BusyBox 1.13, run "make defconfig", changed the cross-com=
piler=20
> and install path. But I verified that a "make defconfig" on the 1.00 ve=
rsion=20
> had "# CONFIG_ASH_GETOPTS is not set".
>=20
> Could you try the attached patch using busybox with "CONFIG_ASH_GETOPTS=
=3Dy"?=20

Did so, and also awk need to be switched on. What about testing for
those features when bb was detected? Anyway, the latency tests work now
(in my qemu box). But I do not find the workload (dd?) in the process lis=
t:

root@domain.hid :/root# ps
  PID  Uid     VmSize Stat Command
    1 root        664 S   init
    2 root            SWN [ksoftirqd/0]
    3 root            SW  [watchdog/0]
    4 root            SW< [events/0]
    5 root            SW< [khelper]
    6 root            SW< [kthread]
    8 root            SW< [kblockd/0]
   41 root            SW< [gatekeeper/0]
   76 root            SW  [pdflush]
   77 root            SW  [pdflush]
   79 root            SW< [aio/0]
   78 root            SW  [kswapd0]
  663 root            SW< [kseriod]
  700 root            SW< [kpsmoused]
  787 root        212 S   dhcpcd eth0 -t 5 -h LIRE_home -I LIRE_home
  844 root       1020 S   /usr/sbin/sshd -f /etc/ssh/sshd_config
  874 root        648 S   /sbin/getty 38400 tty1
  877 root        644 S   /sbin/getty 38400 tty2
  880 root        648 S   /sbin/getty 38400 tty3
  883 root        640 S   /sbin/getty 38400 tty4
  886 root        644 S   /sbin/getty 38400 tty5
  889 root        648 S   /sbin/getty 38400 tty6
  890 root        644 S   /sbin/getty 38400 tty7
  891 root        636 S   /sbin/getty 38400 tty8
  898 root       2004 S   sshd: root@domain.hid
  902 root        820 S   -sh
  905 root        708 S   /bin/sh /bin/xeno-test
 1182 root        436 S   /bin/sh /bin/xeno-test
 1296 root       2004 S   sshd: root@domain.hid
 1300 root        884 S   -sh
 1321 root        272 S   /bin/sh /bin/xeno-test
 1322 root        632 S   /bin/sh ./run -- -q -s -T 120 -t1
 1323 root        680 S   /bin/sh //bin/xeno-load -- -q -s -T 120 -t1
 1364 root        436 S   /bin/sh //bin/xeno-load -- -q -s -T 120 -t1
 1426 root       1732 S   ./latency -q -s -T 120 -t1
 1430 root        744 R   ps

Instead I have this in the log:

[...]
Sat May 27 16:29:26 UTC 2006
running: cat /proc/ipipe/version
1.3-04

Sat May 27 16:29:26 UTC 2006
running: generate_loads 1
dummy  reaper for 1039
dd workload started, pids 1048
killing workload pids 1048
killall: dd: no process killed

Sat May 27 16:29:27 UTC 2006
running: cat /proc/interrupts
[...]

Or do I have to invoke xeno-test with some parameter (I did not pass any)=
?

Jan


--------------enig4A6ABFBBEC95841E65B2CDAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEeIGRniDOoMHTA+kRAgbHAJ9G/ymQ5nNayRvihP+QyUvuVH7jlACeN++Y
1LsxOiNfF0zGOuvEq0XUUZg=
=I2lI
-----END PGP SIGNATURE-----

--------------enig4A6ABFBBEC95841E65B2CDAC--

