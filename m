Message-ID: <4D4C7A98.1030104@domain.hid>
Date: Fri, 04 Feb 2011 23:15:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikSnhe5fnSLQm7eSOh9R7YA2cJ=m78n+S3kpW9K@mail.gmail.com>	<4D4A84ED.7030604@domain.hid>	<4D4A8BD8.1060900@domain.hid>	<4D4A9052.2090508@domain.hid>	<4D4A9118.2070602@domain.hid>	<4D4A957B.6050907@domain.hid>	<4D4A9654.80402@domain.hid>	<4D4AA479.2020808@domain.hid>	<4D4AABF4.6030804@domain.hid>
	<AANLkTimdawDBCnZon1v06F6uFf1dqwt8Re11rXPv6ZnY@mail.gmail.com>
In-Reply-To: <AANLkTimdawDBCnZon1v06F6uFf1dqwt8Re11rXPv6ZnY@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RT OS Selection advice for parallel processing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rudolf Meijering <rudolf@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Rudolf Meijering wrote:
> Thanks a lot for everyone's input! It seems like for our application, G=
PU
> off-loading is not the way to go. We have redesigned our system for all=

> processing to take place on the Intel i7. Total maximum processing late=
ncy
> stays 100ms, and interrupt frequency goes up to 1.5 KHz.
>=20
> I have done some research on the pro's and con's of PREEMPT_RT vs Xenom=
ai.
> As far as I can determine some of the benefits include:
> 1. Programming with Xenomai native API's are more elegant than POSIX
> real-time API=E2=80=99s.
> 2. Xenomai has possibly less overhead than a full preemptive kernel. Th=
e
> user interface does not require RT capabilities.
>=20
> Are there any other substantial benefits worth considering? Which would=
 you
> use?

Another factor, is that with Xenomai, the application needs a clear
separation between real-time and non real-time tasks. They do not use
the same services, they need to interact through special means. This is
a double edged sword:
- on one edge, with this clear separation, you have no doubt about which
code will be deterministic and which will not be;
- on the other edge, you end up using two APIS for interacting with two
different schedulers, which complicates things a bit.

--=20
                                                                Gilles.


