From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Mon, 29 Apr 2013 10:05:04 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C4664EFC670@MAIL-SINTERS-01.sinters-int.fr>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Xenomai : incompatible feature set (APF27)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

I'm using xenomai-2.6.2.1 with the APF27 board using the following configur=
ation :

- Buildroot : 2013.02
- gcc : 4.4.7
- libc : uClibc 0.9.33.2
- busybox : 1.21.0
- U-boot : 2012.04
- Linux : 2.6.29.6
- Adeos_patch : adeos-ipipe-2.6.29-arm-1.13-05.patch

The installation and the deployment were done correctly, and after transfer=
ed the images on the target. I checked the correct installation of Xenomai =
on the board with : # dmesg | grep Xenomai and have this display :

I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.

Now I want to use the tests proposed by Xenomai with : # xeno-test but have=
 this following error message :

Started child 472: /bin/sh /usr/bin/xeno-test-run-wrapper /usr/bin/xeno-tes=
t
+ echo 0
+ /usr/bin/arith
Xenomai: incompatible feature set
(userland requires "kuser_tsc fastsynch", kernel provides "sa1100 eabi fast=
synch nosmp", missing=3D"kuser_tsc").

Searching in troubleshooting, I found that I have to --enable-arm-tsc optio=
n which I did by : ./configure --enable-arm-tsc=3Dimx         =20

Recompiled and transfered the new images on the board, but I still have the=
 same error message !!

If you have some ideas or solutions, they will be welcome.

Reagrds.

Younes=20


