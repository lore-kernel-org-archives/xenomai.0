Message-ID: <4C6F9779.8000206@domain.hid>
Date: Sat, 21 Aug 2010 11:08:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282319702.5255.405.camel@domain.hid>
In-Reply-To: <1282319702.5255.405.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] rt timer jitter
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?UTF-8?B?S3J6eXN6dG9mIELFgmFzemtvd3NraQ==?= <kb@domain.hid>
Cc: xenomai@xenomai.org

Krzysztof B=C5=82aszkowski wrote:
> Do you have any idea about reducing rt timer jitter ?
> I experience annoyingly big jitter in a thread which is supposed to run=

> at 400us (i reckon this is nothing extra demanding from atom @1.6G)


> thread_task:2651 peak rt jitter -18470[ns], tsc delta 697450
>=20
>=20
> I must say it is 4 - 5 times worse if compared to rtai 3.7 / 2.6.27.19
> UP.
>=20
> I use now xenomai 2.5.4 with adeos 2.2-06 patch for same 2.6.27 kernel
> to make these comparisons more reliable.
>=20
>=20
> Can i do something with this ?

Ok. I had read that you had 400us jitter, this would have been pathologic=
al.

But 10us or 20us jitter on an ATOM is not.

The jitter on an idle system is not really significant, only the worst
case under several hours of heavy load is really significant.

--=20
					    Gilles.


