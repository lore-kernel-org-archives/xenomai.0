Subject: Re: [Xenomai-help] mutex locking
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <216509776@domain.hid>
References: <216509776@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 21 Jun 2006 11:58:53 +0200
Message-Id: <1150883933.7498.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tobias =?ISO-8859-1?Q?B=E4r?= <Tobias.Baer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-06-21 at 11:37 +0200, Tobias B=E4r wrote:
> Hi all,
>=20
> my question is about the right way to lock and inquire a mutex. At time=
, my code looks like this:
>=20
>=20
> rt_mutex_inquire(&mutex,TM_NONBLOCK);
>=20
> if(info.lockcnt =3D=3D 0)=20
> {
>       rt_mutex_lock(&write_mutex,TM_NONBLOCK);
>=20
>       // do sth.
>=20
>       rt_mutex_unlock(&mutex);
> }
>=20
>=20
> What happens if anyone locks the mutex between my "rt_mutex_inquire(...=
)" and my "if(info.lockcnt =3D=3D 0)" ?
>=20
> Is this the standard way to lock and inquire a mutex?

No, this snippet is terminally broken, I'm afraid. The mutex object is
precisely aimed at avoiding this kind of race conditions; the code above
would introduce them back.

Native skin mutexes are recursive by nature, so there is no need to
inquire for their current status. Additionally, passing TM_NONBLOCK
might cause mutex_lock() to return an error, if another thread holds it
already, so you need to check for the return value in any case. What you
likely want is, either:

if (rt_mutex_lock(...TM_INFINITE) < 0)
	bail_out();
/* work in critical section */
rt_mutex_unlock()

or,

if (rt_mutex_lock(...TM_NONBLOCK) < 0)
	resource_not_immediately_available();
/* work in critical section */
rt_mutex_unlock()


>=20
> Thanks,
>   Tobias
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



