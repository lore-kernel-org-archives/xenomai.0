Message-ID: <4549B048.8070607@domain.hid>
Date: Thu, 02 Nov 2006 09:46:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] POSIX headers and PTHREAD_IPROPAGATE
References: <454931B9.3070304@domain.hid>
In-Reply-To: <454931B9.3070304@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jeff Webb wrote:
> If I attempt to use PTHREAD_IPROPAGATE in my userspace POSIX skin=20
> Xenomai program, I get the following:
>=20
> irqtest.c: In function =91main=92:
> irqtest.c:278: error: =91XN_ISR_PROPAGATE=92 undeclared (first use in t=
his=20
> function)irqtest.c:278: error: (Each undeclared identifier is reported=20
> only once
> irqtest.c:278: error: for each function it appears in.)
>=20
> Including <nucleus/intr.h> fixes the problem.  I assume there should be=
=20
> a #include in one of the POSIX header files.

I checked the trunk and the v2.2.x branch, and pthread.h includes
nucleus/xenomai.h which includes nucleus/intr.h, so including directly
nucleus/intr.h should not be necessary.

--=20
                                                  Gilles Chanteperdrix

