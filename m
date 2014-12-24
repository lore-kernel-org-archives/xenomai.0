Date: Wed, 24 Dec 2014 10:30:18 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <2022750954.117025.1419413418676.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <1579728558.117024.1419413400904.JavaMail.zimbra@wandercraft.eu>
References: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
 <20141219103133.GY2012@hermes.click-hack.org>
 <1185690365.115833.1419351787951.JavaMail.zimbra@wandercraft.eu>
 <20141223163535.GA1537@daedalus>
 <677186930.116031.1419353021115.JavaMail.zimbra@wandercraft.eu>
 <20141223164659.GB1537@daedalus>
 <1238414447.116297.1419353922775.JavaMail.zimbra@wandercraft.eu>
 <20141224002912.GC1537@daedalus>
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
> Envoy=C3=A9: Mercredi 24 D=C3=A9cembre 2014 01:29:12
> Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin

> On Tue, Dec 23, 2014 at 05:58:42PM +0100, Huy Cong Vu wrote:
>>=20
>>=20
>> ----- Mail original -----
>> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>> > =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> > Cc: xenomai@xenomai.org
>> > Envoy=C3=A9: Mardi 23 D=C3=A9cembre 2014 17:46:59
>> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai sk=
in
>>=20
>> > On Tue, Dec 23, 2014 at 05:43:41PM +0100, Huy Cong Vu wrote:
>> >>=20
>> >>=20
>> >> ----- Mail original -----
>> >> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>> >> > =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> >> > Cc: xenomai@xenomai.org
>> >> > Envoy=C3=A9: Mardi 23 D=C3=A9cembre 2014 17:35:35
>> >> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai=
 skin
>> >>=20
>> >> > On Tue, Dec 23, 2014 at 05:23:07PM +0100, Huy Cong Vu wrote:
>> >> >> void mini( void *ptr )
>> >> >> {
>> >> >>=20
>> >> >>=20
>> >> >> =09uint8_t b;
>> >> >> =09int ret1;
>> >> >> =09int idx;
>> >> >>=20
>> >> >> =09pthread_set_mode_np(0, PTHREAD_WARNSW);
>> >> >>    printf("Starting posix test\n");
>> >> >>=20
>> >> >> =09ec_port =3D malloc(sizeof(ecx_portt*));
>> >> >>=20
>> >> >> =09if (setup_nic(ec_port,"rteth0") > 0) {
>> >> >> =09=09   idx =3D getindex (ec_port);
>> >> >>    =09=09/* setup datagram */
>> >> >> =09=09=09b =3D 0x0000;
>> >> >>    =09=09setupdatagram (ec_port, &(ec_port->txbuf[idx]),0x0009, id=
x, 0x0000, 0x0103,
>> >> >>    =09=09sizeof(b), &b );
>> >> >>    =09=09/* send data and wait for answer */
>> >> >>    =09=09wkc =3D srconfirm (ec_port, idx, EC_TIMEOUTRET3);
>> >> >> =09}
>> >> >> =09
>> >> >> }
>> >> >=20
>> >> > Typically, as I already explained, what you do here is wrong: you
>> >> > should not arm the PTHREAD_WARNSW bit before call such as malloc or
>> >> > the calls in setup_nic, which switch to secondary mode.
>> >>=20
>> >> Ok, should I call it laterly? It is just for detect mode switch
>> >> reason in fact
>> >=20
>> > How to use PTHREAD_WARNSW is thoroughly documented, see:
>> > https://xenomai.org/2014/06/finding-spurious-relaxes/
>> >=20
>>=20
>> So perhaps I was misunderstanding this statement?
>> Then, you need to enable the warn_upon_switch capability on a per-thread=
 basis.
>> For instance, a POSIX-based application would run this code from the thr=
ead to
>> monitor for spurious relaxes:
>>=20
>>     /* Ask Xenomai to warn us upon switches to secondary mode. */
>>     pthread_set_mode_np(0, PTHREAD_WARNSW);
>>=20
>> Does that means that I must put the line into the thread with function c=
alls
>> that cause mode switch?
>> I thought it means that I have to put the line in the threads of my prog=
ram (in
>> my case mini() ).
>=20
> Enabling this bit, causes every switch to secondary mode of the
> thread where you enabled it to send a signal to that thread. I do
> not understand what is so hard to understand about this.

Ok, so I guess I didn't understand this wrongly at least. =20

Suppose that I remove PTHREAD_WARNSW bit, here what I got in output:=20
SOEM (Simple Open EtherCAT Master)
Simple test
Starting posix test
Mode switch (reason bad functions call while holding mutex, or other unknow=
n issue), aborting. Backtrace:
./posix_minimal[0x401bf6]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7f94ef972cb0]
/usr/xenomai/lib/libpthread_rt.so.1(__wrap_send+0xd5)[0x7f94efd8f9f5]
./posix_minimal[0x4017dc]
./posix_minimal[0x4016ed]
./posix_minimal[0x4011cd]
/usr/xenomai/lib/libpthread_rt.so.1(+0x5b45)[0x7f94efd8cb45]
/lib/x86_64-linux-gnu/libpthread.so.0(+0x7e9a)[0x7f94ef96ae9a]
/lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)[0x7f94ef28d3fd]
Temps UCT limite expir=C3=A9 (core dumped)

It is the same output as when PTHREAD_WARNSW is active. Could you give me s=
ome hints why?

>=20
> --
> =09=09=09=09=09    Gilles.

--=20
Huy Cong
Wandercraft SAS

