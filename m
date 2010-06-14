Message-ID: <4C168B04.1040506@domain.hid>
Date: Mon, 14 Jun 2010 22:03:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid>	<4C1353D8.2060507@domain.hid>	<AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid>	<4C136558.4070002@domain.hid>
	<AANLkTim0yd_MTu3ItT9aecUmH0yt1nj3TWbFVMcfcFMB@mail.gmail.com>
In-Reply-To: <AANLkTim0yd_MTu3ItT9aecUmH0yt1nj3TWbFVMcfcFMB@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCDAC61B5F84BCB620AA80EFD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] error on rt_dev_read, code Success,
	what does it mean?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDAC61B5F84BCB620AA80EFD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Everett Wang wrote:
> On Sat, Jun 12, 2010 at 6:45 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Everett Wang wrote:
>>> Thanks. I looked my code again, which is modified from example
>>> cross-link.c. The section looks like:
>>>
>>> ...
>>>                  irq_time =3D rx_event.rxpend_timestamp;
>>>                 read =3D rt_dev_read(read_fd, &write_time, sz);
>>>                 if (read =3D=3D sz) {
>>>                         read_time =3D rt_timer_read();
>>>                         printf("%3d |%16llu |%16llu |%16llu\n", nr,
>>>                                irq_time  - write_time,
>>>                                read_time - irq_time,
>>>                                read_time - write_time);
>>>                         nr++;
>>>                 } else if (read < 0 ) {
>>>                         printf(RTASK_PREFIX "error on rt_dev_read, co=
de %s\n",
>>>                                strerror(-err)); <<<<<<<=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>>                         break;
>>>                 } else {
>>>                         printf(RTASK_PREFIX "only %d / %d byte receiv=
ed \n",
>>>                                read, sz);
>>>                         break;
>>>                 }
>>> ...
>>> I guess I should change the strerror(-err) to strerror(-read).
>> Indeed, the example suffers from some copy&paste mistakes. Same for th=
e
>> write path. And closing in a loop is no longer required. A cleanup is
>> needed.
>>
>>> If I do
>>> that, I some
>>> times get a " code input/output error". That is better. What can caus=
e
>>> input/output error?
>> Try RTSER_RTIOC_GET_STATUS to learn more.
>=20
> Thanks for answer my questions, I added
>=20
> err =3D rt_dev_ioctl(gps_fd,
>                         RTSER_RTIOC_GET_STATUS, &serstatus);
> printf(STASK_PREFIX "Error code line_status=3D%d
> modem_status=3D%d\n",serstatus.line_status, serstatus.modem_status);
>=20
> This prints a message:
>=20
> gps_task: Error code line_status=3D98 modem_status=3D187
>=20
> Line_status bits are  RTSER_LSR_TRANSM_EMPTY , RTSER_LSR_THR_EMTPY,
> RTSER_LSR_OVERRUN_ER
>=20
> and modem status bits:
>  RTSER_MSR_DCD, 	RTSER_MSR_DSR ,RTSER_MSR_CTS, 	RTSER_MSR_DDCD,
> RTSER_MSR_DDS, RTSER_MSR_DCTS
>=20
> Does it caused by "RTSER_LSR_OVERRUN_ER"?
> The GPS device outputs upto 450 characters every 0.1 second.

Looking at your code, you probably want to clear the quickly overflowing
RX queue and pending overflow errors before entering the read loop.

Jan


--------------enigCDAC61B5F84BCB620AA80EFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwWixAACgkQitSsb3rl5xTdwQCg0FS8z26l2RWhiAa2n92AgX5z
IoUAn0F5sMluUi2rboVkENKkQxky+tse
=AZj0
-----END PGP SIGNATURE-----

--------------enigCDAC61B5F84BCB620AA80EFD--

