MIME-Version: 1.0
In-Reply-To: <4B676938.4070805@domain.hid>
References: <b88603c31001260616wf2194d3t193de281af1318ad@domain.hid>
	<4B675733.3040902@domain.hid> <4B676938.4070805@domain.hid>
Date: Tue, 2 Feb 2010 10:18:28 +0100
Message-ID: <b88603c31002020118n20fd45ddqc723221174a48691@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai 2.5.0: rt_task_shadow fails when
	libnative is statically linked.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I can confirm this works for me too.

But aren't there any reasons to declare those functions with the
'weak' attribute?

On Tue, Feb 2, 2010 at 12:52 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>> Henri Roosen wrote:
>>> Hi all,
>>>
>>> I get segmentation fault when calling rt_task_shadow. Actually
>>> somewhere in the pthread library called from sigshadow_install_once();
>>>
>>> This only happens on Xenomai 2.5 when libnative is statically linked.
>>> Tested ok on 2.4.10 both dynamically and statically linked. I use
>>> kernel version 2.6.30.10, xenomai 2.5.0 on x86.
>>>
>>> Any idea what is wrong?
>>>
>>> Reproduced it with basic app that is attached to this email. Compiled w=
ith:
>>> gcc -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__
>>> -I/usr/xenomai/include tst_basic.c -o tst_basic
>>> /usr/xenomai/lib/libnative.a -lpthread
>>>
>>> Segfailt in dmesg on xenomai 2.5.0:
>>> tst_basic_2.5[1351]: segfault at 0 ip b7ff5a54 sp bfc9b46c error 4 in
>>> libpthread-2.9.so[b7feb000+13000]
>>
>> Ok. Reproduced here. It looks like xeno_sigshadow_install and
>> xeno_sigshadow_installed have no address. I am on it.
>
> The following patch seems to fix the issue for me.
>
> diff --git a/include/asm-generic/bits/sigshadow.h b/include/asm-generic/b=
its/sigshadow.h
> index 5a32762..e07ce00 100644
> --- a/include/asm-generic/bits/sigshadow.h
> +++ b/include/asm-generic/bits/sigshadow.h
> @@ -4,10 +4,10 @@
> =A0#include <pthread.h>
> =A0#include <signal.h>
>
> -extern pthread_once_t __attribute__((weak)) xeno_sigshadow_installed;
> -extern struct sigaction __attribute__((weak)) xeno_saved_sigshadow_actio=
n;
> +extern pthread_once_t xeno_sigshadow_installed;
> +extern struct sigaction xeno_saved_sigshadow_action;
>
> -void __attribute__((weak)) xeno_sigshadow_install(void);
> +void xeno_sigshadow_install(void);
>
> =A0static inline void sigshadow_install_once(void)
> =A0{
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

