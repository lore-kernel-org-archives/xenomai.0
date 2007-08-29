Message-ID: <46D57EC8.3090504@domain.hid>
Date: Wed, 29 Aug 2007 16:12:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>	
	<46BC8074.3090104@domain.hid>	
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>	
	<18112.1512.506911.608273@domain.hid>	
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>	
	<46C08E61.9060204@domain.hid>	
	<3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>	
	<3535aae80708270627l4064dd1fif3e6aa10314d38f@domain.hid>	
	<46D301EE.5020805@domain.hid> <46D50DFC.5080304@domain.hid>
	<3535aae80708290640x37ea29f1y17dc34a2823fed11@domain.hid>
In-Reply-To: <3535aae80708290640x37ea29f1y17dc34a2823fed11@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF92C8E690614EB518A10A26F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: andy motten <andy.motten@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF92C8E690614EB518A10A26F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

andy motten wrote:
>> Jan Kiszka wrote:
>> Index: xenomai-2.3.x/ChangeLog
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- xenomai-2.3.x/ChangeLog     (Revision 2954)
>> +++ xenomai-2.3.x/ChangeLog     (Arbeitskopie)
>> @@ -1,3 +1,8 @@
>> +2007-08-29  Jan Kiszka  <jan.kiszka@domain.hid>
>> +
>> +       * ksrc/nucleus/shadow.c: Postpone module_put() to the lo-stage=

