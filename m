Message-ID: <45733D1B.7010805@domain.hid>
Date: Sun, 03 Dec 2006 22:09:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-1?Q?_Switch_mode_with_x86?=
References: <s56d88c0.099@domain.hid> <45732660.6050605@domain.hid>
	<1165175999.4952.431.camel@domain.hid>
In-Reply-To: <1165175999.4952.431.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDE8D7574EC4A286D28CA73B4"
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
--------------enigDE8D7574EC4A286D28CA73B4
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
>=20

Here is the Xenomai scheduling sequence that leads to the deadlock. I
raised the frequency of TASK2 a bit, and this seems to accelerate the
lock-up.

=2E..
> :|  *+[  844] TASK2    1 -5061+   4.436  xnpod_resume_thread+0x48 (gate=
keeper_thread+0xf7)
> :|  *+[  827] sshd    -1 -5055+   4.015  xnpod_schedule_runnable+0x45 (=
gatekeeper_thread+0x12e)
> :|  # [  827] sshd    -1 -5015+   6.646  xnpod_schedule+0x81 (xnpod_sch=
edule_handler+0x17)
> :|  # [  844] TASK2    1 -4981+   3.721  xnpod_schedule+0x81 (xnpod_sus=
pend_thread+0x1e4)
> :|  # [   75] gatekee -1 -4971+   6.451  xnpod_schedule+0x7a2 (xnpod_sc=
hedule_handler+0x17)

So far everything is fine. Now the thrilling parts start:

> :|  # [  844] TASK2    1 -2992+   9.954  xnpod_resume_thread+0x48 (xnth=
read_periodic_handler+0x28)
> :|  # [   75] gatekee -1 -2978!  13.759  xnpod_schedule+0x81 (xnintr_ir=
q_handler+0xec)
> :|  # [  844] TASK2    1 -2955+   7.842  xnpod_schedule+0x7a2 (xnpod_su=
spend_thread+0x1e4)
> :|  # [  843] TASK1   99 -2858+   7.977  xnpod_resume_thread+0x48 (xnth=
read_periodic_handler+0x28)
> :|  # [  844] TASK2    1 -2848+   8.466  xnpod_schedule+0x81 (xnintr_ir=
q_handler+0xec)
> :|  # [  843] TASK1   99 -2831+   4.421  xnpod_schedule+0x7a2 (xnpod_su=
spend_thread+0x1e4)
> :|  # [  843] TASK1   99 -2789+   4.315  xnpod_schedule_runnable+0x45 (=
xnshadow_relax+0xd9)
> :|  # [  843] TASK1   99 -2777+   6.932  xnpod_schedule+0x81 (xnpod_sus=
pend_thread+0x1e4)
> :|  # [  827] sshd    99 -2762+   4.917  xnpod_schedule+0x7a2 (xnintr_i=
rq_handler+0xec)

The trace captured almost 200 further milliseconds, but no more
switching takes place (full dump available on request).

So we have

TASK2 resume -> TASK2 relax -> TASK1 resume/TASK2 preempted ->
TASK2 relax -> Lock-up

Gilles, are we able to produce such a sequence with the switchtest?

OK, it's time now to think a bit about what we see here. Any ideas welcom=
e.

Jan


PS: Here are the stats you asked for, Philippe:

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          5493       0     01400080   99.1  ROOT
  0  843    646        1294       0     00c00180    0.0  TASK1
  0  844    2152       4337       0     00c00088    0.0  TASK2
  0  0      0          689962     0     00000000    0.9  IRQ0: [timer]


--------------enigDE8D7574EC4A286D28CA73B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcz0bniDOoMHTA+kRAvP8AJ9nTxAjZF41E4yOb/AqupTJZ4kQmACeIaBn
jDNoxQIWSWDcSSSERClRFzs=
=uK4W
-----END PGP SIGNATURE-----

--------------enigDE8D7574EC4A286D28CA73B4--

