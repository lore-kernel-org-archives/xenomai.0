Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 May 2007 10:40:13 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>
In-Reply-To: <465E8FA8.4030507@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<465ADB44.2070705@domain.hid><1180360288.4727.50.camel@domain.hid>	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>	<465BE777.7010204@domain.hid>	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>	<465C6268.1090704@domain.hid>	<18012.28254.882249.144005@domain.hid>	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid><7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid><465D664E.3040700@domain.hid>
	<465E8FA8.4030507@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

I checked README.INSTALL for the ppc part and there the documentation is =
also wrong.

I think I have to reinstall Xenomai now and take out the =
Wl,--start-group in our make files ...

Very interesting thread.


Best regards,

Daniel.

-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
On Behalf Of Jan Kiszka
Sent: 31. ma=ED 2007 09:05
To: Perrine Martignoni
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Xenomai with =B5Clibc

Jan Kiszka wrote:
> I noticed that linking like this
>=20
> arm-linux-gcc ...<flags> <object>.o -lpthread -lrt -lpthread_rt ...
>=20
> doesn't raise the error. But linking like this
>=20
> arm-linux-gcc `xeno-config --posix-ldflags` <object>.o -o <target>
>=20
> ie. the standard way for external Xenomai POSIX apps, causes even more =

> problems with this toolchain (it's fine here for native builds).=20
> Anyone any comments? Maybe Wolfgang?

Reason found, I think. No ELDK issue, rather a bug in Xenomai's
README.INSTALL:

Perrine, did you happen to configure Xenomai with "configure =
--host=3Darm ..."? If yes (see config.log), please use =
"--host=3Darm-linux". This solved all issues for me.

Awaiting your feedback!

Jan


