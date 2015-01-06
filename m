Date: Tue, 6 Jan 2015 10:34:17 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <1497603305.136357.1420536857972.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <406329870.136348.1420536332444.JavaMail.zimbra@wandercraft.eu>
References: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
 <20141224002912.GC1537@daedalus>
 <2022750954.117025.1419413418676.JavaMail.zimbra@wandercraft.eu>
 <20141224144928.GA2945@daedalus>
 <1544959523.130965.1420453839375.JavaMail.zimbra@wandercraft.eu>
 <20150105165813.GA8043@hermes.click-hack.org>
 <642019253.136329.1420535370881.JavaMail.zimbra@wandercraft.eu>
 <20150106091658.GA11206@hermes.click-hack.org>
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
> Envoy=C3=A9: Mardi 6 Janvier 2015 10:16:58
> Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin

> On Tue, Jan 06, 2015 at 10:09:30AM +0100, Huy Cong Vu wrote:
>>=20
>>=20
>> ----- Mail original -----
>> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>> > =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> > Cc: xenomai@xenomai.org
>> > Envoy=C3=A9: Lundi 5 Janvier 2015 17:58:13
>> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai sk=
in
>>=20
>> > On Mon, Jan 05, 2015 at 11:30:39AM +0100, Huy Cong Vu wrote:
>> >>=20
>> >>=20
>> >> ----- Mail original -----
>> >> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>> >> > =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> >> > Cc: xenomai@xenomai.org
>> >> > Envoy=C3=A9: Mercredi 24 D=C3=A9cembre 2014 15:49:28
>> >> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai=
 skin