>> +       APC handler (back-ported from 2.4).
>> +
>> 2007-08-24  Wolfgang Grandegger  <wg@domain.hid>
>>
>>         * ksrc/drivers/can/rtcan_socket.c: protect the list of RTCAN
>> Index: xenomai-2.3.x/ksrc/nucleus/shadow.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- xenomai-2.3.x/ksrc/nucleus/shadow.c (Revision 2954)
>> +++ xenomai-2.3.x/ksrc/nucleus/shadow.c (Arbeitskopie)
>> @@ -99,6 +99,7 @@ static struct __lostagerq {
>> #define LO_RENICE_REQ 2
>> #define LO_SIGGRP_REQ 3
>> #define LO_SIGTHR_REQ 4
>> +#define LO_UNMAP_REQ  5
>>                 int type;
>>                 struct task_struct *task;
>>                 int arg;
>> @@ -753,6 +754,28 @@ void xnshadow_reset_shield(void)
>>
>> #endif /* CONFIG_XENO_OPT_ISHIELD */
>>
>> +static void xnshadow_dereference_skin(unsigned magic)
>> +{
>> +       unsigned muxid;
>> +
>> +       for (muxid =3D 0; muxid < XENOMAI_MUX_NR; muxid++) {
>> +               if (muxtable[muxid].magic =3D=3D magic) {
>> +                       if
>> (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
>> +                               xnarch_atomic_dec(&muxtable[0].refcnt)=
;
>> +                       if
>> (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
>> +
>> +                               /* We were the last thread, decrement =
the
>> counter,
>> +                                  since it was incremented by the
>> xn_sys_bind
>> +                                  operation. */
>> +
>> xnarch_atomic_dec(&muxtable[muxid].refcnt);
>> +                       if (muxtable[muxid].module)
>> +                               module_put(muxtable[muxid].module);
>> +
>> +                       break;
>> +               }
>> +       }
>> +}
>> +
>> static void lostage_handler(void *cookie)
>> {
>>         int cpuid =3D smp_processor_id(), reqnum, sig;
>> @@ -777,6 +800,12 @@ static void lostage_handler(void *cookie
>>
>>                         goto do_wakeup;
>>
>> +               case LO_UNMAP_REQ:
>> +
>> +                       xnshadow_dereference_skin(
>> +                               (unsigned)rq->req[reqnum].arg);
>> +
>> +               /* fall through */
>>                 case LO_WAKEUP_REQ:
>>
>>                         /* We need to downgrade the root thread
>> @@ -1256,7 +1285,6 @@ int xnshadow_map(xnthread_t *thread, xnc
>> void xnshadow_unmap(xnthread_t *thread)
>> {
>>         struct task_struct *p;
>> -       unsigned muxid, magic;
>>
>>         if (XENO_DEBUG(NUCLEUS) &&
>>             !testbits(xnpod_current_sched()->status, XNKCOUT))
>> @@ -1264,25 +1292,6 @@ void xnshadow_unmap(xnthread_t *thread)
>>
>>         p =3D xnthread_archtcb(thread)->user_task;
>>
>> -       magic =3D xnthread_get_magic(thread);
>> -
>> -       for (muxid =3D 0; muxid < XENOMAI_MUX_NR; muxid++) {
>> -               if (muxtable[muxid].magic =3D=3D magic) {
>> -                       if
>> (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
>> -                               xnarch_atomic_dec(&muxtable[0].refcnt)=
;
>> -                       if
>> (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
>> -
>> -                               /* We were the last thread, decrement =
the
>> counter,
>> -                                  since it was incremented by the
>> xn_sys_bind
>> -                                  operation. */
>> -
>> xnarch_atomic_dec(&muxtable[muxid].refcnt);
>> -                       if (muxtable[muxid].module)
>> -                               module_put(muxtable[muxid].module);
>> -
>> -                       break;
>> -               }
>> -       }
>> -
>>         xnthread_clear_state(thread, XNMAPPED);
>>         rpi_pop(thread);
>>
>> @@ -1298,13 +1307,7 @@ void xnshadow_unmap(xnthread_t *thread)
>>
>>         xnshadow_thrptd(p) =3D NULL;
>>
>> -       if (p->state !=3D TASK_RUNNING)
>> -               /* If the shadow is being unmapped in primary mode or
>> blocked
>> -                  in secondary mode, the associated Linux task should=

>> also
>> -                  die. In the former case, the zombie Linux side
>> returning to
>> -                  user-space will be trapped and exited inside the po=
d's
>> -                  rescheduling routines. */
>> -               schedule_linux_call(LO_WAKEUP_REQ, p, 0);
>> +       schedule_linux_call(LO_UNMAP_REQ, p, xnthread_get_magic(thread=
));
>> }
>>
>> int xnshadow_wait_barrier(struct pt_regs *regs)
>> @@ -2010,6 +2013,7 @@ RTHAL_DECLARE_EVENT(losyscall_event);
>> static inline void do_taskexit_event(struct task_struct *p)
>> {
>>         xnthread_t *thread =3D xnshadow_thread(p); /* p =3D=3D current=
 */
>> +       unsigned magic;
>>         spl_t s;
>>
>>         if (!thread)
>> @@ -2018,6 +2022,8 @@ static inline void do_taskexit_event(str
>>         if (xnpod_shadow_p())
>>                 xnshadow_relax(0);
>>
>> +       magic =3D xnthread_get_magic(thread);
>> +
>>         xnlock_get_irqsave(&nklock, s);
>>         /* Prevent wakeup call from xnshadow_unmap(). */
>>         xnshadow_thrptd(p) =3D NULL;
>> @@ -2028,6 +2034,7 @@ static inline void do_taskexit_event(str
>>         xnlock_put_irqrestore(&nklock, s);
>>         xnpod_schedule();
>>
>> +       xnshadow_dereference_skin(magic);
>>         xnltt_log_event(xeno_ev_shadowexit, thread->name);
>> }
>=20
>=20
> This  patch is working with linux kernel 2.6.20.9 and ipipe 1.8-08.

Means the OROCOS test now runs fine against Xenomai 2.3.x at least?

Philippe, can we merge the patch?

Jan


--------------enigF92C8E690614EB518A10A26F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1X7IniDOoMHTA+kRAsdqAJ9c2A1vv+zb74Id5QJgIFmDT3ioRQCfUSFI
ZZ2pSheCh+Z+tW4xBcXLsxI=
=pHLQ
-----END PGP SIGNATURE-----

--------------enigF92C8E690614EB518A10A26F--

