Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 22 Jan 2008 15:34:18 -0500
Message-ID: <BF58A8AFB316514587D61EADBFBF4C4101746623@domain.hid>
In-Reply-To: <4796458F.4060501@domain.hid>
From: "Kyle Howell" <khowell@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] x86_64 user/system process accounting
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

> Kyle Howell wrote:
> > I'm running Xenomai 2.4.1 against Linux 2.6.23.12 on an=20
> x86_64 (Core2)
> > system. I'm finding that all of my CPU cycles are being accounted as
> > kernel time rather than user time. The correct processes are still
> > billed, but the system is always 0% user. I'm wondering if=20
> this problem
> > is specific to my setup, or if it is a real bug. Can anyone else out
> > there running x86_64 confirm or deny this behavior?
>=20
> That bug should have been fixed by [1]. Already updated your ipipe=20
> patch? This one [2] also includes your recently posted fix.

Thanks, Jan.

I'm basing off of ipipe-2.6.23-x86_64-1.4-01, which appears to include
that patch. I don't think I saw this problem back on 2.4-rc3, so I may
try rolling back some of the I-pipe patches since then. Also, I just
tried a kernel with CONFIG_IPIPE turned on but CONFIG_XENOMAI turned
off, and it didn't show this problem. I don't know if that casts doubt
on Xenomai itself, or if I just made the pipeline too simple.

Do you think any of your recent fixes against 2.6.24-x86 would be
related to this?

--
Kyle Howell

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
This email and any files transmitted with it are
confidential and intended solely for the use of the
named recipient or recipients.  If you have received
this email in error please notify the sender
immediately. =20

