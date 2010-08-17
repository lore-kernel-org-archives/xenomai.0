Message-ID: <4C6A99F9.5060006@domain.hid>
Date: Tue, 17 Aug 2010 16:17:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282047938.5255.89.camel@domain.hid>	
	<4C6A8194.80008@domain.hid>
	<1282048491.5255.92.camel@domain.hid>	
	<4C6A8332.5050308@domain.hid>
	<1282049663.5255.99.camel@domain.hid>	
	<4C6A893E.9000907@domain.hid>
	<1282051157.5255.108.camel@domain.hid>	
	<4C6A8E49.10204@domain.hid>
	<1282053444.5255.116.camel@domain.hid>	
	<4C6A97EB.7000104@domain.hid>
	<1282054353.5255.121.camel@domain.hid>
In-Reply-To: <1282054353.5255.121.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?UTF-8?B?S3J6eXN6dG9mIELFgmFzemtvd3NraQ==?= <kb@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Krzysztof B=C5=82aszkowski wrote:
>> In the mean-time, please run your test with Xenomai 2.5.4.
>>
>=20
> will try to setup everything. it may take an hour too.
>=20
> i can guess that it will fail too because i have an impression that thi=
s
> issue confused you, so it is highly possible that the issue has not bee=
n
> solved yet.

Philippe has made a series of cleanups in rt_heaps for 2.5.4, as far as
I remember, it was only for processors without MMU, but maybe not.

--=20
					    Gilles.


