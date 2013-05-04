Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <5184483E.1050305@xenomai.org>
Date: Sat, 4 May 2013 08:04:37 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A7AED52-BB19-44B2-B1FE-B1E7FBE84915@mah.priv.at>
References: <8AC37F92-E842-45E8-8583-9C1A7D8C9930@mah.priv.at>
	<5184483E.1050305@xenomai.org>
Subject: Re: [Xenomai] 3.8.10 beaglebone failure: any clues I missed?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: xenomai@xenomai.org

Gilles, Stephan -

I suspect a more simple build goof on my behalf, but I dont quite see it =
yet; these were the steps I used:


tar xvf ipipe-kernel-3.8.10.patch.tar.bz2
git clone git://git.xenomai.org/xenomai-2.6.git   # using master
git clone https://github.com/RobertCNelson/linux-dev.git
cd linux-dev
git checkout 3.8.10-bone15 -b tmp
./build_kernel.sh
#... vanilla kernel builds fine..

# suspicious: I get some patching fuzz here but no rejects:
 ../xenomai-2.6/scripts/prepare-kernel.sh  --linux=3DKERNEL --arch=3Darm =
--ipipe=3D../ipipe-kernel-3.8.10.patch

cd KERNEL
patch -p1 <../../post.patch # no fuzz
cd ..
tools/rebuild.sh=20
# disable frequency scaling in menuconfig
# xenomai kernel builds fine


this time around, I get:=20

./xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m /tmp =
100" -t 2
Started child 1921: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper =
./xeno-regression-test -t 2
++ echo 0
++ /usr/xenomai/bin/arith
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

however:

root@arm:/proc# cat /proc/ipipe/version=20
3
root@arm:/proc# cat /proc/xenomai/version=20
2.6.2.1

smoke, but no fire yet;)

- Michael


Am 04.05.2013 um 01:29 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:

> On 05/03/2013 11:54 PM, Michael Haberler wrote:
>=20
>> I've built a 3.8.10 beaglebone kernel using Stephane's patch and
>> xenomai-2.6 master ; only config changes from default config were:=20
>> disable frequency scaling, and disable smp (but same symptoms as
>> below without these changes)
>=20
>=20
>>=20
>> - kernel boots fine - 'sudo xeno-regression-test -l
>> "/usr/lib/xenomai/testsuite/dohell -m /tmp 100" -t 2' aborts like so:
>> http://static.mah.priv.at/public/regression.txt
>=20
>=20
> I can not reproduce these issues, so, I must assume it is either=20
> specific to beaglebone or 3.8.10. Could you try 3.8.0 to help narrow=20=

> down the issue?
>=20
> What arguments are passed to xenomai configure script?
>=20
>> - starting the
>> linuxcnc latency-test (which basically starts two userland threads)
>> hangs the board
>>=20
>> I'm a bit at wit's end - any suggestions?
>=20
>=20
> Try:
> - running a kernel with CONFIG_IPIPE_DEBUG_CONTEXT and=20
> CONFIG_IPIPE_DEBUG_INTERNAL enabled;
> - booting a kernel without CONFIG_IPIPE and CONFIG_XENOMAI, run:
>=20
> cat /proc/interrupts=20
>=20
> and check that all the interrupts controller you find=20
> mentioned here have been changed following the instructions on this=20
> page:
> =
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Interrupt_controll=
er
>=20
> --=20
>                                                                Gilles.


