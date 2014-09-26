Message-ID: <542534C5.40603@xenomai.org>
Date: Fri, 26 Sep 2014 11:41:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <a704f2630b5f4f11a891ffe53088983a@CVEX13.valentin-carl.de>
In-Reply-To: <a704f2630b5f4f11a891ffe53088983a@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xeno-test on arm: ("/usr/xenomai/bin/smokey:
 sched_setconfig_np(add-quota-group): Invalid argument")
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/26/2014 11:23 AM, Reitinger, Peter wrote:
> -----Urspr=FCngliche Nachricht-----

> /usr/xenomai/bin/smokey: sched_setconfig_np(add-quota-group): Invalid arg=
ument
> calibrating: 133262220 loops/sec
> root@dimm-am335x:/usr/xenomai/bin#
>=20
> ----
>=20
> My version is:
>=20
> root@dimm-am335x:/usr/xenomai/sbin# ./version -a
> Xenomai/cobalt v3.0-rc1 -- #2e808a6 (2014-09-25 21:12:15 +0200)
> Target: arm-poky-linux-gnueabi
> Compiler: gcc version 4.8.1 (GCC)
> Build args:  '--with-core=3Dcobalt' '--prefix=3D/usr/xenomai' '--disable-=
debug' '--disable-assert' '--host=3Darm-poky-linux-gnueabi' 'host_alias=3Da=
rm-poky-linux-gnueabi' 'CC=3Darm-poky-linux-gnueabi-gcc  -marc
> h=3Darmv7-a -mthumb-interwork -mfloat-abi=3Dsoftfp -mfpu=3Dneon --sysroot=
=3D/opt/poky/1.5.1/sysroots/armv7a-vfp-neon-poky-linux-gnueabi' 'CFLAGS=3D =
-O2 -pipe -g -feliminate-unused-debug-types' 'LDFLAGS=3D-Wl,-O1
> -Wl,--hash-style=3Dgnu -Wl,--as-needed' 'CPPFLAGS=3D' 'CPP=3Darm-poky-lin=
ux-gnueabi-gcc -E  -march=3Darmv7-a -mthumb-interwork -mfloat-abi=3Dsoftfp =
-mfpu=3Dneon --sysroot=3D/opt/poky/1.5.1/sysroots/armv7a-vfp-neon-
> poky-linux-gnueabi' 'PKG_CONFIG_PATH=3D/opt/poky/1.5.1/sysroots/armv7a-vf=
p-neon-poky-linux-gnueabi/usr/lib/pkgconfig'
> root@dimm-am335x:/usr/xenomai/sbin#
>=20
> I feel that it is no bad idea to automate my process for re-fetching sour=
ces, and re-building everything, meanwhile... ;-)
>=20
> Thanks again in advance!
>=20

For the whole testsuite to pass, you will have to to activate all
features that may be tested in the kernel. The new x3 infrastructure for
smoke testing is still a bit raw when it comes to detecting such issues
upfront, this will be improved.

You will need CONFIG_XENO_OPT_SCHED_CLASSES from the kernel
configuration, then all the depending opts (quota scheduling and time
partitioning, at least).

If you plan for latency measurements, then you may want to have a look
at the new autotuner feature, for getting the best core clock settings
for Cobalt:
http://www.xenomai.org/documentation/xenomai-3/html/man1/autotune/index.html

--=20
Philippe.