>> >>=20
>> >> > On Wed, Dec 24, 2014 at 10:30:18AM +0100, Huy Cong Vu wrote:
>> >> >>=20
>> >> >>=20
>> >> >> ----- Mail original -----
>> >> >> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>> >> >> > =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> >> >> > Cc: xenomai@xenomai.org
>> >> >> > Envoy=C3=A9: Mercredi 24 D=C3=A9cembre 2014 01:29:12
>> >> >> > Objet: Re: [Xenomai] Differents switch mode from differents Xeno=
mai skin
>> >> >>=20
>> >> >> > On Tue, Dec 23, 2014 at 05:58:42PM +0100, Huy Cong Vu wrote:
>> >> >> >>=20
>> >> >> >>=20
>> >> >> >> ----- Mail original -----
>> >> >> >> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>> >> >> >> > =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> >> >> >> > Cc: xenomai@xenomai.org
>> >> >> >> > Envoy=C3=A9: Mardi 23 D=C3=A9cembre 2014 17:46:59
>> >> >> >> > Objet: Re: [Xenomai] Differents switch mode from differents X=
enomai skin
>> >> >> >>=20
>> >> >> >> > On Tue, Dec 23, 2014 at 05:43:41PM +0100, Huy Cong Vu wrote:
>> >> >> >> >>=20
>> >> >> >> >>=20
>> >> >> >> >> ----- Mail original -----
>> >> >> >> >> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.o=
rg>
>> >> >> >> >> > =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> >> >> >> >> > Cc: xenomai@xenomai.org
>> >> >> >> >> > Envoy=C3=A9: Mardi 23 D=C3=A9cembre 2014 17:35:35
>> >> >> >> >> > Objet: Re: [Xenomai] Differents switch mode from different=
s Xenomai skin
>> >> >> >> >>=20
>> >> >> >> >> > On Tue, Dec 23, 2014 at 05:23:07PM +0100, Huy Cong Vu wrot=
e:
>> >> >> >> >> >> void mini( void *ptr )
>> >> >> >> >> >> {
>> >> >> >> >> >>=20
>> >> >> >> >> >>=20
>> >> >> >> >> >> =09uint8_t b;
>> >> >> >> >> >> =09int ret1;
>> >> >> >> >> >> =09int idx;
>> >> >> >> >> >>=20
>> >> >> >> >> >> =09pthread_set_mode_np(0, PTHREAD_WARNSW);
>> >> >> >> >> >>    printf("Starting posix test\n");
>> >> >> >> >> >>=20
>> >> >> >> >> >> =09ec_port =3D malloc(sizeof(ecx_portt*));
>> >> >> >> >> >>=20
>> >> >> >> >> >> =09if (setup_nic(ec_port,"rteth0") > 0) {
>> >> >> >> >> >> =09=09   idx =3D getindex (ec_port);
>> >> >> >> >> >>    =09=09/* setup datagram */
>> >> >> >> >> >> =09=09=09b =3D 0x0000;
>> >> >> >> >> >>    =09=09setupdatagram (ec_port, &(ec_port->txbuf[idx]),0=
x0009, idx, 0x0000, 0x0103,
>> >> >> >> >> >>    =09=09sizeof(b), &b );
>> >> >> >> >> >>    =09=09/* send data and wait for answer */
>> >> >> >> >> >>    =09=09wkc =3D srconfirm (ec_port, idx, EC_TIMEOUTRET3)=
;
>> >> >> >> >> >> =09}
>> >> >> >> >> >> =09
>> >> >> >> >> >> }
>> >> >> >> >> >=20
>> >> >> >> >> > Typically, as I already explained, what you do here is wro=
ng: you
>> >> >> >> >> > should not arm the PTHREAD_WARNSW bit before call such as =
malloc or
>> >> >> >> >> > the calls in setup_nic, which switch to secondary mode.
>> >> >> >> >>=20
>> >> >> >> >> Ok, should I call it laterly? It is just for detect mode swi=
tch
>> >> >> >> >> reason in fact
>> >> >> >> >=20
>> >> >> >> > How to use PTHREAD_WARNSW is thoroughly documented, see:
>> >> >> >> > https://xenomai.org/2014/06/finding-spurious-relaxes/
>> >> >> >> >=20
>> >> >> >>=20
>> >> >> >> So perhaps I was misunderstanding this statement?
>> >> >> >> Then, you need to enable the warn_upon_switch capability on a p=
er-thread basis.
>> >> >> >> For instance, a POSIX-based application would run this code fro=
m the thread to
>> >> >> >> monitor for spurious relaxes:
>> >> >> >>=20
>> >> >> >>     /* Ask Xenomai to warn us upon switches to secondary mode. =
*/
>> >> >> >>     pthread_set_mode_np(0, PTHREAD_WARNSW);
>> >> >> >>=20
>> >> >> >> Does that means that I must put the line into the thread with f=
unction calls
>> >> >> >> that cause mode switch?
>> >> >> >> I thought it means that I have to put the line in the threads o=
f my program (in
>> >> >> >> my case mini() ).
>> >> >> >=20
>> >> >> > Enabling this bit, causes every switch to secondary mode of the
>> >> >> > thread where you enabled it to send a signal to that thread. I d=
o
>> >> >> > not understand what is so hard to understand about this.
>> >> >>=20
>> >> >> Ok, so I guess I didn't understand this wrongly at least.
>> >> >>=20
>> >> >> Suppose that I remove PTHREAD_WARNSW bit, here what I got in outpu=
t:
>> >> >> SOEM (Simple Open EtherCAT Master)
>> >> >> Simple test
>> >> >> Starting posix test
>> >> >> Mode switch (reason bad functions call while holding mutex, or oth=
er unknown
>> >> >> issue), aborting. Backtrace:
>> >> >> ./posix_minimal[0x401bf6]
>> >> >> /lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7f94ef972cb0]
>> >> >> /usr/xenomai/lib/libpthread_rt.so.1(__wrap_send+0xd5)[0x7f94efd8f9=
f5]
>> >> >> ./posix_minimal[0x4017dc]
>> >> >> ./posix_minimal[0x4016ed]
>> >> >> ./posix_minimal[0x4011cd]
>> >> >> /usr/xenomai/lib/libpthread_rt.so.1(+0x5b45)[0x7f94efd8cb45]
>> >> >> /lib/x86_64-linux-gnu/libpthread.so.0(+0x7e9a)[0x7f94ef96ae9a]
>> >> >> /lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)[0x7f94ef28d3fd]
>> >> >> Temps UCT limite expir=C3=A9 (core dumped)
>> >> >>=20
>> >> >> It is the same output as when PTHREAD_WARNSW is active. Could you =
give me some
>> >> >> hints why?
>> >> >=20
>> >> > I already gave you some hints. I need to run the test code you sent=
.
>> >> > But the test code you sent is wrong in the place where it enables
>> >> > the PTHREAD_WARNSW bit.
>> >>=20
>> >> The output of:
>> >>  void mini( void *ptr )
>> >>  {
>> >> =20
>> >>  =09uint8_t b;
>> >>  =09int ret1;
>> >>  =09int idx;
>> >>=20
>> >>         printf("Starting posix test\n");
>> >> =20
>> >>  =09ec_port =3D malloc(sizeof(ecx_portt*));
>> >> =20
>> >>  =09if (setup_nic(ec_port,"rteth0") > 0) {
>> >>  =09=09   idx =3D getindex (ec_port);
>> >>      =09=09   /* setup datagram */
>> >>          =09   b =3D 0x0000;
>> >>     =09           setupdatagram (ec_port, &(ec_port->txbuf[idx]),0x00=
09, idx, 0x0000, 0x0103,
>> >>     =09           sizeof(b), &b );
>> >>                    /* send data and wait for answer */
>> >>                    pthread_set_mode_np(0, PTHREAD_WARNSW);
>> >>                    wkc =3D srconfirm (ec_port, idx, EC_TIMEOUTRET3);
>> >>         }
>> >> }
>> >>=20
>> >> and program without any PTHREAD_WARNSW are the same as the last post =
I gave you.
>> >> So we can conclude that it was not setup_nic or malloc which trigger =
the
>> >> SIGDEBUG handler.
>> >=20
>> > It makes sense for malloc not to cause a SIGDEBUG, because malloc
>> > does not always cause a switch to secondary mode. But for setup_nic
>> > I really have doubts. Are you sure that the thread is not running
>> > with the SCHED_OTHER policy and this is not the cause of both
>> > behaviours (no mode switch on secondary mode operations, because the
>> > thread is running in secondary mode, then switch when calling a
>> > primary mode operation because of the automatic switch back to
>> > secondary mode due to the SCHED_OTHER policy)?
>> >=20
>>=20
>> Hi Gilles,
>>=20
>> With my old minimal test, there were no mode switch for setup_nic with
>> SCHED_OTHER & SCHED_FIFO. The mode switch occurs only at the __wrap_send=
 call
