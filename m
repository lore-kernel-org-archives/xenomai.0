Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <51850F84.6090204@xenomai.org>
Date: Sat, 4 May 2013 16:30:12 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <C24A4431-BF7F-46A6-B6B7-D90DFA27444A@mah.priv.at>
References: <8AC37F92-E842-45E8-8583-9C1A7D8C9930@mah.priv.at>
	<5184483E.1050305@xenomai.org>
	<8A7AED52-BB19-44B2-B1FE-B1E7FBE84915@mah.priv.at>
	<51850F84.6090204@xenomai.org>
Subject: Re: [Xenomai] 3.8.10 beaglebone failure: any clues I missed?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Am 04.05.2013 um 15:39 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:

> On 05/04/2013 08:04 AM, Michael Haberler wrote:
>=20
>> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
>> (modprobe xeno_native?)
>=20
>=20
> See:
> =
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_xe=
nomai_native_skin_or_config_xeno_opt_pervasive_disabled

I went through that before posting,  and found no clue hinting to the =
above, see below;

on my first attempt, I managed to start from branch am33x-v3.2 instead =
from tag 3.8.10-bone15, so failure was obvious but thats fixed

is there a requirement the patch files need to reside in =
xenomai-2.6/arch/arm/patches/* before doing scripts/prepare-kernel.sh ?

still dead sure it's a 'duh' build goof

-m

linuxcnc@arm:/proc$ zgrep CONFIG_XENO_SKIN_NATIVE /proc/config.gz=20
CONFIG_XENO_SKIN_NATIVE=3Dy
linuxcnc@arm:/proc$ zgrep CONFIG_XENO_OPT_PERVASIVE  /proc/config.gz=20
CONFIG_XENO_OPT_PERVASIVE=3Dy
linuxcnc@arm:/proc$=20

linuxcnc@arm:/proc$ cat  xenomai/version=20
2.6.2.1
linuxcnc@arm:/proc$ cat  ipipe/version  =20
3

$ dmesg|grep Xen
[    0.525268] I-pipe: head domain Xenomai registered.
[    0.525324] Xenomai: hal/arm started.
[    0.527211] Xenomai: scheduling class idle registered.
[    0.527245] Xenomai: scheduling class rt registered.
[    0.536062] Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) =
loaded.
[    0.536081] Xenomai: debug mode enabled.
[    0.536715] Xenomai: starting native API services.
[    0.536739] Xenomai: starting POSIX services.
[    0.537025] Xenomai: starting RTDM services.

> --=20
>                                                                Gilles.


