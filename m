Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2134.outbound.protection.outlook.com [40.107.14.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891A1871
	for <xenomai@lists.linux.dev>; Fri,  8 Sep 2023 10:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/rDZOokPUwMimmXZmH3YSkNTnQNz4kli/oPEEoG8Una7lu71NBvGMPIbyJAJgKQHUCce9QHLtZx/nsRqLpvZuVVOVaxEBoVuSnPQIa5u/AqV0oD2SjS1JpSWZyiuUP414IogDuy8xv3JASDzTKI1M4g9ns6XICNzYYhFGOJE6jJ814xb95XPQ3PHF6OOKUENyn+L689zbIm7sMuWqblx117AFQ0aj1zb4PmBN79VrcgFLzUOTPxo2Xg2kWILANUM9onKz1aqi/0ifTwI4T6Qh81my0ow00qqGodO8z2pv0kqLjGANWCsmzxuN2UQ1EA7QCgUvKJIFzfApy3dUSBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2r8tr6u00k2FJd2VOxphPXCo/NYaas9W7VK9aEOa0g=;
 b=bwqlDnUjIwKz3sA/x/W4ersmtTBj+TxnqiFnwg0eBf3DW0eWBQOwEBGyfxYCwn/uhtS69BR7UmWXkjLxC2Q69Qgf6jKkxGLWDhjODTGtAt6oXB7WRCZqf+je8DcwCWJrtb7bDuTG9b9ePreil9xP1X2k90NA6toCS9p2xXdcf1oKdeo5gUCxgQ2mbOB8LwBlQVadsyVQ0k8+o2hMJm3MJod6O0mkpnxWBzStG6nej2xZrrolVQ2C2i9B9BJGp/kCen2OC5iH/j0+87SArKXwJ7qFmsX6vD60oab0aHcrsjgP5IvZz3N5U3G9Em1Y0cUuWGvnTRWUmW/c0t060FIWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2r8tr6u00k2FJd2VOxphPXCo/NYaas9W7VK9aEOa0g=;
 b=hpqq3MIbz4rx/Ah9q1tNM/XeEoXaEVMT06rp8VcAKSDzrkpvGt+WFqOBCMb7lNyESxo6aOG6Svm2wlODaPhzFF7juda4Krg4vXoSzn6pyc2MYU+cmNzFctATvMRnH8Mdoqj0FNvOFDkj32HIEZRwbXAICGKMHIphsuSr1MzXVw0=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by PAWPR08MB10059.eurprd08.prod.outlook.com (2603:10a6:102:35d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 10:54:15 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:54:15 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Jan Kiszka <jan.kiszka@siemens.com>
Subject: RE: [PATCH 1/3] [POC] test implementaion of rt-signals
Thread-Topic: [PATCH 1/3] [POC] test implementaion of rt-signals
Thread-Index: AQHZ4kJ2WRK4tKqhNECvjy3WRR+tZrAQwJYg
Date: Fri, 8 Sep 2023 10:54:15 +0000
Message-ID:
 <VE1PR08MB490990078DA694FE14F9F20892EDA@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20230908105043.1355310-1-johannes.kirchmair@sigmatek.at>
In-Reply-To: <20230908105043.1355310-1-johannes.kirchmair@sigmatek.at>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|PAWPR08MB10059:EE_
x-ms-office365-filtering-correlation-id: bb678f7b-db92-401f-974c-08dbb059f16b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VIkv9KsqTArQNQYecBx4TDYrD/W1BIUEbW36i2q2qW2DtjI8Vhm4QuvfLDIZmTE4saryJrGnJYGqSANSZHyGoAsCI4bTmNXy5GvD5sBDwFKWtrsIFxT1+EZW75LmfkVBVKr5aoNRs0WNWZJaiSl5yK0B7QWMNBc2peYYhAanraTQYly50zWJudMo5SOT+pfPNOCONbScXj0E14V52kauMTPK2V2H260A5A/Bl0dSsBLfpx6K1gaGL6+bLoVTituIZmGKA1QItrTUE2y23Txrzfpz8fNJqcloyxm5fJxbWMIHOYnxxn4qiMNCfWCxbe/aZBMWWABAGdfDY0eZngEHqi1EAWxWC9pwg8+KkBOqqOZ29c/iXprRthwsvxnOW/WCkh9oGN4FlnnYdESVQfDu10OEYRnnxz3iEgo1CW3CujeXtN6V+BhV2LqG5vAPECxJEkGyUbbvjjy8o6N/Kq1cTfNLQrqD2PkAYovGM3OIZ34Y5GqDiy5ctZE2So4PZ1wwtHCrxvUnMXikhCQX5qRGl7qC/gUJ5G5sfT148sEzKIsF6HVbW8jtiCfHSKDeJd+YHsTe+eN2hh5n9+nVl3rcy+51BXOMBikbGC03d9dLUy78Yga8AD3Ma2KdlT5dRmCe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39840400004)(346002)(1800799009)(451199024)(186009)(122000001)(6506007)(71200400001)(53546011)(7696005)(86362001)(33656002)(55016003)(38100700002)(38070700005)(26005)(30864003)(83380400001)(9686003)(478600001)(4326008)(8676002)(52536014)(5660300002)(8936002)(66556008)(316002)(76116006)(6916009)(2906002)(66476007)(41300700001)(66446008)(66946007)(64756008)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+goWRmaSrLraHelsFq8sSMhdIPhnHlofYD1HX0+6OsGfl9u8ECXqPbPmRT?=
 =?iso-8859-1?Q?W2s1G7LRJ1i41t6NvTP+PKA0Wwfsr3KuHHraSqNYkYlP0k0sJC2pcJZrlv?=
 =?iso-8859-1?Q?Ny37zvyQLvo7Jx7W18m1NLt46V7H6kD/RnUnpyuRXBWcjsO4dw7TrjgVAM?=
 =?iso-8859-1?Q?vBbPOPzRyiI5AMNUe8brkfS+DfK7fnvcmMNNRfJ4P2dfoGn+/IGOHVRLW4?=
 =?iso-8859-1?Q?o6jpP9oO4YOMfsidIZHjKXFoVwLnNPltZivfzIalNl2bBSfZH3TNqtHeoI?=
 =?iso-8859-1?Q?7gucw2PXVXiKFo7aEk6iTI7AWm6ljWHvMJgHz4w8rMgjam3I//OdW8AZ+t?=
 =?iso-8859-1?Q?6ET4PYs5vDm4NuLh+aRlFQElRH+5P/PooyK6MsgoSsFwYtA7TH3uD7K2Dy?=
 =?iso-8859-1?Q?sb17TYL0rlJ++TCz51rdZGvIPxhdD1kQo5g94s9KzE9hb9RjjlSN7uWomF?=
 =?iso-8859-1?Q?DZFxn10w7GJ21nLBhnARVHH6v0JOkwJyaLy8odCmNc2vkXEs8kExAVBqO3?=
 =?iso-8859-1?Q?EzhgkXsWng8pCQXMINh8gQukvb3zXzWtqKxA+7DE2UuYPsiodNrjjzjpvc?=
 =?iso-8859-1?Q?m2UnXYZA4BreTyXp3si8wi5kj8zSNmfUGv1g6f7yU8psbttDJLNCwGACON?=
 =?iso-8859-1?Q?GywjxXmbcMUYhuATk5vXSOMAKREv8z508XuVgJkCkIhUH4FOyPdFmEOJrj?=
 =?iso-8859-1?Q?tVHAmO1VdwjWpLLgSkZYFMUvp8dKTdRodJWB0z2uucFsCQSu30HaL/BYTi?=
 =?iso-8859-1?Q?mQx6e366sqqmaIQkTHj2V/fZvCMLLyCsErTiOPSa7er/gzunz3+Gyc1p7m?=
 =?iso-8859-1?Q?tbe9swPJWH6VMMcQHC1+A0FRrKVG6oyvXW/ndSU+MxxuQriQauefoIq2np?=
 =?iso-8859-1?Q?LavmCjuMAINguCcGv/V+qhTML9HZQQWDuxayTlqrodQny+hacxwaxxil8z?=
 =?iso-8859-1?Q?qDlCpDowKHdiZURrfHkkaoTUkqN1YdVyvtPL4dOydlhRxSwjTqrLwJXcht?=
 =?iso-8859-1?Q?oMYkGA5h4BFUCSsaVWnx4JTe/I0PtiwHIFXb5n9f3JwkhsYhnkT0mHyU/x?=
 =?iso-8859-1?Q?ue0OhYO5OnQLw1tO1HcnHEly5Jy+WmvXZ+mEOaGMIYus+BzTOA3lIMcGGe?=
 =?iso-8859-1?Q?aYog0TYSAiR62h1Qypj5m4a6bLq9SQvy7tnPQj2M7mxNZEzm4dJH1QeBOX?=
 =?iso-8859-1?Q?TDS9sBEicF7S96oxjK0wZ8pd7mjGpVwjHLtj7yFTyo4IKGN8LHPfBwwVT5?=
 =?iso-8859-1?Q?50mXZ9X08w6Ifthlfqzi84yi2jgG+G72W4URgckKAeeDgOxCwGcINtj0Za?=
 =?iso-8859-1?Q?n+14lzau4TBsI06oFIA84vhWe6onpao/7hZw7VUw8wjaWU+GX2pu1/pnkw?=
 =?iso-8859-1?Q?vjbujMEnIPVgTy4NHvmHs6Q362C4ny5ErE+JM19QmmA0cIEM8E0abfdkui?=
 =?iso-8859-1?Q?tpj0SOXLxabZIznK6dW/iwXyp1v9EyUm3nnZgVwhJn5LeIkl6T1KkieoWQ?=
 =?iso-8859-1?Q?6Ua75Y2sL5HTkyjBqaZPzznpH4zf+ZC3oy5tjWTaYVHJjJadXI5PxPNLmQ?=
 =?iso-8859-1?Q?ZnxS7DoappR7BIxINbUga4JWyKB9a3Xtc3sGvJrdP7pXHYBZNg98UvagCI?=
 =?iso-8859-1?Q?nlWH/1QWOWeMi1HNMAfSjVlBpHtFKmfNS93Didg0idQEd9CS/7l/IZtQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb678f7b-db92-401f-974c-08dbb059f16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 10:54:15.1716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yad0k69rE8apHyqpJr01JRGOS/fDEA1CiClv2yWre778dqZokKmLLzS1lT4tjyVLTcFE/WX1CbwUm5BPz3x+gPJFXgNplauLQ18h58NYEOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10059

Changed the following things:

- replace magic numbers with X86_TRAP_*
- removed uneeded changes that slipped in (return in void function and move=
 of #ifdef CONFIG_SMP)
- removed DB and BP code
- if sigreturn fails send SIGSEGV and not MAYDAY .... will have to write a =
test for this
- added sigreturn and sigaction to sysentery sysexit tracing
- removed specific sigaction compat code
- removed xnarch_rt_sigreturn_ia32/ia64 functions and call dovetail_restore=
_rt_signal_frame in generic code=20
- moved xnarch_setup_trap_info to signal.c to dont confuse people by having=
 it in ia32 specific file


Freundliche Gr=FC=DFe
Johannes

> -----Original Message-----
> From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Sent: Freitag, 8. September 2023 12:51
> To: xenomai@lists.linux.dev
> Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Subject: [PATCH 1/3] [POC] test implementaion of rt-signals
>=20
> We implement rt signals to handle exceptions in rt stage.
>=20
> This is done using dovetail specific functions for setting up the signal
> frame.
>=20
> This can be used to handle fpe exceptions on the fly, like fixing
> division by zero. An other use case are breakpoints, implemented using th=
e
> illegal opcode exception. The real time handling of the breakpoints would
> be handy for conditional breakpoints or also for stopping watchdogs and
> other tasks in time.
>=20
> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> ---
>  include/cobalt/kernel/ppd.h                   |  3 ++
>  include/cobalt/kernel/thread.h                |  2 +
>  include/cobalt/signal.h                       |  2 +
>  include/cobalt/uapi/syscall.h                 |  2 +
>  kernel/cobalt/arch/x86/Makefile               |  2 +-
>  .../arch/x86/include/asm/xenomai/thread.h     |  3 ++
>  kernel/cobalt/arch/x86/signal.c               | 51 +++++++++++++++++++
>  kernel/cobalt/dovetail/kevents.c              |  3 ++
>  kernel/cobalt/posix/syscall.c                 | 32 ++++++++++++
>  kernel/cobalt/thread.c                        | 38 ++++++++++++++
>  kernel/cobalt/trace/cobalt-posix.h            |  4 +-
>  lib/cobalt/arch/x86/Makefile.am               |  2 +-
>  lib/cobalt/arch/x86/sigreturn.c               | 36 +++++++++++++
>  lib/cobalt/internal.h                         |  2 +
>  lib/cobalt/signal.c                           | 13 +++++
>  15 files changed, 192 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/cobalt/arch/x86/signal.c
>  create mode 100644 lib/cobalt/arch/x86/sigreturn.c
>=20
> diff --git a/include/cobalt/kernel/ppd.h b/include/cobalt/kernel/ppd.h
> index f0079fe6e..fb2f682da 100644
> --- a/include/cobalt/kernel/ppd.h
> +++ b/include/cobalt/kernel/ppd.h
> @@ -22,6 +22,7 @@
>  #include <linux/types.h>
>  #include <linux/atomic.h>
>  #include <linux/rbtree.h>
> +#include <linux/signal.h>
>  #include <cobalt/kernel/heap.h>
>=20
>  struct cobalt_umm {
> @@ -32,6 +33,8 @@ struct cobalt_umm {
>=20
>  struct cobalt_ppd {
>  	struct cobalt_umm umm;
> +	void __user *sighand[_NSIG];
> +	void __user *sigrestorer;
>  	atomic_t refcnt;
>  	char *exe_path;
>  	struct rb_root fds;
> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/threa=
d.h
> index b79cb8429..33d468419 100644
> --- a/include/cobalt/kernel/thread.h
> +++ b/include/cobalt/kernel/thread.h
> @@ -574,6 +574,8 @@ static inline void xnthread_propagate_schedparam(stru=
ct
> xnthread *curr)
>  		__xnthread_propagate_schedparam(curr);
>  }
>=20
> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs=
);
> +
>  extern struct xnthread_personality xenomai_personality;
>=20
>  /** @} */
> diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
> index 62694f93a..3d6540aff 100644
> --- a/include/cobalt/signal.h
> +++ b/include/cobalt/signal.h
> @@ -54,6 +54,8 @@ COBALT_DECL(int, kill(pid_t pid, int sig));
>  COBALT_DECL(int, sigqueue(pid_t pid, int sig,
>  			  const union sigval value));
>=20
> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))=
;
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.=
h
> index 3e65efaab..3913cc610 100644
> --- a/include/cobalt/uapi/syscall.h
> +++ b/include/cobalt/uapi/syscall.h
> @@ -141,6 +141,8 @@
>  #define sc_cobalt_timerfd_settime64		118
>  #define sc_cobalt_timerfd_gettime64		119
>  #define sc_cobalt_pselect64			120
> +#define sc_cobalt_sigreturn			121
> +#define sc_cobalt_sigaction			122
>=20
>  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>=20
> diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Mak=
efile
> index 93929b645..e3d8eb476 100644
> --- a/kernel/cobalt/arch/x86/Makefile
> +++ b/kernel/cobalt/arch/x86/Makefile
> @@ -1,5 +1,5 @@
>=20
>  obj-$(CONFIG_XENOMAI) +=3D xenomai.o
> -xenomai-y :=3D machine.o smi.o c1e.o
> +xenomai-y :=3D machine.o smi.o c1e.o signal.o
>=20
>  ccflags-y :=3D -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/includ=
e/xenomai
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> index 745c32467..70f3df2f1 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> @@ -28,5 +28,8 @@
>  #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED)
> &&	\
>  					 ((__nr) =3D=3D X86_TRAP_DB || (__nr) =3D=3D
> X86_TRAP_BP))
>  #define xnarch_fault_notify(__nr)	(!xnarch_fault_bp_p(__nr))
> +#define xnarch_fault_code(__regs)		((__regs)->orig_ax)
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info);
>=20
>  #endif /* !_COBALT_X86_ASM_THREAD_H */
> diff --git a/kernel/cobalt/arch/x86/signal.c b/kernel/cobalt/arch/x86/sig=
nal.c
> new file mode 100644
> index 000000000..2e8fdc571
> --- /dev/null
> +++ b/kernel/cobalt/arch/x86/signal.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/signal.h>
> +#include <linux/uaccess.h>
> +#include <cobalt/kernel/thread.h>
> +
> +#include <asm/sigframe.h>
> +#include <asm/sighandling.h>
> +#include <asm/fpu/signal.h>
> +#include <asm/trapnr.h>
> +
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info)
> +{
> +	switch (vector) {
> +	case X86_TRAP_DE: /* divide_error */
> +		*sig =3D SIGFPE;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D 0;
> +		info->si_code =3D FPE_INTDIV;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	case X86_TRAP_UD: /* invalid_op */
> +		*sig =3D SIGILL;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D 0;
> +		info->si_code =3D ILL_ILLOPN;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	case X86_TRAP_MF:
> +		*sig =3D SIGFPE;
> +
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D 0;
> +		info->si_code =3D 0;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +        case X86_TRAP_PF:
> +                *sig =3D SIGSEGV;
> +                info->si_signo =3D *sig;
> +                info->si_errno =3D errcode;
> +                info->si_code =3D 0;
> +                info->si_addr =3D 0;
> +                return 0;
> +	default:
> +		break;
> +	}
> +
> +	return -ENOSYS;
> +}
> +
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/ke=
vents.c
> index 4da4f51b7..09eb12acb 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct
> pt_regs *regs)
>  		xnsched_run();
>  	}
>=20
> +	if (xnthread_handle_rt_signals(trapnr, regs) =3D=3D 0)
> +		return;
> +
>  	/*
>  	 * If we experienced a trap on behalf of a shadow thread
>  	 * running in primary mode, move it to the Linux domain,
> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.=
c
> index 46c4998e4..d570bd595 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -277,6 +277,38 @@ static COBALT_SYSCALL(serialdbg, current,
>  	return 0;
>  }
>=20
> +static COBALT_SYSCALL(sigreturn, current, (void))
> +{
> +	struct pt_regs *regs =3D task_pt_regs(current);
> +	int ret;
> +
> +	ret =3D dovetail_restore_rt_signal_frame(regs);
> +	if (ret < 0)
> +		goto badframe;
> +
> +	return __xn_reg_rval(regs);
> +
> +badframe:
> +	xnthread_signal(xnthread_current(), SIGSEGV, 0);
> +	return -1;
> +}
> +
> +static COBALT_SYSCALL(sigaction, current, (int sig, void __user *handler=
,
> +		      void __user *restorer))
> +{
> +	struct cobalt_ppd *sys_ppd =3D cobalt_ppd_get(0);
> +
> +	if (sig < 0 || sig >=3D _NSIG)
> +		return -EINVAL;
> +
> +	sys_ppd->sighand[sig] =3D handler;
> +
> +	if (!sys_ppd->sigrestorer)
> +		sys_ppd->sigrestorer =3D restorer;
> +
> +	return 0;
> +}
> +
>  static void stringify_feature_set(unsigned long fset, char *buf, int siz=
e)
>  {
>  	unsigned long feature;
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 41804b24f..ae8fa5c88 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -25,6 +25,7 @@
>  #include <linux/signal.h>
>  #include <linux/pid.h>
>  #include <linux/sched.h>
> +#include <asm/sighandling.h>
>  #include <uapi/linux/sched/types.h>
>  #include <cobalt/kernel/sched.h>
>  #include <cobalt/kernel/timer.h>
> @@ -43,6 +44,7 @@
>  #include <pipeline/inband_work.h>
>  #include <pipeline/sched.h>
>  #include <trace/events/cobalt-core.h>
> +#include "posix/process.h"
>  #include "debug.h"
>=20
>  static DECLARE_WAIT_QUEUE_HEAD(join_all);
> @@ -2520,6 +2522,42 @@ int xnthread_killall(int grace, int mask)
>  }
>  EXPORT_SYMBOL_GPL(xnthread_killall);
>=20
> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs=
)
> +{
> +	unsigned int code =3D xnarch_fault_code(regs);
> +	unsigned int vector =3D trapnr;
> +	struct cobalt_ppd *sys_ppd;
> +	struct kernel_siginfo si;
> +	struct ksignal ksig;
> +	int sig, ret =3D 0;
> +
> +	code =3D xnarch_fault_code(regs);
> +	ret =3D xnarch_setup_trap_info(vector, regs, code, &sig, &si);
> +	if (ret || sig =3D=3D 0)
> +		return 1;
> +
> +	sys_ppd =3D cobalt_ppd_get(0);
> +	if (sig >=3D _NSIG ||
> +	    sys_ppd->sighand[sig] =3D=3D NULL ||
> +	    sys_ppd->sighand[sig] =3D=3D SIG_DFL)
> +		return 1;
> +
> +	if (sys_ppd->sigrestorer =3D=3D NULL)
> +		return 1;
> +
> +	ksig.sig =3D sig;
> +	memcpy(&ksig.info, &si, sizeof(si));
> +	ksig.ka.sa.sa_flags =3D SA_SIGINFO | SA_RESTORER;
> +	ksig.ka.sa.sa_restorer =3D sys_ppd->sigrestorer;
> +	ksig.ka.sa.sa_handler =3D sys_ppd->sighand[sig];
> +
> +	ret =3D dovetail_setup_rt_signal_frame(&ksig, regs);
> +	if (ret)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  /* Xenomai's generic personality. */
>  struct xnthread_personality xenomai_personality =3D {
>  	.name =3D "core",
> diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cob=
alt-posix.h
> index 47dc77e1c..8eda3bb27 100644
> --- a/kernel/cobalt/trace/cobalt-posix.h
> +++ b/kernel/cobalt/trace/cobalt-posix.h
> @@ -173,7 +173,9 @@
>  		__cobalt_symbolic_syscall(timer_gettime64),		\
>  		__cobalt_symbolic_syscall(timerfd_settime64),		\
>  		__cobalt_symbolic_syscall(timerfd_gettime64),		\
> -		__cobalt_symbolic_syscall(pselect64))
> +		__cobalt_symbolic_syscall(pselect64),			\
> +		__cobalt_symbolic_syscall(sigreturn),			\
> +		__cobalt_symbolic_syscall(sigaction))
>=20
>  DECLARE_EVENT_CLASS(cobalt_syscall_entry,
>  	TP_PROTO(unsigned int nr),
> diff --git a/lib/cobalt/arch/x86/Makefile.am b/lib/cobalt/arch/x86/Makefi=
le.am
> index a5095be3d..14f5eff97 100644
> --- a/lib/cobalt/arch/x86/Makefile.am
> +++ b/lib/cobalt/arch/x86/Makefile.am
> @@ -2,7 +2,7 @@ noinst_LTLIBRARIES =3D libarch.la
>=20
>  libarch_la_LDFLAGS =3D @XENO_LIB_LDFLAGS@
>=20
> -libarch_la_SOURCES =3D features.c
> +libarch_la_SOURCES =3D features.c sigreturn.c
>=20
>  libarch_la_CPPFLAGS =3D			\
>  	@XENO_COBALT_CFLAGS@ 		\
> diff --git a/lib/cobalt/arch/x86/sigreturn.c b/lib/cobalt/arch/x86/sigret=
urn.c
> new file mode 100644
> index 000000000..df961469e
> --- /dev/null
> +++ b/lib/cobalt/arch/x86/sigreturn.c
> @@ -0,0 +1,36 @@
> +#include <cobalt/uapi/syscall.h>
> +#include "internal.h"
> +
> +extern void cobalt_sigreturn (void) asm ("__cobalt_sigreturn") __attribu=
te__
> ((visibility ("hidden")));
> +
> +#define TO_STR(x) #x
> +
> +#ifdef __x86_64__
> +#define build_restorer(syscall_bit, syscall)                            =
       \
> +	asm(".text\n"                                                          =
\
> +	    "    .align 16\n"                                                  =
\
> +	    "__cobalt_sigreturn:\n"                                            =
\
> +	    "    movq $ " TO_STR(syscall_bit) ", %rax\n"                       =
\
> +	    "    orq $ " TO_STR(syscall) ", %rax\n"                            =
\
> +	    "    syscall")
> +#endif
> +
> +#ifdef __i386__
> +#define build_restorer(syscall_bit, syscall)                            =
       \
> +	asm(".text\n"                                                          =
\
> +	    "    .align 16\n"                                                  =
\
> +	    "__cobalt_sigreturn:\n"                                            =
\
> +	    "    movl $ " TO_STR(syscall_bit) ", %eax\n"                       =
\
> +	    "    orl $ " TO_STR(syscall) ", %eax\n"                            =
\
> +	    "    int  $0x80")
> +#endif
> +
> +/*
> + * __COBALT_SYSCALL_BIT | sc_cobalt_sigreturn
> + */
> +build_restorer(__COBALT_SYSCALL_BIT, sc_cobalt_sigreturn);
> +
> +void *cobalt_get_restorer(void)
> +{
> +	return &cobalt_sigreturn;
> +}
> diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
> index acb3989f1..4782d154a 100644
> --- a/lib/cobalt/internal.h
> +++ b/lib/cobalt/internal.h
> @@ -132,4 +132,6 @@ static inline bool cobalt_features_available(unsigned=
 int
> feat_mask)
>  	return (cobalt_features & feat_mask) =3D=3D feat_mask;
>  }
>=20
> +extern void *cobalt_get_restorer(void);
> +
>  #endif /* _LIB_COBALT_INTERNAL_H */
> diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
> index 40d315ebb..af174d570 100644
> --- a/lib/cobalt/signal.c
> +++ b/lib/cobalt/signal.c
> @@ -126,3 +126,16 @@ COBALT_IMPL(int, sigqueue, (pid_t pid, int sig, cons=
t
> union sigval value))
>=20
>  	return 0;
>  }
> +
> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))
> +{
> +	int ret;
> +
> +	ret =3D XENOMAI_SYSCALL3(sc_cobalt_sigaction, sig, handler,
> cobalt_get_restorer());
> +	if (ret) {
> +		errno =3D -ret;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> --
> 2.25.1

