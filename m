Date: Fri, 17 Jul 2009 17:51:49 +0200
From: Petr Cervenka <grugh@domain.hid>
References: <1247750127.306081.22356.nullmailer@domain.hid>	
	<1247754601.4228.73.camel@domain.hid>	
	<1247829470.829653.30773.nullmailer@domain.hid>	
	<1247832340.4228.132.camel@domain.hid>	
	<1247837534.904271.19070.nullmailer@domain.hid>
	<1247838733.4228.139.camel@domain.hid>
In-Reply-To: <1247838733.4228.139.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1247845909.586479.22758.nullmailer@domain.hid>
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


>> >
>> >Try instrumenting ksrc/skins/native/syscall.c, __rt_task_create(), to
>> >identify which spot returns -EFAULT. I can't reproduce this issue on =
a
>> >ppc target; I may try over x86 later, but this would speed up things =
if
>> >you could spot the failing test before I'm able to switch to this.
>> >
>>=20
>> Meanwhile I tried to mess little bit with rt_task_shadow() function to=
 see, where is the source of -EFAULT. I planned to continue to follow it =
inside syscall etc.
>> But most attempts to confirm, that the value is returned by line:
>> 	err =3D XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk=
,
>> 				NULL);
>
>This branches to __rt_task_create in kernel space.
>

The bulk variable is totally wrong in kernel space:
for example (2, 0, 0, 0, 0, 134217728), perhaps always same values. Value=
 2 could be number of arguments of the skincall.
It fails on following line (syscall.c:aprox. 193):
	if (__xn_safe_copy_to_user((void __user *)bulk.a1, &ph, sizeof(ph))) {

>> where suprisingly followed by correct behavior. For example following =
(nothing doing) change in the attached patch solves the whole thing:
>> --- /usr/src/xenomai/src/skins/native/task2.c   2009-04-13 19:20:18.00=
0000000 +0200
>> +++ /usr/src/xenomai/src/skins/native/task.c    2009-07-17 15:06:20.00=
0000000 +0200
>> @@ -241,6 +241,7 @@
>>         pthread_setspecific(__native_tskey, NULL);
>>         free(self);
>>  #endif /* !HAVE___THREAD */
>> +       rt_task_set_mode(0, 0, NULL);
>>         return err;
>>  }
>>=20
>> objdumps of original and changed rt_task_shadow() is in attachment
>>=20
>> I will continue in research, but I'm really not good in dissasembling =
nor the register knowledge.
>>=20
>
>Try rebuilding the user-space libs passing --without-__thread to the
>configure script.
>

After rebuilding with "./configure --enable-smp --without-__thread" it wo=
rks without any problems.
Do you already know, where the problem is? What does the "--without-__thr=
ead" argument mean?

Petr

