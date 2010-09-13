Message-ID: <4C8E118F.7010404@domain.hid>
Date: Mon, 13 Sep 2010 13:57:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=Wke_BOMmq4P-SSoaMnaDVfBV=2Hmn5TZF7QgQ@mail.gmail.com>	<4C8DE9CE.9050900@domain.hid>
	<AANLkTik4rjQzwnU82OBudtkeS+kO+fbD1RjFXvXK7=qS@mail.gmail.com>
In-Reply-To: <AANLkTik4rjQzwnU82OBudtkeS+kO+fbD1RjFXvXK7=qS@mail.gmail.com>
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
> Hello Gilles,
> =20
> here is the code:
> =20
> RT_QUEUE myqueue;
> int retval;
> retval =3D rt_queue_create(&myqueue, "myqueue", 255, 10, Q_FIFO);
> =20
> char message[100] =3D "Message ";
> retval =3D rt_queue_write(&myqueue,message,sizeof(message),Q_NORMAL);
> //retval is 0
> =20
> char msgBuf[255];
> retval =3D rt_queue_read(&myqueue, msgBuf, sizeof(msgBuf), TM_NONBLOCK)=
;
> //retval is always -1, why?

Probably because the callling thread is not a Xenomai thread, it is a
simple Linux thread, and as such, is not allowed to switch to primary
mode as is required by rt_queue_read.

--=20
					    Gilles.


