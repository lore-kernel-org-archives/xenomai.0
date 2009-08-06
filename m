Message-ID: <4A7B3DD9.4030000@domain.hid>
Date: Thu, 06 Aug 2009 22:32:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e0908050557s3789edcdq5b8b6b88bf52861b@domain.hid>
In-Reply-To: <8b216e9e0908050557s3789edcdq5b8b6b88bf52861b@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Slow boot with Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: xenomai@xenomai.org

Felipe Brand=C3=A3o Cavalcanti wrote:
> Hello,
> We are currently trying to install Xenomai (version 2.5rc2) on a Geode =
GX1
> (PCM 3350 board), kernel 2.6.26 (Debian 5.0).

The Geode is a very very bad choice:
- it is going to disappear any time soon
- its performances in many domains are far from the average x86
performances.

 However, we have run into a
> few issues.
>=20
> Whenever we install the kernel with Local APIC support enabled, xenomai=

> gives the error:
>=20
> Xenomai: Local APIC absent or disabled!
> Disable APIC support or pass "lapic=3D1" as bootparam.

Ok. I guess your Geode does not have an APIC. I have a Geode and just
checked, it has the same issue, so, you should turn of apic in kernel
configuration. Maybe something is needed in the BIOS to enable it
(because the AMD specs say that the Geode has an APIC).

>=20
>=20
> Passing the lapic=3D1 parameter doesn't seem to do much, so we decided =
to turn
> off APIC support in the kernel.
>=20
> The kernel now boots, however, it does so extremely slowly. It is hangi=
ng
> (i.e., takes a long time) whenever an IRQ probe is required.
> The latencies are also pretty bad - worst case in xeno-test is 2ms!
>=20
> So, any ideias on why this is happening?

Probably an issue induced by power management disabling the tsc. So the
usual advices apply, please be sure to disable any smart power
management issue in the bios configuration and to boot with ACPI enabled
(except ACPI_PROCESSOR). Someone, a long time ago, posted on the RTAI
mailing list a way to disable this tsc thing by running an outb at a
well defined address, but I never was able to test it since my Geode
does not have this issue. Another workaround reported to work is to boot
with idle=3Dpoll passed on the command line. Yet another workaround is to=

avoid using the tsc (by selecting in the kernel configuration a
processor without tsc), but this means a lot of overhead.

--=20
					    Gilles.


