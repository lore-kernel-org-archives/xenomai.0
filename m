Message-ID: <46FFE6BB.6070504@domain.hid>
Date: Sun, 30 Sep 2007 20:11:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709261252o67cebde3q8cf03a0d21a27288@domain.hid>	
	<46FFC5FE.5080406@domain.hid>
	<1ce16a2c0709300923g339c6760hecd76a78a2c6424e@domain.hid>
In-Reply-To: <1ce16a2c0709300923g339c6760hecd76a78a2c6424e@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig779FFACB87A1B75C32573D8F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtdm driver development
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig779FFACB87A1B75C32573D8F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bachman Kharazmi wrote:
> I've _solved_ my problem since a few days.
> My code is available here: http://bachman.tor.lindesign.se/mthesis/code=
/comm/
> What it does is that it makes it possible to write to a rtp0 device
> file which then handles the periodic push and write to a rtser0.
>=20
> Questions which still remain.
> -Are there any problems setting a high value for the pipe task?
> #define TASK_STKSZ_PIPETASK  50000
>=20
> I use it when creating the task:
> rt_task_create(&task3,"kernel_task3",TASK_STKSZ_PIPETASK,TASK_PRIO_PIPE=
TASK,TASK_MODE);
> Is it the size of data that the pipe can handle before it gets filled?

The pipe buffer is configure through the pipe API, not via the task that
fills it. Above, you are setting the task stack size, that's something
different. Please read the fine API documentation.

>=20
> -Can I write data to the pipe( /dev/rtp0 ) using the outputstream from
> java without any delays? In the example testa.java I do that, but I'm
> working on getting that working from a data-generating thread. so that
> there will be a continues quick write to the device.
>=20
> -When is a outputstream.flush() needed? Is that after every single
> command or just once at the end when all write():s are done?

I least I can't help you with Java-internal questions. How Java uses
that devices is not in the hands of Xenomai.

Jan


--------------enig779FFACB87A1B75C32573D8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG/+a7niDOoMHTA+kRAlVAAJ44u/9fxipwKrrCWFAXVnJs/t3D0wCfW9wA
wWPlkDbR60RKNNNO7staz+A=
=dFbz
-----END PGP SIGNATURE-----

--------------enig779FFACB87A1B75C32573D8F--