>> (err RESCNT_IMBALANCE)
>>=20
>> But I inserted this line yesterday in main() function to setup p_attr1:
>> pthread_attr_setinheritsched(&p_attr1, PTHREAD_EXPLICIT_SCHED);
>>=20
>> With this, the behavior becomes normal, i.e:
>> with SCHED_FIFO, there are 1 mode switch in setup_nic when calling __wra=
p_socket
>> (which is valid), and after that there are no mode switch anymore.
>=20
> It makes sense.
>=20
>> with SCHED_OTHER, always the same mode switch at __wrap_send.
>=20
> That does not really make sense. If the driver you use uses some
> RTDM spinlock, it is possible that you have the same issue with RTDM
> mutexes as was fixed recently in Xenomai 3:
>=20
> https://git.xenomai.org/xenomai-3.git/commit/?id=3Def0992d6278ccad0af594b=
388f19d6536ececb29
>=20

I'll try out Xenomai 3 to see if this issue still occurs.

>>=20
>> So basiclly, now its worked, but I don't understand why the setinheritsc=
hed call
>> can hold the mode switch in __wrap_send while all others fail?
>=20
> Sorry, I do not understand your question. Without
> PTHREAD_EXPLICIT_SCHED, the newly created thread uses the same
> scheduling policy as the calling thread, which is SCHED_OTHER if you
> do not do anything special (such as running the program with chrt).
>

Ok, I understand now, so my thread used a wrong scheduler in the first plac=
e that leads to wrong behaviors after.=20
Thanks for the explanation!
 =20
> --
> =09=09=09=09=09    Gilles.

--=20
Huy Cong
Wandercraft SAS

