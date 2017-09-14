MIME-Version: 1.0
References: <CAB6vvjke_16vivYH6+6QJiDR__5zcUBihvAe5+0S+CVKt1Qx8g@mail.gmail.com>
 <cda6fe24-2a17-03af-b6b0-58b63dc82a82@xenomai.org>
In-Reply-To: <cda6fe24-2a17-03af-b6b0-58b63dc82a82@xenomai.org>
From: Antoine Hoarau <hoarau.robotics@gmail.com>
Date: Thu, 14 Sep 2017 16:08:59 +0000
Message-ID: <CAB6vvjno8Ysd6k7fKpEkyfU-S+myKNd517ju0-X0nAOiQPJMPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Can't wait on conditions on 3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le jeu. 14 sept. 2017 =C3=A0 16:30, Philippe Gerum <rpm@xenomai.org> a =C3=
=A9crit :

> On 09/14/2017 02:03 PM, Antoine Hoarau wrote:
> > Hello,
> > I'm porting a library that uses Xenomai 2.6.5 native to 3.0.5 alchemy o=
n
> an
> > x64 Ubuntu 16.04 + Cobalt kernel 4.9.38.
> >
> > I'm stuck on conditions that do not wait signals to be emitted :
> >
> > int ret =3D rt_cond_wait_until(cond, mutex, rt_timer_ns2ticks(abs_time)=
 )
> > returns -ETIMEDOUT immediately.
> >
> >>From the documentation : -ETIMEDOUT is returned if abs_timeout is reach=
ed
> > before the condition variable is signaled. But I verified that
> > rt_timer_ns2ticks(abs_time)  > rt_timer_read(), so it should wait.
> >
>
> You may want to check your calling args, e.g. wait for a second before
> timeout:
>
>         ret =3D rt_cond_wait_until(&cond, &mutex, rt_timer_read() +
> 1000000000ULL);
>         if (ret)
>                 error(1, -ret, "rt_cond_wait_until");
>
> Same. It returns directly with -ETIMEDOUT.


> > This lead me to beleive that something was wrong with the mutex.
> >
>
> I'm unsure to understand why.
>
> If I look at the code, the return value can be the return of the mutex if
something is wrong :
https://git.xenomai.org/xenomai-3.git/tree/lib/alchemy/cond.c#n382



> > 1) Can rt_cond_wait return -ETIMEDOUT with the mutex ?
> > 2)  How would you implement a trylock() on a mutex ?
> >
> >         struct RT_MUTEX_INFO info;
> >         rt_mutex_inquire(mutex, &info );
> >         RT_TASK no_task =3D NO_ALCHEMY_TASK;
> >         rt_task_same(&info.owner,&no_task) =3D=3D 0 -> not locked !
> >           --> rt_mutex_acquire(mutex,TM_NONBLOCK)
>
> rt_mutex_acquire(mutex,TM_NONBLOCK) does mean trylock(), you don't need
> further checks. Besides, the code above would be racy.
>
> --
> Philippe.
>
--=20
Antoine Hoarau
Robotics Engineer
