Date: Thu, 18 Dec 2014 17:41:26 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <1193017267.99526.1418920886509.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <530357014.99522.1418920882907.JavaMail.zimbra@wandercraft.eu>
References: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
 <20141218140529.GM2012@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Differents switch mode from differents Xenomai skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


----- Mail original -----
> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> Cc: xenomai@xenomai.org
> Envoy=C3=A9: Jeudi 18 D=C3=A9cembre 2014 15:05:29
> Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin

> On Thu, Dec 18, 2014 at 12:30:40PM +0100, Huy Cong Vu wrote:
>> Hello everyone, I recently ran a comparison test between Xemai
>> native & posix skin, the goal is to see if its possible of using a
>> full standard posix program instead of inserting some native
>> functions. I'm not familiar with the Xenomai Posix skin so I may
>> lack a lot of things, if you can give me some hints, I would be
>> very grateful. Test run in xenomai 2.6.3 patched in linux 3.8.13.
>=20
> You should be using xenomai latest version, which is 2.6.4, not an
> older version, especially if you have not yet chosen a particular version
>=20
>> My program only have 1 task who use the soem library (which use rtdm) to=
 send a
>> message broadcast in order to detect EtherCAT slave through a real-time =
port
>> RTNet.
>> I have 2 test files which use native & posix skin respectively. Here som=
e cuts
>> of the main() function:
>> Native:
>> mlockall(MCL_CURRENT | MCL_FUTURE);
>> rt_print_auto_init(1);
>> rt_task_spawn(&rt_task_desc_1,NULL,0,98,T_JOINABLE|T_WARNSW,&mini,NULL);
>> rt_task_join(&rt_task_desc_1);
>> rt_task_delete(&rt_task_desc_1);
>> Posix:
>> mlockall(MCL_CURRENT | MCL_FUTURE);
>> pthread_attr_init(&p_attr1);
>> pthread_attr_setschedpolicy(&p_attr1,SCHED_FIFO);
>> pthread_attr_setdetachstate(&p_attr1, PTHREAD_CREATE_JOINABLE);
>> param.sched_priority =3D 98;
>> pthread_attr_setschedparam(&p_attr1, &param);
>> pthread_create( &thread1, &p_attr1, (void *) &mini, NULL);
>> pthread_join(thread1, 0);
>> pthread_exit(&thread1);
>> pthread_attr_destroy(&p_attr1);
>>=20
>> in mini(): pthread_set_mode_np(0,PTHREAD_PRIMARY|PTHREAD_WARNSW);
>=20
> You do not need PTHREAD_PRIMARY, a xenomai thread will always start
> in primary mode, and anyway the switch to primary or secondary mode
> will  happen as needed.
>=20
>>=20
>> in which mini() is my task.
>>=20
>> I activated WARNSW bit to detect spurious relaxes, according to this:
>> http://xenomai.org/2014/06/finding-spurious-relaxes/
>>=20
>> The mode switch occurs at socket level, but in differents ways:
>> With native:
>> Mode switch (reason invoked syscall), aborting. Backtrace:
>> ./testcase_native[0x40152f]
>> /lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7eff44375cb0]
>> /usr/xenomai/lib/librtdm.so.1(rt_dev_socket+0x1d)[0x7eff43d5480d
>=20
> rt_dev_socket may cause a switch to secondary mode, yes, this is
> perfectly normal, only sending and receiving data is guaranteed to
> not cause a switch to secondary mode.
>=20
>>=20
>> With posix:
>> Critical errors: Mode switch (reason latency:received SIXCPU for unknown
>> reason), aborting. Backtrace:
>=20
> Unknown reason is suspicious, if you have used the sigdebug example,
> you should not that there is now an additional reason for receiving
> SIGXCPU.
>=20

You are right, the error I got is error 7, i.e SIGDEBUG_RESCNT_IMBALANCE, k=
nowing that I don't use a mutex in my app, so maybe it's still an unknown i=
ssue?

>> ./testcase_posix[0x401570]
>> /lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7f40ddb7acb0]
>> /usr/xenomai/lib/librtdm.so.1(rt_dev_sendmsg+0x16)[0x7f40dd5598f6]
>>=20
>> These 2 programs use the same functions call, compiled with same
>> flags (rtdm, native & posix mixed):
>=20
> Most likely, rt_dev_sendmsg is passed a non real-time socket. You
> can use either native or posix services to create and handle
> sockets, but you can not mix the call. It meansa socket created with
> rt_dev_socket (the native service) should be passed to
> rt_dev_sendmsg, whereas socket created with the posix service
> (socket) can only be passed to posix services (sendmsg). Is not it
> what is happening here?
>=20

So, does that means that my test in posix skin should not calls rt_dev_send=
msg?=20


>> The only different is the portion I mentioned above.
>=20
> Compiling for the xenomai skin causes changes in the services called
> even without changing the code. So, for instance, if you use the
> "socket" service, when compiling for the native skin, it will create
> a plain linux socket, whereas when compiled for the posix skin, it
> will try and create an RTDM socket.
>=20

Even after removing native c & ld flags, it keeps calling this native funct=
ion, which is a strange behavior, no?

> To help you more, we would need more details, such as for instance a
> reduced, self-contained test case allowing us to reproduce the issue
> you observe.
>=20

I'm working on that one, will post it asap. Thanks for your help.

> --
> =09=09=09=09=09    Gilles.

--=20
Huy Cong
Wandercraft SAS

