Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2101.outbound.protection.outlook.com [40.107.8.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DAB182AE
	for <xenomai@lists.linux.dev>; Tue,  9 May 2023 13:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd0ExGx5ZIqDxwv/srAbrcyXlOYr5GD5w5JNDreSxcgQlM+r3yswBoELeDxlNg2Tlf3XIvpZlL/vUpkeP8or2VaqJpIyTtIpcWsvJ7XkF+n2qp19em990C0xzlJM4NFXTvUTa+QM0oWZ0Zv7khcL5SG0DdlSqOuU7Mw3ZgtQSm4RDUwYS54bkvg03mnsgnsJnyhGXbNSltuZkqLrq/aV5z6+hMp0YLHcdflqDiSvXNTU62Ep27kydiK0PrXwyhU/fe6DuV0vh/iWXIuErY2UgOQUHCMegDAuEQhsvtkHfafmxHziGYdsa9063IichLDmOTM3aQ7WbHd+ll2k1GO/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb8hQFgfDkgAv1hPdjQwoRj4cseMz4ePuX3s/WU5UJc=;
 b=HkvQ1rLNrudElK/UcyMsvFFdUyT4RYcTXcBxg5kU2d3EIFQCQrteJaU46sb6VaHOmsI+0PROS85qWd+AM9ws5g4TZ3SvM3Ir5CZf68vyb380sFPZ7c81bK3j+O/bLKi1KsCT3qCZu/FW73nQPS1Hc1Hi1hUt2FMGklOL/8SwHqzwFzSvcOCrqy3QCVDyWTIt1VNzAFlPbHybCFtd1NO/Iu3E/PFZ00ZqalT0Tf1S1ilxqSjstot/lbuLNL7TZpz5tiBNuw+TuqFKAlNqm+B6L9fPz9C7uzrRT9LcBt6wCurrgF8PyDmtFkDWsjom8HTTlSKyRCI9BujuPHAdia2X6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb8hQFgfDkgAv1hPdjQwoRj4cseMz4ePuX3s/WU5UJc=;
 b=kikZcDIryJ8Frc6aXxQq/rYCghWFr+FneNVdzL0m5SmSvXcwaDKnRomcobDMAnE/5HCREDSg0xr88n3r0BnhhfRPgThaGkxynNMg4DtHoT2IpKSinf6Y0UN98GModX8EezCBaficvwgP2xxpYYpLeeqk8Am3BGvdSFyyC/caEBM=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AS8PR08MB8442.eurprd08.prod.outlook.com (2603:10a6:20b:568::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:17:10 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44%5]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 13:17:10 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, "Schaffner, Tobias"
	<tobias.schaffner@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: RE: [PATCH 1/3] [POC] test implementaion of rt-signals
Thread-Topic: [PATCH 1/3] [POC] test implementaion of rt-signals
Thread-Index: AQHZgngvbtobMmG9vkavfXqY7rMP4K9R66mQ
Date: Tue, 9 May 2023 13:17:10 +0000
Message-ID:
 <VE1PR08MB4909999B96106DD25AE0D19D92769@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20230509131355.3003275-1-johannes.kirchmair@sigmatek.at>
In-Reply-To: <20230509131355.3003275-1-johannes.kirchmair@sigmatek.at>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|AS8PR08MB8442:EE_
x-ms-office365-filtering-correlation-id: 629891c6-b90b-4fa3-5b59-08db508fb22b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i0xdRrzjWKb0MiV4peQ1dnbnt5Khf9Ew7/02vsxU6hb+3diYDGlvt30WBhRx2sR7SmqDeTJA9c4VIrRKhYxPQebptEASLSUQ97sPQ1zFd+7Q3HIYOX7B2X00yBOtJUWS1WkbJxj9lD1uMm0qqF7Xd5aGq08wGJC1MaQcjOzULPQNB/nUEms7N9wHjLyHykjp+FFDn1OoSV8wgrBAuxTDv5kL3aav2TebrQFw7UHbdoI9CgAJ+48g0k41cUZTZkjkKWu6tsfbskV+4y7LaDbrHKdbDJas2pa6H8euafyWiI/1yOjHDBAyuKJfy9p+TqWA/3mSZEcV5l0LYQzsLO4abyMSZPR3JGUnH3joX/zt68Q02l0IMOQfDLgScyRywiOi1mKbjQ5U74Atl60CGCB23Y5QjZWVes14a2Nr2+fmSaBNtg+KQAnDWLTf9hONKrcaMh36WRqfwR168VSZuVC1wKiaV8XcqTjhXjA3Yk+bl7M9xzRRZf/I3xCerlVUlIkgnlT2WqAeXDqpl2Vq0tSWEZ8F5DzZ7GkrZFXPaH0pzSDXt7AdQDaZ90CXJdf82lKw+TudEeNEh7qpXunuYicyybK02gCbWXrdPrQKsKza4RknEKlaYiYy39J0D474p1j+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(451199021)(8676002)(44832011)(52536014)(8936002)(5660300002)(41300700001)(316002)(64756008)(30864003)(66446008)(83380400001)(9686003)(2906002)(76116006)(33656002)(86362001)(66946007)(66476007)(66556008)(26005)(71200400001)(186003)(7696005)(53546011)(478600001)(38100700002)(38070700005)(55016003)(110136005)(122000001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OknflaeOoJnYeJ9WAt9Gp52I7HZIg3wnWsHhxcG7sVJhiLOFbO4AKsxmtymC?=
 =?us-ascii?Q?cyvdMd+lgq50eEpTNy0NwLcVeSX8UMciDAMAqZ66eQz1HzeNLZFT/OYjBsBD?=
 =?us-ascii?Q?PQh94Py1Piqu84R9SBhANJJpnmWu35cxowAuYzJrwu+TUyfM65IjOYs3+YIc?=
 =?us-ascii?Q?nE9ukssKjJn0ilXF9U+hbdOJyPUwwoxA652VSmA9WUsIhSbavrup+olmfbp/?=
 =?us-ascii?Q?xWCqK4NjXAP1N5+P4bri5SF05N5Qqq9QVpYLuOa3DrldNa1ErnyKN4Je1Q0Z?=
 =?us-ascii?Q?l5W5iqBGla6VAxWgF9+eOHpfGNB8nWEG7p/wE8og7w9/2khL3xLS98oR1N3n?=
 =?us-ascii?Q?hfOIQiCqye+qmxLd1wt+cV5EA6guKa25r0rNxD8wbnKXlnWumdZEAccNw/mK?=
 =?us-ascii?Q?/V0bShUHZFvQY7+RiX7HHs4hBcd58cpAxP4HBiQs4Jz87NlCZSQTgFanqGzH?=
 =?us-ascii?Q?FMrgW5i/ttS4V61/vaRdgY0ouie1sWrJXCCagOeT25UsJNwnztuUYdDywH9c?=
 =?us-ascii?Q?0sIENEF9q5Re9RoQKHuQX4Ho/OpyypQInwimdC51KGzZDXnFNLLkXX+yRHU5?=
 =?us-ascii?Q?8OifdG3lY1XmfZHYC/fI2lnyVA79tPFLSyZEL7WTbTe8tLtqYIiu80yyTHC+?=
 =?us-ascii?Q?FVZzHRTz2mHqRV2EzTDoxTbf542rKelv1Iui2sYKoBzOcqAQ/EkOLt26arkf?=
 =?us-ascii?Q?2F+2o2Lvap26vF1x+7hJsgJjef2pfY/k2tfy+i1QoUnt7i6S2NwmQaIFlaFY?=
 =?us-ascii?Q?9b844cbmesridP0iE+bhyImx1R2+9Or8Gpc6wMDMWuQ7naoCcv2t1YZcKAr6?=
 =?us-ascii?Q?HPWoFuFpdD4btsx6L46pVxRyLj7YLbFjLJjZjomDQX5Y/mMbFy9+kpyktYwM?=
 =?us-ascii?Q?apXZwW7JVB+VjeOeCSNvglz5a3FW7qrAik9MXd69QN3Xy+OB1Pi/CkxqIFY8?=
 =?us-ascii?Q?ko6gu1A1iDXmd5BUiqLbzigRsGYAj8cDffWMAZOWGoE9r1vZ7lJHf7BCkejo?=
 =?us-ascii?Q?zpIcFx9waG8ZYmUDK9Lxa6J9/8iOoD+8wGdDLmmAm87TrYoQsLLDwq61FkJo?=
 =?us-ascii?Q?HAht7GcFkxGUYl33wiFzJod35Ge3Np7BSornph8+VuS7e/nTpAbh8FP1sIMe?=
 =?us-ascii?Q?llBw/RquG/1M0TRe9RIqsxRws5xjMNF1zk2tJgVYOsz5xawq/9u1Vc3wXCP6?=
 =?us-ascii?Q?fTi9cz1SolKvlhljedoTqQ3fnx/usUImkuGD3/j7FXlx3U8vdpsTN7sgOiEZ?=
 =?us-ascii?Q?MGUvimHVe37Nvrt5HFdsWjJmC6HncZ3dTSKhUEvuMWrMMyMZ3c2T5VRXq/VM?=
 =?us-ascii?Q?LTd8vwtB0Dbt/V1w3T9+D1OINg30nzDsoTscMeOn/fwxKf/Izkd1TdThn1E1?=
 =?us-ascii?Q?v/jpLw4UmLkgU/MxUcwiqQ+JFLuZfhQyrsRe5Ehia5DBI8Y6NX1vU2CEY/A/?=
 =?us-ascii?Q?40S3XANmciaG5gf7psPigosC74/E93OW8NC1gKXMpXPEf/kz+jTdP+fT1ZaA?=
 =?us-ascii?Q?14Lu8XdHeIDuomEzC6NttO6QUD05LOCEyWyTGuirHjD8q74riR/KxopghEKX?=
 =?us-ascii?Q?L8HuLOvgL1gaGy8OaeaXf7W/30GIQgFTgYTNRykFJKkKOMkxf+ErIW+LMx42?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 629891c6-b90b-4fa3-5b59-08db508fb22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 13:17:10.2193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5UxADlb+Rr0IMY6lsKOfSKFte5qQRJDBY0xQL5Hg4hpXNAQJ1LM/ltiLgfbpZ4xtUEkS6zC8bMjxYXKeJMRaUQ2uA70+qbh1wAXPQ23AWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8442

Hello Jan and Tobias,

I just dropped the patches on the mailing list.
For the dovetail functions I took a rather naive approach, using most of th=
e frame setup code provided by Linux.
I just tested it for 32bit and 64bit x86 Applications and it seems to work.=
=20

I also added a tool rt_signal_hist that runs in a cycle and measures the ti=
me an exception handling takes.
It is afterwards put into an txt file that reassembles an histogram of the =
timings.

Unfortunately as a 32bit application the rt_signal_hist tool does not run t=
o completion, printing the following:
" Xenomai/cobalt: sleeping while holding mutex
CPU time limit exceeded"

Maybe the naive approach is not so reliable ;-/
Hope I find the time the look into it.=20

Sorry for not putting more effort into this so fare.

The next most important step in my opinion would be to define a clean inter=
face into dovetail for the signal frame setup and restoring.
Actually that's the task I consider one of the harder and I am not so sure =
how to approach this.

Best regards
Johannes

> -----Original Message-----
> From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Sent: Dienstag, 9. Mai 2023 15:14
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
>  include/cobalt/kernel/ppd.h                   |  3 +
>  include/cobalt/kernel/thread.h                |  2 +
>  include/cobalt/signal.h                       |  2 +
>  include/cobalt/uapi/syscall.h                 |  6 ++
>  kernel/cobalt/arch/x86/Makefile               |  2 +-
>  .../arch/x86/include/asm/xenomai/thread.h     | 13 ++++
>  kernel/cobalt/arch/x86/signal_ia32.c          | 75 +++++++++++++++++++
>  kernel/cobalt/arch/x86/signal_ia64.c          | 26 +++++++
>  kernel/cobalt/dovetail/kevents.c              |  5 ++
>  kernel/cobalt/posix/process.c                 |  3 +-
>  kernel/cobalt/posix/syscall.c                 | 28 +++++++
>  kernel/cobalt/posix/syscall32.c               | 16 ++++
>  kernel/cobalt/thread.c                        | 39 ++++++++++
>  lib/cobalt/arch/x86/Makefile.am               |  2 +-
>  lib/cobalt/arch/x86/sigreturn.c               | 32 ++++++++
>  lib/cobalt/internal.h                         |  2 +
>  lib/cobalt/signal.c                           | 13 ++++
>  17 files changed, 266 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/cobalt/arch/x86/signal_ia32.c
>  create mode 100644 kernel/cobalt/arch/x86/signal_ia64.c
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
> index 9646a0d97..6307fae7f 100644
> --- a/include/cobalt/uapi/syscall.h
> +++ b/include/cobalt/uapi/syscall.h
> @@ -137,6 +137,12 @@
>  #define sc_cobalt_recvmmsg64			114
>  #define sc_cobalt_cond_wait_prologue64		115
>=20
> +/*
> + * Sigmatek specific syscalls
> + */
> +#define sc_cobalt_sigreturn			120
> +#define sc_cobalt_sigaction			121
> +
>  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>=20
>  #endif /* !_COBALT_UAPI_SYSCALL_H */
> diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Mak=
efile
> index 93929b645..e725afbff 100644
> --- a/kernel/cobalt/arch/x86/Makefile
> +++ b/kernel/cobalt/arch/x86/Makefile
> @@ -1,5 +1,5 @@
>=20
>  obj-$(CONFIG_XENOMAI) +=3D xenomai.o
> -xenomai-y :=3D machine.o smi.o c1e.o
> +xenomai-y :=3D machine.o smi.o c1e.o signal_ia32.o signal_ia64.o
>=20
>  ccflags-y :=3D -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/includ=
e/xenomai
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> index 745c32467..4d004680b 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> @@ -28,5 +28,18 @@
>  #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED)
> &&	\
>  					 ((__nr) =3D=3D X86_TRAP_DB || (__nr) =3D=3D
> X86_TRAP_BP))
>  #define xnarch_fault_notify(__nr)	(!xnarch_fault_bp_p(__nr))
> +#define xnarch_fault_code(__regs)		((__regs)->orig_ax)
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info);
> +
> +int xnarch_setup_rt_frame_ia32(int sig, void *handler, struct kernel_sig=
info *si,
> +			  struct pt_regs *regs, void __user *restorer);
> +
> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs);
> +
> +int xnarch_setup_rt_frame_ia64(int sig, void *handler, struct kernel_sig=
info *si,
> +			  struct pt_regs *regs, void __user *restorer);
> +
> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs);
>=20
>  #endif /* !_COBALT_X86_ASM_THREAD_H */
> diff --git a/kernel/cobalt/arch/x86/signal_ia32.c
> b/kernel/cobalt/arch/x86/signal_ia32.c
> new file mode 100644
> index 000000000..e78c8c4d4
> --- /dev/null
> +++ b/kernel/cobalt/arch/x86/signal_ia32.c
> @@ -0,0 +1,75 @@
> +#include <linux/signal.h>
> +#include <linux/uaccess.h>
> +#include <cobalt/kernel/thread.h>
> +
> +#include <asm/sigframe.h>
> +#include <asm/sighandling.h>
> +#include <asm/fpu/signal.h>
> +
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info)
> +{
> +	switch (vector) {
> +	case 0: /* divide_error */
> +		*sig =3D SIGFPE;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D 0;
> +		info->si_code =3D FPE_INTDIV;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	case 1: /* trap_error */ {
> +		unsigned long condition;
> +		get_debugreg(condition, 6);
> +		set_debugreg(0, 7);
> +		*sig =3D SIGTRAP;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D errcode;
> +		info->si_code =3D get_si_code(condition);
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	}
> +	case 3: /* trap_error */
> +		*sig =3D SIGTRAP;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D errcode;
> +		info->si_code =3D SI_KERNEL;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	case 6: /* invalid_op */
> +		*sig =3D SIGILL;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D 0;
> +		info->si_code =3D ILL_ILLOPN;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	case 16: { /* coprocessor_error */
> +		*sig =3D SIGFPE;
> +
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D 0;
> +		info->si_code =3D 0;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	return -ENOSYS;
> +}
> +
> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs)
> +{
> +	int ret;
> +
> +	ret =3D dovetail_restore_rt_signal_frame(regs);
> +	if (ret < 0)
> +		goto badframe;
> +
> +	return regs->ax;
> +
> +badframe:
> +	xnthread_call_mayday(xnthread_current(), SIGKILL);
> +	return -1;
> +}
> +
> diff --git a/kernel/cobalt/arch/x86/signal_ia64.c
> b/kernel/cobalt/arch/x86/signal_ia64.c
> new file mode 100644
> index 000000000..a7044db40
> --- /dev/null
> +++ b/kernel/cobalt/arch/x86/signal_ia64.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 1991, 1992  Linus Torvalds
> + *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
> + *
> + *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
> + *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
> + *  2000-2002   x86-64 support by Andi Kleen
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +
> +#include <linux/signal.h>
> +#include <linux/uaccess.h>
> +#include <cobalt/kernel/thread.h>
> +
> +#include <asm/sigframe.h>
> +#include <asm/sighandling.h>
> +#include <asm/fpu/signal.h>
> +
> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs)
> +{
> +	return dovetail_restore_rt_signal_frame(regs);
> +}
> +
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/ke=
vents.c
> index 4da4f51b7..61417717b 100644
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
> @@ -88,6 +91,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct
> pt_regs *regs)
>  		xnstat_counter_inc(&thread->stat.pf);
>=20
>  	xnthread_relax(xnarch_fault_notify(trapnr), SIGDEBUG_MIGRATE_FAULT);
> +
> +	return;
>  }
>=20
>  static inline int handle_setaffinity_event(struct dovetail_migration_dat=
a *d)
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.=
c
> index 1abc86f37..2069129cb 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -738,9 +738,10 @@ void cobalt_unregister_debugged_thread(struct
> xnthread *thread)
>  		cobalt_resume_debugged_process(process);
>  }
>=20
> +#ifdef CONFIG_SMP
> +
>  int cobalt_handle_setaffinity_event(struct task_struct *task)
>  {
> -#ifdef CONFIG_SMP
>  	struct xnthread *thread;
>  	spl_t s;
>=20
> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.=
c
> index 46c4998e4..b4bd4c587 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -277,6 +277,34 @@ static COBALT_SYSCALL(serialdbg, current,
>  	return 0;
>  }
>=20
> +static COBALT_SYSCALL(sigreturn, current, (void))
> +{
> +	struct pt_regs *regs =3D task_pt_regs(current);
> +
> +	if (regs->cs =3D=3D __USER_CS)
> +		xnarch_rt_sigreturn_ia64(regs);
> +	if (regs->cs =3D=3D __USER32_CS)
> +		xnarch_rt_sigreturn_ia32(regs);
> +
> +	return __xn_reg_rval(regs);
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
> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscal=
l32.c
> index b65a0a760..f8b21bfb2 100644
> --- a/kernel/cobalt/posix/syscall32.c
> +++ b/kernel/cobalt/posix/syscall32.c
> @@ -774,6 +774,22 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
>  	return ret ?: __cobalt_sigqueue(pid, sig, &val);
>  }
>=20
> +COBALT_SYSCALL32emu(sigaction, current,
> +		    (int sig, void __user *handler, void __user *restorer))
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
>  COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
>  		    (struct cobalt_monitor_shadow __user *u_mon,
>  		     int event, const struct old_timespec32 __user *u_ts,
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 41804b24f..71f97c481 100644
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
> @@ -2520,6 +2522,43 @@ int xnthread_killall(int grace, int mask)
>  }
>  EXPORT_SYMBOL_GPL(xnthread_killall);
>=20
> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs=
)
> +{
> +	struct ksignal ksig;
> +
> +	unsigned int vector =3D trapnr;
> +	unsigned int code =3D xnarch_fault_code(regs);
> +	struct cobalt_ppd *sys_ppd;
> +	int sig, ret =3D 0;
> +	struct kernel_siginfo si;
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
> index 000000000..76292e145
> --- /dev/null
> +++ b/lib/cobalt/arch/x86/sigreturn.c
> @@ -0,0 +1,32 @@
> +#include <cobalt/uapi/syscall.h>
> +#include "internal.h"
> +
> +extern void cobalt_sigreturn (void) asm ("__cobalt_sigreturn") __attribu=
te__
> ((visibility ("hidden")));
> +
> +#ifdef __x86_64__
> +#define build_restorer(syscall_number)                                  =
       \
> +	asm(".text\n"                                                          =
\
> +	    "    .align 16\n"                                                  =
\
> +	    "__cobalt_sigreturn:\n"                                            =
\
> +	    "    movq $ " #syscall_number ", %rax\n"                           =
\
> +	    "    syscall")
> +#endif
> +
> +#ifdef __i386__
> +#define build_restorer(syscall_number)                                  =
       \
> +	asm(".text\n"                                                          =
\
> +	    "    .align 16\n"                                                  =
\
> +	    "__cobalt_sigreturn:\n"                                            =
\
> +	    "    movl $ " #syscall_number ", %eax\n"                           =
\
> +	    "    int  $0x80")
> +#endif
> +
> +/*
> + * __COBALT_SYSCALL_BIT | sc_cobalt_sigreturn
> + */
> +build_restorer(0x10000078);
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

