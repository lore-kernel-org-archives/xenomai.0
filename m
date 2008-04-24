Message-ID: <48103103.7020005@domain.hid>
Date: Thu, 24 Apr 2008 09:04:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>	<18446.32522.986935.299094@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>	<2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>	<18447.31623.723753.421351@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>	<18447.43488.713144.166771@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
	<18448.11276.526008.229326@domain.hid>
In-Reply-To: <18448.11276.526008.229326@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig575BDB1543D220CA4D215D68"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig575BDB1543D220CA4D215D68
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Karch, Joshua wrote:
>  > Gilles, (and anyone else who has had overrun errors or has experienc=
e with the Xenomai serial port driver)
>  >=20
>  > It seems that even though I turned off fprintf and even though I sto=
pped logging to disk, I still get the same number of overrun errors.  I b=
roke the loop down to the bare basics.
>  >=20
>  > my task now consists of the following
>  >=20
>  > Task was launched as follows:rt_task_create(&read_task, "read_task",=
 0, 51, 0);
>  >=20
>  >=20
>  > void sensor::mainloop()
>  > {
>  >=20
>  >=20
>  > 	//set up serial read
>  > 	struct rtser_event rx_event;
>  > 	rtser_status_t serstatus;
>  > 	int numread,err;
>  >=20
>  > 		 while(1)
>  > 		 {
>  > 			if(exitprogram)		//
>  > 				 break;
>  >=20
>  > 			err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);=

>  >=20
>=20
> As I already said, using read with timeout directly without first
> calling ioctl leads to a better latency because of the fewer system
> calls.
>=20
>  > 			if (err)
>  > 			{
>  > 				printf(RTASK_PREFIX
>  > 					       "error on RTSER_RTIOC_WAIT_EVENT, %s\n",
>  > 				  strerror(-err));
>  > 				err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatus=
);
>  > 				printf(RTASK_PREFIX "Error code line_status=3D%d modem_status=3D=
%d\n",serstatus.line_status, serstatus.modem_status);
>  >=20
>  > 			}
>  >=20
>  > 			else
>  > 			{
>  > 				numread =3D rt_dev_read(read_fd, buf, 1);
>  > 				{
>  > 					printf(RTASK_PREFIX "error on rt_dev_read, code %d %s\n",numrea=
d,
>  > 					       strerror(-numread));
>  > 					err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatu=
s);
>  > 					printf(RTASK_PREFIX "Error code line_status=3D%d modem_status=3D=
%d\n",serstatus.line_status, serstatus.modem_status);
>  > 					continue;
>  > 				}
>  > 			else
>  > 			{
>  > 				err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatus=
);  //if data received normally, make sure 96 was received, 98 =3D overru=
n
>  > 				if(!serstatus.line_status=3D=3D96)
>  > 				printf(RTASK_PREFIX "Error code line_status=3D%d modem_status=3D=
%d\n",serstatus.line_status, serstatus.modem_status);
>  > 			}
>=20
> On compilers I know if () { } else { } else {} does not even
> compile. Are you sure you are showing us the code you are really runnin=
g
> ? Have you tried T_WARNSW as I suggested in a previous mail ?
>=20
> At what frequency do characters arrive on the serial line ? Did you try=

> to run the latency test with the same frequency to see if Xenomai on
> your hardware is able to support this frequency ? Try latency -t 1 or -=
t
> 2 to see if switching to kernel-space would improve situation. Do you
> observe unexpected peaks (such as those caused by SMIs) when running
> latency ?
>=20
> Is not it possible to enable hardware buffering so as to receive more
> than one character at a time when overflow occurs ?
>=20
> If you need ultra-high frequencies, you should probably write some part=

> of your application (at least the real-time control loop) in
> kernel-space.

The 16650A driver architecture is know to be able to handle multiple
500kBit/s serial streams on a Pentium III 700 box (granted, with 128
byte RX fifos then).

But if you are at the limits of your system can be analyzed via
/proc/xenomai/stat (see also the Wiki, IIRC). If you aren't, you should
check of you box suffers from hardware-related latency peaks. What do
standard Xenomai latency tools tell you about this (like 'latency')?

Jan


--------------enig575BDB1543D220CA4D215D68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIEDEEniDOoMHTA+kRAm5pAJ47yTeAY6Qk4VDCAKkLIx3VARVcvgCfRa3s
Z1IWubuv6DAgi98h0UaoOHA=
=hG2J
-----END PGP SIGNATURE-----

--------------enig575BDB1543D220CA4D215D68--

