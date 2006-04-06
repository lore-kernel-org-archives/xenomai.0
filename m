From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Thu, 6 Apr 2006 13:42:41 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200604061342.41254.lbocseg@domain.hid>
Subject: [Xenomai-core] SIGXCPU snippet not working
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Hi Philippe,

I think I've found another bug on SVN. When trying to run the sigxcpu snipp=
et=20
provided with Xenomai I received only the following lines:

Switched to secondary mode
Switched to secondary mode
Switched to secondary mode
...

The backtrace was not shown. Actually warn_upon_switch wasn't been called, =
so=20
I think the application was not receiving the signals correctly.

This is how I compiled it:
cc `xeno-config --xeno-cflags`  `xeno-config --xeno-ldflags` -lnative =20
sigxcpu.c   -o sigxcpu

Could you please verify this?

Thanks again,

Rodrigo.

	=09
_______________________________________________________=20
Abra sua conta no Yahoo! Mail: 1GB de espa=E7o, alertas de e-mail no celula=
r e anti-spam realmente eficaz.=20
http://br.info.mail.yahoo.com/


