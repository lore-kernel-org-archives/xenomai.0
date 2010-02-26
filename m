From: "Charlton, John" <john.charlton@domain.hid>
Date: Fri, 26 Feb 2010 12:15:22 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2006483DE98E@us194mx002.tycoelectronics.net>
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>
	<4B86EDC2.7010905@domain.hid> <4B86FCBB.10203@domain.hid>
	<4B86FFA0.3000403@domain.hid> <4B870134.2040802@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>
	<4B87FC70.90903@domain.hid>
In-Reply-To: <4B87FC70.90903@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "'jan.kiszka@domain.hid'" <jan.kiszka@domain.hid>

Yes. watchdog is enabled with 4 sec in both 2.4.6.1 and 2.5.1 builds.

--

John=20

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Friday, February 26, 2010 11:53 AM
To: Charlton, John
Cc: 'jan.kiszka@domain.hid'; xenomai@xenomai.org
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()

Charlton, John wrote:
> I am attaching a simpler portion of the timer loop that demonstrates=20
> the problem.  As I said before the problem does not occur with
> xenomai-2.4.6.1/linux-2.6.27.7 but does occur with=20
> xenomai-2.5.1/linux-2.6.32.7.
>=20
> I had some problems applying your patch so I will let you know if I am=20
> able to do that.

But did you have the watchdog enabled with 2.4.6.1 ?

--=20
					    Gilles.

