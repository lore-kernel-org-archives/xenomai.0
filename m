Message-ID: <4C35BC41.2060104@domain.hid>
Date: Thu, 08 Jul 2010 13:53:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilhwN4_JeD3KRCEWLxkOZSIcYwij1qZjKRvR8DN@mail.gmail.com>
In-Reply-To: <AANLkTilhwN4_JeD3KRCEWLxkOZSIcYwij1qZjKRvR8DN@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How can i fix this error ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?R8O2cmtlbSBLYXJhZG/En2Fu?= <gkaradagan@domain.hid>
Cc: xenomai@xenomai.org

G=C3=B6rkem Karado=C4=9Fan wrote:
> root@domain.hid# make
> scripts/kconfig/conf -s arch/x86/Kconfig
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CC      kernel/bounds.s
>   GEN     include/generated/bounds.h
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from include/linux/sched.h:64,
>                  from arch/x86/kernel/asm-offsets_32.c:8,
>                  from arch/x86/kernel/asm-offsets.c:2:
> include/linux/ipipe.h:31:23: error: asm/ipipe.h: No such file or direct=
ory
> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2
> root@domain.hid#

Please refer to README.INSTALL section 2.4.

--=20
					    Gilles.


