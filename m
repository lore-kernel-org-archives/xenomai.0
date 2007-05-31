Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 May 2007 11:41:42 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01F55047@domain.hid>
In-Reply-To: <465E93D6.2010309@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01E43DFF@is-hdq-exchange.marel.net>
	<465E93D6.2010309@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] Kernel-oops, cyclictest, ctrl-c, MPC5200B
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Hi,

I tried cyclictest and svn trunk (rev. 2506), different parameters.


Problem is gone.


Thanks,

Daniel

-----Original Message-----
From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Sent: 31. ma=ED 2007 09:23
To: Daniel Schnell
Subject: Re: [Xenomai-help] Kernel-oops, cyclictest, ctrl-c, MPC5200B

Daniel,

Daniel Schnell wrote:
> Hi,
>=20
> When experimenting with the cyclictest program for trying out=20
> /proc/xenomai/latency I found out that ending this program with=20
> <STRG>-c causes a Kernel oops of my 2.4.25 Kernel. There seems to be=20
> an infinite recursion. /proc/xenomai/latency was left at its standard =
value.
> Cyclictest is started without any parameters.
>=20
> I use the Xenomai 2.3.1 release.=20

Could you re-test with trunk or 2.3.x SVN? I would really like to know =
if we got this issue as well. Note that the fixed problem depended on =
XENO_OPT_SCALABLE_SCHED. So if this option was off for your tests, then =
there is still some other issue.

Thanks,
Jan


