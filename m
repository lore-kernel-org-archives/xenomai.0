Date: Thu, 14 Apr 2022 17:13:41 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1588685029.254441.1649949221432.JavaMail.zimbra@nod.at>
In-Reply-To: <7d2e38dc-7386-e703-2e09-572874c5e162@siemens.com>
References: <20220413215819.22954-1-richard@nod.at>
 <7d2e38dc-7386-e703-2e09-572874c5e162@siemens.com>
Subject: Re: [PATCH v2 0/9] Revive alchemy, pSOS and VxWorks tests
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>   task5 fails:
>> =09[9] at task-5.c:79
>> =09[1] at task-5.c:23
>> =09[10] at task-5.c:87
>> =09[3] at task-5.c:40
>> =09[11] at task-5.c:95
>> =09[4] at task-5.c:45
>> =09[5] at task-5.c:50
>> =09[6] at task-5.c:55
>> =09[2] at task-5.c:28
>> =09[7] at task-5.c:60
>> =09   0"003.160| BUG in __traceobj_check_abort(): [FGND] wrong return st=
atus:
>> =09=09      task-5.c:63 =3D> EINVAL (want OK)


This failure is a little trickier.

Line 62 is:
ret =3D rt_task_set_priority(&t_bgnd, info.prio + 1);
ret is EINVAL, that's why the assert in line 63 fails.
It fails because t_bgnd has already terminated.

This concurs also with the above marker [2].
[2] is reached when t_bgnd is done.

The foreground task does:
        ret =3D rt_task_inquire(NULL, &info);
        traceobj_assert(&trobj, ret =3D=3D 0 && info.prio =3D=3D 21);

        traceobj_mark(&trobj, 6);

        ret =3D rt_task_set_priority(&t_bgnd, info.prio);
        traceobj_check(&trobj, ret, 0);

        traceobj_mark(&trobj, 7);

        ret =3D rt_task_set_priority(&t_bgnd, info.prio + 1);
        traceobj_check(&trobj, ret, 0);

        traceobj_mark(&trobj, 8);

So it asks for it's own priority, it must be 21, that's okay.
Then it raises the priority of t_bgnd from 20 to 21
and assumes that no scheduling happens. But this seems to fail.

Did the nucleus CPU scheduler guarantee that giving another task
the same priority of the calling task will favour the caller?
Now the gifted task seems to win.

Thanks,
//richard

