Message-ID: <45732F25.9040804@domain.hid>
Date: Sun, 03 Dec 2006 21:10:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-1?Q?_Switch_mode_with_x86?=
References: <s56d88c0.099@domain.hid> <45732660.6050605@domain.hid>
	<1165175999.4952.431.camel@domain.hid>
In-Reply-To: <1165175999.4952.431.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3BF1DD5397DDF1F7CC50DFBF"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3BF1DD5397DDF1F7CC50DFBF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2006-12-03 at 20:32 +0100, Jan Kiszka wrote:
>> Nicolas BLANCHARD wrote:
>>>>>>> "Nicolas BLANCHARD" <n.blanchard@domain.hid> 29.11 11:25 >>=
>
>>>> Hello,
>>>>
>>>> I've tested wiith Xenomai 2.3-rc2 (adeos 1.5-02)
>>>> and change the config :=20
>>>>                                        - CONFIG_M586
>>>>                                        - disable CONFIG_INPUT_PCSPKR=

>>> (it was on module)
>>>>                                        - disable prio boosting (chec=
k
>>> CONFIG_XENO_OPT_RPDISALBLE)
>>>> and it seems to work better, one hour without blocking, it's a recor=
d
>>>> for me.
>>>>
>>>> So, i will investigate to find which modification improve my problem=
=2E
>>> After somes tests (kernel compil), it seems that prio boost is
>>> responsable of my
>>> problem. When it's disable (kernel option checked) my program run
>>> correctly.
>> Confirmed!
>>
>> root@domain.hid :/root# cat /proc/xenomai/sched
>> CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
>>   0  0       99      0        0          R          ROOT
>>   0  837     99      9999312  0          X          TASK1
>>   0  838      0      10999998 0          R          TASK2
>>
>> So far "only" on real hardware (P-I 133) with CONFIG_M586 and (this is=

>> likely also very important) CONFIG_PREEMPT. I'm now about to check if =
I
>> can migrate this problem into qemu and/or capture it with the I-pipe t=
racer.
>>
>=20
> Please also try moving task2 to the SCHED_FIFO class to see if things
> evolve.

No difference:

root@domain.hid :/root# cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       99      0        0          R          ROOT
  0  829     99      9999312  0          X          TASK1
  0  830      1      3002894  0          R          TASK2

qemu over my notebook is somehow too fast to reproduce the race, I'm now
instrumenting the target.

Jan


--------------enig3BF1DD5397DDF1F7CC50DFBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcy8lniDOoMHTA+kRAjXpAKCBFN8zTxeEPmT27I+mQaLgt0tM+QCfdncl
xuNHC2lDKRYiDylDWNkjPCc=
=PwsQ
-----END PGP SIGNATURE-----

--------------enig3BF1DD5397DDF1F7CC50DFBF--

