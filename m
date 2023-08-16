Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2137.outbound.protection.outlook.com [40.107.105.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23222FC0A
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 10:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI9p3G/okL1v2BWdMCKHK0eHDsiGg5SA77rTaZCfBl5bT8XG1f5pVjn5d+4A73C6EYSMaIFfhd8dMPo4/3WnmYcL74ekbtU6gtkcc8tsVQTFjYhFQqs/2T7kjr2QX7Adc9V8CbVGZ1rKJF+eFk239XdAELKaMmtx0R/tLammqFBtCOevvAZL81R6nAimY7EsIGV5+fdZpOgYYcVfh+oicCUQLl7D8HNCY6tZOKLMRTw4V56uSh997Kfj5lHl23AKK4tXQ5POEvZ/KVg+TU8EdQgeS1V+R93+HB8FDvAyyVmzQUXWO1F6BtXJs1wZSy9DWDwvsKwZH5poPJJDk79dGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9uFffCThvUdnQQTHQXLzzuaFoN5dYrJVEoP4IGe0r4=;
 b=hE5+7QOKNUM17n7qU0XZFjhVxwT+dn4hdnFc8Nz2MW0gSqpKItu2eb9tg++1rHfWQVlIcc7PqAEloRyK3Up4hgABBW4hR2F0YZdwM67Zwh2SAEyZb3jRcXrBx9r6JFIL5LbdfcYV+xbU1YV+FHXu9y0C+z9zJXxOw0esIbaL0JHveZ+lU2mUWYu3EW/xgJBSfJWUSJrxnKWhzTZsceKvUyUF6dnVCZ/VAXe2Yp2bV79uPbrZnNm1+8GbysCq3YFt4xHK64aRoEBFQ4QyJkNae+H0qKdBI3RcKNBOTjM20mA7qTKdOUqoNzftXX6XFhdbKY5g+HHUmnOTlixK6GCi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9uFffCThvUdnQQTHQXLzzuaFoN5dYrJVEoP4IGe0r4=;
 b=UwF/xj4dT2ISc+3tNySleF0xAFSRZsfQSYF82P7axAdgLMkLjHfLXo79pJnPJfncriVlzDHoWkblDXzpsrRWQ/f1GIshJZdeTn8gZ5imNdjANrE6zMZGjrToCXGnxmYpD/G9X5yVSEbIZRiC7idUbnxPu1pl8qe6smWau69uFF8=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by DB4PR08MB9192.eurprd08.prod.outlook.com (2603:10a6:10:3fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 10:24:03 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470%7]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 10:24:03 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Jan Kiszka <jan.kiszka@siemens.com>, "Schaffner, Tobias"
	<tobias.schaffner@siemens.com>
Subject: RE: [PATCH] add dovtail signal setup function
Thread-Topic: [PATCH] add dovtail signal setup function
Thread-Index: AQHZ0CsYsxIW6QXQZEOwILoPNRNjd6/stiTA
Date: Wed, 16 Aug 2023 10:24:03 +0000
Message-ID:
 <VE1PR08MB4909478E9A3278E549AA22959215A@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20230816101853.3377721-1-johannes.kirchmair@sigmatek.at>
In-Reply-To: <20230816101853.3377721-1-johannes.kirchmair@sigmatek.at>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|DB4PR08MB9192:EE_
x-ms-office365-filtering-correlation-id: 21650441-2ff4-44d7-ab60-08db9e42e9ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QHjwy9HGGqW9PPRY9Bxr+dclIZ1WfyJztShFCvpITTCvN0fhwKP8U1syHvb8WTTjWrpzJlEs5pr6J7Yl/HTI33VOuBE/ykIq+Ptu0juXA4wW2iJbO4vdyDo8V32sxjYZpMskzPz44YMtmM0XkJ0fvWLD0uls4lP44VOPVGAWYDyPiDKEBucqUPZF/23IH5WYC3YWIsD4T0F1rxAvyraHKGIxn9i/dgpxP1ze3jNwY8uo/PLXYMMG9rWDF1cxyKeEiRVff+AfwCWCGkSApIzHYbyDA2D4OWksNGu3ProVxT8c5ONoz+1geqcqUaMW5UrTD7RzIFmC6Xkd49Ud629NABVWNMgZHWcK7FdSRMmdtzIEslvmigiZ4EPWM2hA5GmqaJRZJa/4h/jG62doGbBsOUYwIqRj/FJImHeSwA1ow/9hRJ52eS2hfytXDZ1WsAiQjiv9RBsWoNNTR4/VHkN2GXdyGDBWLBxLTWjA64Oldx4Xf35ekjSaNB7YJsELUVZbsfKGy1qYkcDtwCIhxWrsnc8D9NE31aA5tRCcvU67ujfY9hwxI/H+W0A3Yz4pca/45i0VKKWSRh//jhfgFljtyyjI/lfhDf8pRJL/Ukq3sJ2vS6zZG0Tb7YWynEMs9OKP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39840400004)(1800799009)(451199024)(186009)(2906002)(83380400001)(86362001)(478600001)(7696005)(6506007)(71200400001)(33656002)(9686003)(53546011)(26005)(55016003)(5660300002)(44832011)(41300700001)(52536014)(122000001)(6916009)(54906003)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(8676002)(8936002)(4326008)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?meyci5sFwopHQ/nMQv+kER2+2g9yE2nMBCaHV0C4TnO4vUFO8UdVY3EW0W?=
 =?iso-8859-1?Q?a/2Wn+AstSMhk8rNqB50VUfRrXTHb3rlo1XtirWgpINMVH/AryNi8UDFPs?=
 =?iso-8859-1?Q?bNEqOEzJvbu+ZlHe0r8ZJpufm1afHYhRKXj2XUEelCiM8+crhLw+4Vsgs3?=
 =?iso-8859-1?Q?eRwSXrmz1fLIfyP+g7dDC85GdU7xMoaeSnfprbdNSnWWJBBIJToW/qSxTr?=
 =?iso-8859-1?Q?+mx29owBZxe83zVymKqkkZ2Yhax3InhLIA/jTeGZ9GTZRrSI2vl8RxfxRx?=
 =?iso-8859-1?Q?qpycjBbK3OgrKcQ9L/LMnC/+OyPWTXPWlLXELLpRYPT0qCWJWvF31eqhPc?=
 =?iso-8859-1?Q?Bm3Q6KnbTfpwEBKxBwx89J4XEf8DSnrrWv+pW/swSy0RiYqGdtetyRE3tH?=
 =?iso-8859-1?Q?0DLWlgACrQqSQTjkeq+ayX+OJoAy5zZi57iDorz2J4z/jFnUqq0SsmryMp?=
 =?iso-8859-1?Q?KVjvrVX2KWVnJqnazSWL7uJeGuIb1XN/MDRKOutYUlk94Z3H5aYSQciOaP?=
 =?iso-8859-1?Q?1/WSZsGhkhLJ2vLyUfO/x/czdzWfUZTT68ljbwjJFpSHUtUU5NX43xGSHc?=
 =?iso-8859-1?Q?geE3xL48Dj4Wsdi2KPo2ovzlNwRX/locPBu7k8O/CyRM0IE7XsoUJs4pcY?=
 =?iso-8859-1?Q?qsl0YJfTQwZi/hclWi6WbKLbCiBf3NNPUbRY6fGlEch4OlnlYISchFkOJ4?=
 =?iso-8859-1?Q?dsc/U+ORUxx5VEXtsXzM51PXqEDhJVhtqbrWPGIY7kAUmUC+S/AEd72+87?=
 =?iso-8859-1?Q?OnnqJaeumN5Wvvm1ICV0DP0SEspBkGXN7BmZ60FuzZP3/TbMqlSzSaxjUb?=
 =?iso-8859-1?Q?22co4ZvqMyET6Tnn+ho35o8Cf3/YuNz4PEDqHXD8OYsrQrpRMsPUu3hXFR?=
 =?iso-8859-1?Q?WnYuhjd8hrfUrL55WEIdgsF7M4psIf1s/cVsO7o7yXvg7nwDGGG3TG+uA7?=
 =?iso-8859-1?Q?Ty9qe+YYBPppRLQ9LNrGmskyc8IRKWe9FfUio3XEaZSS/YrU0BC9HaD3z6?=
 =?iso-8859-1?Q?SduQeUpQEQIa5POprP6+5Jr8ekXOlH6dpN0gLhSyoqy4CeiB8O4TzxsfCJ?=
 =?iso-8859-1?Q?tp/q8pkIMNC47XAseXkkhk5xIEM1CDM4/C9vKkiOIlcrC8ivP8HOxo30Pt?=
 =?iso-8859-1?Q?iJ3TCZ5jaBlIQsBS3Nx2ivrIiKLMazkkFP3QDrTRWlbh0tDAeO6yLOlPG5?=
 =?iso-8859-1?Q?e+RJqsToVo1IMRR0MfgxizcfA+hUEwOcVzlgL36gaGDez4SHt67Lx/olFe?=
 =?iso-8859-1?Q?bms+rzP7U7P0l34kx+hPKt5tmuCr3mzCdfpSL1URoGWvm1/Pp7jWzR9Uur?=
 =?iso-8859-1?Q?sBytLM+4wYdWiFA/xuPhb/3FYNS4kdCiRkCQ3H4xVmlQycYYdXEyAbbs4Z?=
 =?iso-8859-1?Q?hKaqAan6u2DK6bGqEGc7OQ0gqxhuAWwlA2hjf523ZFk4wyoTQL10fyDuUe?=
 =?iso-8859-1?Q?04uu2QD3kYiFgAvk06MFKl0MrG0aO9ctBEqPiOrMDdzGNOYa8w/aDYnraR?=
 =?iso-8859-1?Q?Iw2ZTs56eDTVAVMucINV9NHZwuy8+WKXfRUorlxXnLW5O7Th/4QKmucFoH?=
 =?iso-8859-1?Q?Osbrf/SqpoRb/HYrI4UsXWfw+Ef+RIL9N8/MjAb9lDLfYpY7QZPrZPLJzo?=
 =?iso-8859-1?Q?pxtxNus7qJZfEq2yB7sYVWWe1GuRmmCv6LvbQGMeM6c8NoTu50UXVGpg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21650441-2ff4-44d7-ab60-08db9e42e9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 10:24:03.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGo13GGoFz63y/ZKyaKvNvRAdTiWnXdhXjzmMiK/R3hgHzR49wk1fB+VxGs4Io1pzfGyNjaXj4LakYeAzxuvryjAyvRsCYLpFAuKRn4Qm98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9192

Hey Jan and Tobias,

this is a new version of the patches I have for rt exception handling in Xe=
nomai.
I changed stuff primarily to fix the bug Tobias found.

@Tobias  thank you again for finding the problem with my last patch series!

I also move some stuff around to have arch specific stuff in  arch/x86.

Freundliche Gr=FC=DFe
Johannes

> -----Original Message-----
> From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Sent: Mittwoch, 16. August 2023 12:19
> To: xenomai@lists.linux.dev
> Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Subject: [PATCH] add dovtail signal setup function
>=20
> add an interface to dovetail for signal frame setup and restoring.
>=20
> This is useful for implementing rt signals within Xenomai.
>=20
> The interface makes it possible to use the setup use functions provided
> by Linux.
>=20
> This is just a proof of concept using a very naive approach using most
> of the code provided by Linux to setup signals.
> The patch should be discussed, especially considering if using the
> Linux functions is viable in a rt context.
>=20
> Also to discuss would be the interface itself,
> for convenience I used the kernels struct ksignal for testing. But maybe
> we should maintain our own struct, that is not that feature rich.
> ---
>  arch/x86/include/asm/sighandling.h |  6 ++++++
>  arch/x86/kernel/signal.c           | 22 ++++++++++++++++++++++
>  arch/x86/kernel/signal_32.c        | 13 +++++++++++++
>  arch/x86/kernel/signal_64.c        | 17 +++++++++++++++++
>  include/linux/dovetail.h           |  4 ++++
>  kernel/dovetail.c                  | 14 ++++++++++++++
>  6 files changed, 76 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/sighandling.h
> b/arch/x86/include/asm/sighandling.h
> index e770c4fc47f4..35ffb1c52173 100644
> --- a/arch/x86/include/asm/sighandling.h
> +++ b/arch/x86/include/asm/sighandling.h
> @@ -24,4 +24,10 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct p=
t_regs
> *regs);
>  int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
>  int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
>=20
> +int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs);
> +int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs);
> +
> +int dovetail_arch_setup_rt_signal_frame(struct ksignal *ksig, struct pt_=
regs
> *regs);
> +int dovetail_arch_restore_rt_signal_frame(struct pt_regs *regs);
> +
>  #endif /* _ASM_X86_SIGHANDLING_H */
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index cfeec3ee877e..d060931403dc 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -353,6 +353,28 @@ void signal_fault(struct pt_regs *regs, void __user
> *frame, char *where)
>  	force_sig(SIGSEGV);
>  }
>=20
> +int dovetail_arch_setup_rt_signal_frame(struct ksignal *ksig, struct pt_=
regs
> *regs)
> +{
> +	int ret;
> +	if (regs->cs =3D=3D __USER_CS) {
> +	        ret =3D x64_setup_rt_frame(ksig, regs);
> +	} else if (regs->cs =3D=3D __USER32_CS) {
> +	        ksig->ka.sa.sa_flags |=3D SA_IA32_ABI;
> +	        ret =3D ia32_setup_rt_frame(ksig, regs);
> +	} else {
> +		ret =3D 1;
> +	}
> +	return ret;
> +}
> +
> +int dovetail_arch_restore_rt_signal_frame(struct pt_regs *regs)
> +{
> +	if (regs->cs =3D=3D __USER_CS)
> +		return dovetail_restore_64_rt_signal_frame(regs);
> +	else
> +		return dovetail_restore_32_rt_signal_frame(regs);
> +}
> +
>  #ifdef CONFIG_DYNAMIC_SIGFRAME
>  #ifdef CONFIG_STRICT_SIGALTSTACK_SIZE
>  static bool strict_sigaltstack_size __ro_after_init =3D true;
> diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
> index 9027fc088f97..a99318a70755 100644
> --- a/arch/x86/kernel/signal_32.c
> +++ b/arch/x86/kernel/signal_32.c
> @@ -145,6 +145,19 @@ SYSCALL32_DEFINE0(sigreturn)
>  	return 0;
>  }
>=20
> +int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
> +{
> +	struct rt_sigframe_ia32 __user *frame =3D (struct rt_sigframe_ia32 __us=
er
> *)(regs->sp - 4);
> +
> +	if (!access_ok(frame, sizeof(*frame)))
> +	        return -1;
> +
> +	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext) !=3D true)
> +	        return -1;
> +
> +	return 0;
> +}
> +
>  SYSCALL32_DEFINE0(rt_sigreturn)
>  {
>  	struct pt_regs *regs =3D current_pt_regs();
> diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
> index 13a1e6083837..67b52bcc5b5e 100644
> --- a/arch/x86/kernel/signal_64.c
> +++ b/arch/x86/kernel/signal_64.c
> @@ -237,6 +237,23 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct
> pt_regs *regs)
>  	return -EFAULT;
>  }
>=20
> +int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
> +{
> +	struct rt_sigframe __user *frame;
> +	unsigned long uc_flags;
> +
> +	frame =3D (struct rt_sigframe __user *)(regs->sp - sizeof(long));
> +	if (!access_ok(frame, sizeof(*frame)))
> +		return -1;
> +	if (__get_user(uc_flags, &frame->uc.uc_flags))
> +		return -1;
> +
> +	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
> +		return -1;
> +
> +	return 0;
> +}
> +
>  /*
>   * Do a signal return; undo the signal stack.
>   */
> diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
> index 70b78fd55d5e..3384437a4c74 100644
> --- a/include/linux/dovetail.h
> +++ b/include/linux/dovetail.h
> @@ -150,6 +150,10 @@ void oob_trampoline(void);
>=20
>  void arch_inband_task_init(struct task_struct *p);
>=20
> +int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs =
*regs);
> +
> +int dovetail_restore_rt_signal_frame(struct pt_regs *regs);
> +
>  int dovetail_start(void);
>=20
>  void dovetail_stop(void);
> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
> index 79fd75918b37..de220e90950d 100644
> --- a/kernel/dovetail.c
> +++ b/kernel/dovetail.c
> @@ -11,6 +11,9 @@
>  #include <asm/syscall.h>
>  #include <uapi/asm-generic/dovetail.h>
>=20
> +#include <asm/sighandling.h>
> +#include <asm/sigframe.h>
> +
>  static bool dovetail_enabled;
>=20
>  void __weak arch_inband_task_init(struct task_struct *p)
> @@ -447,3 +450,14 @@ void dovetail_stop(void)
>  	smp_wmb();
>  }
>  EXPORT_SYMBOL_GPL(dovetail_stop);
> +
> +int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs =
*regs)
> +{
> +	return dovetail_arch_setup_rt_signal_frame(ksig, regs);
> +}
> +
> +int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
> +{
> +	return dovetail_arch_restore_rt_signal_frame(regs);
> +}
> +
> --
> 2.25.1

