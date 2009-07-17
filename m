Date: Fri, 17 Jul 2009 13:17:50 +0200
From: Petr Cervenka <grugh@domain.hid>
References: <1247750127.306081.22356.nullmailer@domain.hid>
	<1247754601.4228.73.camel@domain.hid>
In-Reply-To: <1247754601.4228.73.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1247829470.829653.30773.nullmailer@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_task_shadow returns always -EFAULT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>


>On Thu, 2009-07-16 at 15:15 +0200, Petr Cervenka wrote:
>> Hello,
>> the xenomai native function rt_task_shadow(...) always returns -EFAULT=
 for me. Only happens in xenomai-2.5-rc2.
>>=20
>> Same behaviour was also in 2.5-rc1, see note in my older post:
>> https://mail.gna.org/public/xenomai-help/2009-05/msg00024.html
>>=20
>> Example code, in the end of this post:
>> https://mail.gna.org/public/xenomai-help/2009-05/msg00038.html
>>=20
>> My configuration:
>> Athlon 64 X2 4600+
>> Kubuntu 7.10
>> linux-2.6.29.5 (also tried 2.6.30.1)
>> xenomai-2.5.-rc2
>
>Does this still break when the name is passed as illustrated below?
>

No, it doesn't help.

I also tried the xenomai rtprint example -> same behavior. The rt_task_sh=
adow() returns -EFAULT and any following rt_task_sleep() in that task ret=
urns -1. The other task works fine.
I will do some deeper examination of rt_task_shadow() code.
If you have any advices, what to send or what to try, i would like to hea=
r it.

>--- petr.c~	2009-07-16 15:50:46.000000000 +0200
>+++ petr.c	2009-07-16 16:28:31.000000000 +0200
>@@ -14,11 +14,12 @@
>     RT_EVENT event;
>     unsigned long mask;
>     RTIME start, end;
>+    char name[32];
>     int res;
>=20
>     mlockall(MCL_CURRENT | MCL_FUTURE);
>=20
>-    res =3D rt_task_shadow(&mainTask, "main_task", MY_PRIORITY, 0);
>+    res =3D rt_task_shadow(&mainTask, strcpy(name, "main_task"), MY_PRI=
ORITY, 0);
>     if (res < 0) {
>         printf("rt_task_shadow(): %d (%s)n", res, strerror(-res));
>     }
>
>>=20
>> Best regards
>>=20
>> Petr Cervenka
>>=20
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>--=20
>Philippe.
>
>
Petr

