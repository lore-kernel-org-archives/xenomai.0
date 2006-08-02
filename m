MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17616.40345.790956.858472@domain.hid>
Date: Wed, 2 Aug 2006 14:42:01 +0200
Subject: Re: AW: [Xenomai-help] Convert Linux PosixThreads to Xenomai
	PosixThreads
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A46D7CF@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A46D7CF@ARVMAIL1.mra.roland-man.biz>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > Gilles Chanteperdrix :
 > >> But when I start my application I still get just Linux threads and =
no Xenomai=20
 > >> shadow tasks are created. Can anybody give me a hint how I can cont=
roll what
 > >> kind of thread is created ?>=20
 >=20
 > > Normally, any thread created with pthread_create has a=20
 > > shadow. Whether they are started in primary mode depends on=20
 > > their scheduling policy.
 > >=20
 >=20
 > I think this was the hint I have been looking for.
 > Now I set some attributes explicitly :
 >    nResult =3D pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SC=
HED);
 >    ASSERT(nResult =3D=3D 0);
 >    nResult =3D pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
 >    ASSERT(nResult =3D=3D 0);
 > (although this should be the default)

The default is SCHED_OTHER, for consistency with Linux native threading
libraries. Note however that even threads created with the SCHED_OTHER
policy are shadowed.

 >=20
 > But when I create a thread with=20
 >  nResult =3D pthread_create(&tid, &attr, (void *) & body, pTask);
 > pthread_create returns with 4=3DInterrupted system call. Unfortunatell=
y this return value is not documented. Can you tell me what it means ?=20

Even worse, if you read the specification, you will see that
pthread_create should never return EINTR. A value of EINTR means that a
suspending call was interrupted by a signal. It may happen if you are
explicitely using signals, or alternatively when running under gdb,
because gdb itself uses signals.

 >=20
 > >=20
 > > Could you try reducing your problem to a program as simple as=20
 > > possible, and send us the sources of this program ?=20
 >=20
 > I=B4ll try this when I am not succesfull in starting threads with the =
changed attributes (see above).
 >=20
 > > How do=20
 > > you know that no shadow threads are created ?
 > >=20
 >=20
 > I had a look in /proc/xenomai/sched and couldn=B4t see any Xenomai-tas=
k. Isn=B4t this the usual way ?

Yes it is the usual way. The "main" thread is automatically shadowed
when the application is started, so, you should see at least one shadow.

--=20


					    Gilles Chanteperdrix.

