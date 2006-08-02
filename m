Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: AW: AW: [Xenomai-help] Convert Linux PosixThreads to Xenomai
	PosixThreads
Date: Wed, 2 Aug 2006 16:24:12 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A46D890@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org


>=20
> Even worse, if you read the specification, you will see that=20
> pthread_create should never return EINTR. A value of EINTR=20
> means that a suspending call was interrupted by a signal. It=20
> may happen if you are explicitely using signals, or=20
> alternatively when running under gdb, because gdb itself uses signals.
>=20

Dear Gilles,=20
I have to appoligize ! Not the return value has been EINTR but errno
was.
Return value has been EINVAL (big appology). Realizing this, I had a
look on the thread attributes (as the well documented return value
EINVAL says that the attributes are invalid) and after setting them
correctly all my threads are shadowed now. So, every thing works as it
should ! Sorry again, for wasting your time ! Nevertheless, your hints
helped me to get on the right track again.
Thanks a lot !
Roderik

