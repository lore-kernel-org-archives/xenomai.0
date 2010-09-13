Message-ID: <4C8DE9CE.9050900@domain.hid>
Date: Mon, 13 Sep 2010 11:07:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=Wke_BOMmq4P-SSoaMnaDVfBV=2Hmn5TZF7QgQ@mail.gmail.com>
In-Reply-To: <AANLkTi=Wke_BOMmq4P-SSoaMnaDVfBV=2Hmn5TZF7QgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_queue_read and EPERM?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?SmVucyBLw7ZobGVy?= <jenskxxx@domain.hid>
Cc: xenomai@xenomai.org

Jens K=C3=B6hler wrote:
> Hello
>=20
> I am try to use a RT_QUEUE. I am writing messages with rt_queue_write t=
o
> the queue. But when function rt_queue_read is called result is always  =
"-1".
> =20
> "-1" means EPERM. What means exactly: "EEPERM is returned if this
> service should block"? I don't understand why a function should block t=
o
> get a message from a queue!?

A piece of code is worth a thousand words. Please send us a piece of
code showing the behaviour you find suspicious.

--=20
					    Gilles.


