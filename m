Date: Tue, 3 May 2022 13:12:20 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <514815802.20975.1651576340906.JavaMail.zimbra@nod.at>
In-Reply-To: <bcf08a98ba01d7718b85c698df6b8d2d9927259d.camel@siemens.com>
References: <bcf08a98ba01d7718b85c698df6b8d2d9927259d.camel@siemens.com>
Subject: Re: Register (or stack) corruption: Xenomai 3.2.1 on 4.19-ipipe
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, Richard Weinberger <richard.weinberger@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>

Florian,

----- Urspr=C3=BCngliche Mail -----
> Von: "Florian Bezdeka" <florian.bezdeka@siemens.com>
> it seems that I'm able to reproduce a register (or stack) corruption on
> x86.
>=20
> The problem does not appear when running the Xenomai testsuite
> (especially switchtest) without any additional load. Stressing Linux
> with stress-ng makes the test fail.
>=20
> Kernel: 4.19.231-cip68
> Xenomai: 3.2.1
> Hardware:
> - Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz
> - 32 cores
> stress-ng cmdline:
> stress-ng --cpu 16 --io 8 --vm 4 --vm-bytes 128M --fork 8
>=20
> Any ideas how to debug that? Any additional config options that
> could/should be enabled?

Do you have CONFIG_VMAP_STACK enabled?
A vmalloc()'ed stack often helps catching the overwriter itself.
In my case so far it did not, though.
=20
> Any advice is welcome...
>=20
> Adding Richard to CC, he mentioned some undiscovered possible stack
> corruption as well. As registers are stored on the stack, there might
> be a pattern.
>=20
> dmesg (from one xeno-test run):
> [  184.461138] sched: RT throttling activated
> [  250.243970] arch/x86/xenomai/ipipe/include/asm/xenomai/fptest.h:43: Wa=
rning:
> Linux is compiled to use FPU in kernel-s.
> [  250.243970] For this reason, switchtest can not test using FPU in Linu=
x
> kernel-space.
> [  250.244148] r1: 2147483648 !=3D 5

Is it always 0x80000000?

Who's registers are overridden? In my case always the registers of kernel s=
ide of the
realtime userspace thread.

Thanks,
//richard

