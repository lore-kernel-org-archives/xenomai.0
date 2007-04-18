Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Apr 2007 07:58:06 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805EC79@domain.hid>
In-Reply-To: <17957.2778.801915.659858@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] Adeos support for IXP4xx
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, xenomai@xenomai.org

> -----Original Message----- From: Gilles Chanteperdrix
>> 		*IXP4XX_OSRT1 =3D LATCH | ONE_SHOT_ENABLE;
>=20
> In fact, should not this be:
>=20
>                 *IXP4XX_OSRT1 =3D=20
>                   (last_jiffy_time + LATCH - *IXP4XX_OSTS) |
ONE_SHOT_ENABLE;

Nope, we are using GP Timer 1. It counts down from the dialed value and
then stops. It is _not_ a free running timer.

Richard

