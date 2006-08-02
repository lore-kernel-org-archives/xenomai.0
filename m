Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] Convert Linux PosixThreads to Xenomai PosixThreads
Date: Wed, 2 Aug 2006 11:32:43 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A46D7CF@ARVMAIL1.mra.roland-man.biz>
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

Gilles Chanteperdrix :
>> But when I start my application I still get just Linux threads and no =
Xenomai=20
>> shadow tasks are created. Can anybody give me a hint how I can =
controll what
>> kind of thread is created ?>=20

> Normally, any thread created with pthread_create has a=20
> shadow. Whether they are started in primary mode depends on=20
> their scheduling policy.
>=20

I think this was the hint I have been looking for.
Now I set some attributes explicitly :
   nResult =3D pthread_attr_setinheritsched(&attr, =
PTHREAD_EXPLICIT_SCHED);
   ASSERT(nResult =3D=3D 0);
   nResult =3D pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
   ASSERT(nResult =3D=3D 0);
(although this should be the default)

But when I create a thread with=20
 nResult =3D pthread_create(&tid, &attr, (void *) & body, pTask);
pthread_create returns with 4=3DInterrupted system call. Unfortunatelly =
this return value is not documented. Can you tell me what it means ?=20

>=20
> Could you try reducing your problem to a program as simple as=20
> possible, and send us the sources of this program ?=20

I=B4ll try this when I am not succesfull in starting threads with the =
changed attributes (see above).

> How do=20
> you know that no shadow threads are created ?
>=20

I had a look in /proc/xenomai/sched and couldn=B4t see any Xenomai-task. =
Isn=B4t this the usual way ?


Thanks a lot
Roderik

