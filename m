Message-ID: <4991A49C.2000503@domain.hid>
Date: Tue, 10 Feb 2009 17:00:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B3F8896E1733D4787DDB0EA1C7FF91F7048AD@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <4B3F8896E1733D4787DDB0EA1C7FF91F7048AD@ukmail.uk.wirelessworld.airvananet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] 2.4.6.1 blackfin patches
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mike McTernan <mmcternan@domain.hid>
Cc: xenomai@xenomai.org

Mike McTernan wrote:
> Hi,
>=20
> Does anyone have a working Adeos patch for the top of the Blackfin 2008=
R1 non-SMP branch to get up to 2.4.6.1?  The patch supplied with Xenomai =
doesn't cleanly apply, and after massaging would not compile:
>

adeos-ipipe-2008R1.5-RC3-bf5xx-1.8-00 applies cleanly against the officia=
l
2008R1.5-RC3 uClinux distribution. Until recently, I was only tracking of=
ficial
release milestones.

Since Adeos is now part of the official uClinux distro for the blackfin, =
I'm now
tracking their development head instead; you can now find
adeos-ipipe-2.6.28-blackfin.git-1.9-00 which applies to the blackfin.ucli=
nux.org
GIT tree at git://sources.blackfin.uclinux.org/git/readonly-mirrors/linux=
-kernel.git

ksrc/arch/blackfin/patches/README should give you that information.

>   CC      arch/blackfin/kernel/asm-offsets.s
> In file included from include/asm/mach/blackfin.h:47,
>                  from include/asm/blackfin.h:89,
>                  from include/asm/system.h:404,
>                  from include/asm/bitops.h:10,
>                  from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:33,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/blackfin/kernel/asm-offsets.c:31:
> include/asm/mach/cdefBF534.h: In function =E2bfin_write_PLL_CTL=E2:
> include/asm/mach/cdefBF534.h:55: warning: implicit declaration of funct=
ion =E2__ipipe_test_and_stall_root=E2
> In file included from include/linux/ipipe_base.h:29,
>                  from include/linux/preempt.h:11,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:47,
>                  from include/linux/sched.h:46,
>                  from arch/blackfin/kernel/asm-offsets.c:31:
> include/asm/ipipe_base.h: At top level:
> include/asm/ipipe_base.h:62: error: conflicting types for =E2__ipipe_te=
st_and_stall_root=E2
> include/asm/mach/cdefBF534.h:55: error: previous implicit declaration o=
f =E2__ipipe_test_and_stall_root=E2 was here
> make[2]: *** [arch/blackfin/kernel/asm-offsets.s] Error 1
>=20
> Adding some #include's produced yet more errors of a similar nature.
>=20
> [The Blackfin branch is located at: svn://firewall-sources.blackfin.ucl=
inux.org:80/svn/linux-kernel/branches/2008R1]
>=20
> Regards,
>=20
> Mike
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20
Philippe.

