Message-ID: <4BB91622.9020807@domain.hid>
Date: Mon, 05 Apr 2010 00:43:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCDD1848@domain.hid>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCDD1848@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Sharing data between multiple Xenomai tasks in
 the	same process
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sherk Chung <sherk.chung@domain.hid>
Cc: xenomai@xenomai.org

Sherk Chung wrote:
> Hi folks, I have some basic questions regarding having multiple task
> threads running in a Xenomai process.=20
>=20
> =20
>=20
> We would like to have a Xenomai process with multiple threads (tasks). =

> The primary task needs to hard-real-time, the others secondary ones wil=
l
> be using non-real-time drivers so they will be degraded to
> soft-real-time.  In order to share information between all the tasks, w=
e
> are thinking of doing something simple, such as having a global
> structure that all threads can access.  I understand that we=E2=80=99ll=
 need
> mutexes to preserve data integrity, and that the primary task might be
> caught waiting for a lock to release which might cause timing jitter.=20
> But assuming we have that issue under control, are here any other
> Xenomai related issues that we should be aware of that might cause the
> hard-real-time task to degrade to soft-real-time by doing this?
>=20
> =20
>=20
> Some things I=E2=80=99d like to verify:
>=20
> -        It=E2=80=99s generally ok to run multiple Xenomai tasks within=
 a single
> process.
>=20
> -        If one of the secondary tasks is degraded to soft-real-time,
> the degradation will be limited only to that particular secondary task,=

> not to the entire process (so the primary thread will remain hard-real-=
time)
>=20
> -        Having a global structure that all tasks can access is an
> acceptable way to share data across Xenomai tasks (no
> pipes/queues/sharedmem necessary in this scenario)
>=20
> -        There is no risk of the primary task degrading to
> soft-real-time by sharing a global structure with the secondary tasks
> that are degraded to soft-real-time
>=20
> =20
>=20
> I=E2=80=99m guessing there is no issue but just wanted to make sure.

Hi,

It is Ok to protect shared data between a critical task and a non
critical task with a mutex, provided that:
- you enable priority inheritance for the mutex;
- the non critical thread never calls a Linux service while holding the
mutex.

Xenomais is able to detect such situation and to send the faulting
thread a signal in that case: enable CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX
in the configuration, and set, for the critical thread, the T_WARNSW bit
with rt_task_set_mode if using the native API, or the PTHREAD_WARNSW bit
with pthread_set_mode_np if using the POSIX API.

--=20
					    Gilles.


