Message-ID: <4357C11B.3080103@domain.hid>
Date: Thu, 20 Oct 2005 18:08:59 +0200
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Replacement for rt_save_flags_and_cli
References: <40292.128.93.15.41.1129793705.squirrel@domain.hid>
	<435766D6.6090605@domain.hid> <43576FA9.6010202@domain.hid>
In-Reply-To: <43576FA9.6010202@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:

> Ignacio Garc=EDa P=E9rez wrote:
>
>> Hi,
>>
>> Porting app from RTAI. Just another newbie question. Is there a
>> substitute for rt_save_flags_and_cli / rt_restore_flags ?.
>
>
> See include/nucleus/asm-generic/hal.h:
>
> #define rthal_local_irq_save(x)  =20
> #define rthal_local_irq_restore(x)

Thanks. I just found the following functions in
include/nucleus/asm-generic/system.h

xnlock_get_irqsave
xnlock_put_irqrestore
xnlock_clear_irqoff
xnlock_clear_irqon

They're just #defines to the rthal_ functions.

Should I use rthal_* or xnlock_* ?

By the way, so far I'm uttery in love with the clean, consistent API of
the native skin.

Nacho.





