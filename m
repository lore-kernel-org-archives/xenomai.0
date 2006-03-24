Message-ID: <4423E7CE.3000105@domain.hid>
Date: Fri, 24 Mar 2006 13:36:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] read data from serial device
References: <dvrrgc$g2a$1@domain.hid>
In-Reply-To: <dvrrgc$g2a$1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA8EBF30F336C761B9B41B715"
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
To: Marco Jackel <ich@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8EBF30F336C761B9B41B715
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marco Jackel wrote:
> Hi there,
>=20
> ATTENTION: I'm a xenomai-newbie
> I want to read data from the serial device
>=20
> I got the serial driver loop demo from
> http://www.captain.at/xenomai-serial-port-example.php

Unfortunately outdated, no longer compiles against recent Xenomai 2.1.
See the recent version at
http://www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon instead.

@Hannes: Please update your site to avoid confusion!

> It worked without any problems.
> Then I modified the demo to read data only (remove all the write_task
> stuff).
>=20
> But I get this error when I do a "echo 123 > /dev/ttyS0" on a other
> computer connected with a serial cable.
>=20
>> voyage:/usr/src/tests/getserial# ./getserial
>> rt_serial_uprog: PRESS CTRL-C to EXIT
>> rt_serial_uprog: timer started
>> rt_serial_uprog: rtser_file opened
>> rt_serial_uprog: serial-port-config written
>> rt_serial_uprog: read-task created
>> rt_serial_uprog: starting read-task
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (1 times)
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (2 times)
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (3 times)
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (4 times)
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (5 times)
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (6 times)
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (7 times)
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (8 times)
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (9 times)
>> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (10 times)
>> rt_serial_uprog: delete write_task
>> rt_serial_uprog: stop timer
>> rt_serial_uprog: exit
>=20
> and:
>=20
>> Mar 22 15:02:46 voyage kernel: 00000000
>> Mar 22 15:02:46 voyage kernel: PREEMPT
>> Mar 22 15:02:46 voyage kernel: Modules linked in: xeno_16550A xeno_rtd=
m ohci_hcd usbcore sis900 mii dm_mod
>> Mar 22 15:02:46 voyage kernel: CPU:    0
>> Mar 22 15:02:46 voyage kernel: EIP:    0060:[<00000000>]    Not tainte=
d VLI
>> Mar 22 15:02:46 voyage kernel: EFLAGS: 00010002   (2.6.15.4-gx1-25)
>> Mar 22 15:02:46 voyage kernel: EIP is at _stext+0x3feffdc0/0xb4
>> Mar 22 15:02:46 voyage kernel: eax: c0316b80   ebx: c03168e0   ecx: c0=
3173a0   edx: c03168e0
>> Mar 22 15:02:46 voyage kernel: esi: 00000004   edi: c03168e8   ebp: c0=
3173d0   esp: cdc8ddd4
>> Mar 22 15:02:46 voyage kernel: ds: 007b   es: 007b   ss: 0068
>> Mar 22 15:02:46 voyage kernel: Process read_task (pid: 1320, threadinf=
o=3Dcdc8c000 task=3Dce951a50)
>> Mar 22 15:02:46 voyage kernel: Stack: c010c6ad 00000004 00000000 cffdf=
2fa 00000048 c03173e0 00000000 c03168e0
>> Mar 22 15:02:46 voyage kernel:        ffffffff 00000001 00000000 00000=
002 c03168e0 c03168e0 00000046 c012f6fe
>> Mar 22 15:02:46 voyage kernel:        018f7a35 00000048 00000000 00000=
000 ffffffd5 ce84a110 d0054c07 c02482c6
>> Mar 22 15:02:46 voyage kernel: Call Trace:
>> Mar 22 15:02:46 voyage kernel:  [__ipipe_sync_stage+468/606] __ipipe_s=
ync_stage+0x1d4/0x25e
>> Mar 22 15:02:46 voyage kernel:  [ipipe_unstall_pipeline_from+196/238] =
ipipe_unstall_pipeline_from+0xc4/0xee
>> Mar 22 15:02:46 voyage kernel:  [pg0+265423879/1070375936] rtdm_event_=
timedwait+0x167/0x171 [xeno_rtdm]

Which Xenomai version, which xeno_16550A version (/proc/xenomai/rtdm/)?
I think we have fixed such an issue some time back, and this should at
least made it into Xenomai 2.1. Please confirm that it's an issue
persisting with xeno_16550A version 1.2.6.

Thanks,
Jan


--------------enigA8EBF30F336C761B9B41B715
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEI+fOniDOoMHTA+kRAtC2AJ9s5a+iIZgRx2Fq7ISKsPG8yKvmLACeMsZX
Uj9jTjnIbpCLTXNm5a+lKa4=
=OoOu
-----END PGP SIGNATURE-----

--------------enigA8EBF30F336C761B9B41B715--

