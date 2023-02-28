Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2095.outbound.protection.outlook.com [40.107.104.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754B2CA2
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 12:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvhYKhmwpI83XvCgGatlJBdwV5cfxfh8t6Za641PAfX/SUg9+XOhXY3A70ifX/lqYLnbOvfNeBrySOaMEegJJ9KKag/yVHh4uMI8UWT2GG5v2dzBPtUNyd+8BpqlaR3qN7opJvKdp6paCht/tSJnnn877KSzU/vbtGdklgU8HmAv/suT51phAc+sQXf654caKgXF8EmYzs9XQ35kYA2BomQ82on5rTBlJn5ChjJXisVMMNMPyXympUla0PAVjZh6R2FwQRqHMVolU1Mj4yoSVzrhSJX9WRwqCAb7z2iJe1p2eby02CK6RbLSAPMsxgSTxDqRb1pnCiaU+Pb5sl4HbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF2tWHT1e2RxsWJy/2bj6b4XJCfx7k+01MjmAdYWR5o=;
 b=IUtm1ODMwtEPrckTDycUx5aS43XgdSnb9JFZUFKTXpOoNiAgX1GHVKHcAjdPIQ/c/9kLLibsgVwW0zi+GrIoXVvQfAPxuWg4VMMeapp+YAt0IQFnRQxNGNse50vWz7vCfInujY5VDI0jM0zTxheID/o4bEuPoxAXlD+hNz9OHuytJYiS+nYRIXkz4U5kej3qlmSPQQLQwMS0rHOxiSHpbdrfU6TXuDrcwmlbzkyCFToeCwdNvh6Pqb2GZ9eQn4V/Dni7W2oB35GFJ4BfuZe0vjaLsUrM+AZqipSpNNRN4ZCQngbwmVFZlEV9YXHMyS9ujRvKVwMKpezfVc+rOd1IKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF2tWHT1e2RxsWJy/2bj6b4XJCfx7k+01MjmAdYWR5o=;
 b=EI1RS1pkbLyCqBKStZgAB6Myh+wI0wP6FW4LEjNdkZsbLk8pRZ+I/fywx85vrtoZFKb98s39xrk2GmeslXKi0mB/JNzkvzWcKkA8vgrEw08ySlP8tOJqKlFKlbp+95Qs2xya3mIgXKM7syl2LTZDJma0f09huHkW7g+dfiRzGC0=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AS8PR08MB8394.eurprd08.prod.outlook.com (2603:10a6:20b:568::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 12:09:41 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::f60:da2a:818f:e6d3]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::f60:da2a:818f:e6d3%3]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 12:09:41 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Jan Kiszka
	<jan.kiszka@siemens.com>
Subject: RE: problem while handling exceptions in oob stage
Thread-Topic: problem while handling exceptions in oob stage
Thread-Index: AdlHiSicop1W4d0MS2Gakd59UUNxuwBvFCkAACB33gAAaXhsQA==
Date: Tue, 28 Feb 2023 12:09:41 +0000
Message-ID:
 <VE1PR08MB490939225029D8A349278FDD92AC9@VE1PR08MB4909.eurprd08.prod.outlook.com>
References:
 <VE1PR08MB49090AD3D9BB287AFBD16EEA92AB9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <87y1olh9i4.fsf@xenomai.org> <874jr8vinh.fsf@xenomai.org>
In-Reply-To: <874jr8vinh.fsf@xenomai.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|AS8PR08MB8394:EE_
x-ms-office365-filtering-correlation-id: 113f4e49-86ed-4e8b-2633-08db1984ac0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rEjyCB0h/8FVXLXiICr7rSkHE0QJAllfoACW2XGiyS18n1tVlWEFFDOSanx97GPUdahbSu+KlQbGlJgDwM6Yqih6083p9j2ahwcv40MsqHObGeIf5l40VG569FjWK4xtzU8IsxobwhMDftP5LNvtNqjteE4NGNkqeeD9T2OyGvKxn5VoF60FZKqgp+pMY49/FwSFHwD65oEUJ9JDngxXE4J+A1qoSFgYSRd1xrLnkiWVNHsGOETOcSpAto6yJ5AzE2u/EIuRFUpgLVqd1SfNJmF3vL0zHGr0mMGG9X9xbGZb/BSjCaRPtPue5CJJeQZleUfJLeNkPwE8XPEF90bvzBvf4UGi5eNd1k//qmg3F9ITdwvyZNjWkkA/8SKsFbDW31h89qqhGzXVS517gpF82R04wCgpaodtMdJH9CYnc630mkhCPI9w+cjBC6lLOQUj2gaq9fxgkubdjuspHnd92lmy2AVIPOlIUMr2xN0dTTrLCFIvdUIY4b/Y7hivLvAmr5OalZUCIZGwpyF/kTyIg6rqjYZXtOfq+q79TCI9uKO2URNZtGh7TOqpHLgHh2WEo3YL9BzpxZGxubofGu2eMAkoDAck/8AT1vivrssOiVAEZVjfOwSsJDglfQa1CbHOgUx3OHVa8hM7EE99Z2Z5KdltBMYLwjQDrlTb24ceXPG7trmZTs6aMlVSx1knF7Lb5JlMzQnNJTZoM8r6MRJn1g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39840400004)(366004)(346002)(136003)(376002)(451199018)(316002)(83380400001)(54906003)(33656002)(4326008)(6916009)(122000001)(76116006)(38100700002)(66446008)(8676002)(64756008)(6506007)(53546011)(478600001)(9686003)(7696005)(71200400001)(26005)(5660300002)(186003)(66476007)(66556008)(55016003)(66946007)(2906002)(44832011)(52536014)(8936002)(86362001)(38070700005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V0XZ12u61DzI93zje6yHgVoPJOw5dMIV8jBa9PHnaDto0XM4dB2xyW1ewu6t?=
 =?us-ascii?Q?bJyCb4hM9o5FbHxnrmOQCShdX5xp85utNICuukkGb144QbJ+1bDejxWJUWEU?=
 =?us-ascii?Q?SU2CVL9DxdgGjr7GxDF/SWrBmfnmhGOLtF/XMQxiypFL48uHH62/x1y/gzwC?=
 =?us-ascii?Q?Ob5r7zOFVfkT3xWc2A9CW5IfcoPm9DwRmvIrrEOyqU/A8JxAgf4qGQXhSMUw?=
 =?us-ascii?Q?r6qtGRy7kibbAERmNolvHGRsDfkQ47cSsZttmMeNJpg4NxV3aPldV5/LbRqE?=
 =?us-ascii?Q?NK+WUKSJN3SZJsScMwC5Q+/El72eXYWgZ2Fe5W9qAOPWAMaffI5ykv8DtKs9?=
 =?us-ascii?Q?QstA6MlHiyWmkWtF2WCossivPc7H9a0vLNZTzgEn6P2Moz1hCDQ0KWwhXubE?=
 =?us-ascii?Q?/c+MpowUS2EiYgzwH8OxdfZg44WVecvNXNSDnANntzjRQTKnk2lOSqSVzTMP?=
 =?us-ascii?Q?cKdV+p8Rg1a6AKdv3VAtPa55tH5QX07P+jMa4GCHDuzmUn0kRCNUo37o32yw?=
 =?us-ascii?Q?wtQZlPTLRUDjE0fSHJWX7FAa0gox5EZqRSTHjojy+jRFhArWbABufHciXFc4?=
 =?us-ascii?Q?Zc15Q+YW9shYdi42e2a3FTcXiYZPSCL/uJFwwSpwf+vtPuXlc3e6Pjrtlzli?=
 =?us-ascii?Q?cvp4nx0VtVaraPuOQR617N4j2V4a/vJgGJP8FI8fL3QgFwNMuvDPBdilIueB?=
 =?us-ascii?Q?Kwzef7zPlqdW8tAjBlClZ8iTXIRs0nqtzQtqP0AnjBFDU+5G0e794ZsOWl+m?=
 =?us-ascii?Q?JKmsAASrGj4QRqmyz6SlODyflg5ypjsg/a6s6OShb1cK/zjDzLYYLWvg3Oop?=
 =?us-ascii?Q?aMs4jUP+eY/h+cPPHNlxKB9zqgKPYT/6A1C5T84MMGehB7k/dgwvO/hoPC1X?=
 =?us-ascii?Q?b1cOpGYHtLlXA1b5co0x94ufJldsQIDL6VJkS7a3+rOmz/S1KcJyAYVXF/U0?=
 =?us-ascii?Q?WulA6mTRWOuZjDfXOTfPWbqHbRmPtHfkGQ3pI7doALfOqScDR5i6t3yxTRv/?=
 =?us-ascii?Q?ebQJYhJSv6w0uTDzYgzr7OMHnlf2lO/bsCu8kkcSusUXDh4Wp4RFs7oX8bOe?=
 =?us-ascii?Q?uxL0/qHR6d34eGcb+tb6YMVYwkG6RVgxKRl368hflXRoEmvyXlnk3YySWjra?=
 =?us-ascii?Q?8Y9xtbbR2SXtHq0P7e21qnz+4WBFX+fL8LdSYImrFFfr94O8hU7R4PXzk0KM?=
 =?us-ascii?Q?+92ev9XFZYxWohrBt2tXFs5tnCrE8Y84lUPHSte93/olNoX08C5CPPXLftVs?=
 =?us-ascii?Q?WVMokyhtsuyBA2kpVpcdzDhkMLMQnXGi5ZSJ1b/oQnpZlHu/2QdkMMdyVZJF?=
 =?us-ascii?Q?CeVH3omdkMc4l8uQ0KejvdqOZe2eG4JZ0YQj0Wh/WWjKPt7zJyfh3IYT8xJT?=
 =?us-ascii?Q?QNTPPPHNsg9FGxk02ofZH4lGMMpFFhvmr3rUHUms/vi8TGqEsk+lspRLId/q?=
 =?us-ascii?Q?J1jNfcgJBZbhp3wiOLHYnJ66MGXh9Dg97BaEUIqrufwqBYwdi0H/BEpKq0JD?=
 =?us-ascii?Q?74GVbf4e6cxxZcP7BogM+GUpRQqrwr4BTiNbYYcKRxt4gLBMQU4VF/Kp67H5?=
 =?us-ascii?Q?1y0whv2uz/FWdLMCLks4iH0pFAB+JnI9CBcKeYthoOEhyqbW73o+u9vJOKyp?=
 =?us-ascii?Q?tg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 113f4e49-86ed-4e8b-2633-08db1984ac0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 12:09:41.5443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jg0c+gb3aFxzfmP+PqukhSgOWzyVrmzs/n+jekQGQuycAgA6WssP3hltB1Ik+GRtncytF/CfctPCkp9X1yv5jXpYagTrUxPR3J89ZAhoy6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8394

Hi,

just tested the patch.=20
It resolves my problem.

Best regards
Johannes

> -----Original Message-----
> From: Philippe Gerum <rpm@xenomai.org>
> Sent: Sonntag, 26. Februar 2023 10:48
> To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Cc: xenomai@lists.linux.dev; Jan Kiszka <jan.kiszka@siemens.com>
> Subject: Re: problem while handling exceptions in oob stage
>=20
> CAUTION: External E-Mail !
>=20
> Philippe Gerum <rpm@xenomai.org> writes:
>=20
> > Johannes Kirchmair <johannes.kirchmair@sigmatek.at> writes:
> >
> >> Hello,
> >>
> >> we encountered a problem, while handling invalid opcode exception in o=
ob
> stage.
> >> Our fixup code works fine if we execute ud2 instruction the first time=
.
> >> Upon second execution of ud2, we encounter the problem that our fixup
> code is not reached.
> >>
> >> The problem is that the first time entering the kernel, mark_trap_entr=
y_raw is
> called and in a subsequent call the _TLF_OOBTRAP flag is set.
> >> But because we do not switch to inband stage, we do not call
> mark_trap_exit_raw and the _TLF_OOBTRAP flag is not cleared.
> >>
> >> The second time we enter the kernel on execution of ud2,  we encounter
> (again) the following code:
> >>
> >> static __always_inline void oob_trap_notify(unsigned int exception,
> >>                                          struct pt_regs *regs)
> >> {
> >>          if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
> >>                  __oob_trap_notify(exception, regs);
> >> }
> >>
> >> Because _TLF_OOBTRAP is set and because we are still oob, we just leav=
e the
> kernel without calling __oob_trap_notify and subsequently our clean up co=
de.
> >> This results in re-execution of the same ud2 again and again.
> >>
> >> I fixed it for me in the following way:
> >>
> >> --- a/arch/x86/kernel/traps.c
> >> +++ b/arch/x86/kernel/traps.c
> >> @@ -414,8 +414,9 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
> >>                 handle_invalid_op(regs);
> >>                 instrumentation_end();
> >>                 irqentry_exit(regs, state);
> >> -               mark_trap_exit_raw(X86_TRAP_UD, regs);
> >>         }
> >> +
> >> +       mark_trap_exit_raw(X86_TRAP_UD, regs);
> >>  }
> >>
> >> I am not sure it this is a valid way to fix this issue.
> >> If it is, I could work up a patch next week that addresses all the pla=
ces where
> this problem could trigger.
> >>
> >> What do you think?
> >
> > That would work in the current implementation of mark_trap_exit*(), I
> > would recommend to keep the semantics of the mark_trap* pairs unchanged
> > though, meaning that no exit should take place if the corresponding
> > entry failed.
> >
> > Dovetail-wise, the inner oob_trap_entry/oob_trap_unwind pair should mar=
k
> > the start/end of the in-band handling of a trap, so that the core can d=
o
> > some housekeeping before and after such handling. As you rightfully
> > noticed, because such entry was actually notified unconditionally to th=
e
> > core, we should always tell it about the matching exit point as well,
> > especially if we plan not to do anything about the trap event.
> >
> > Something like this should do for x86 (same issue for arm64 and arm,
> > I'll fix them up too):
> >
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 7238f5c90b998..234e8ab84c221 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -174,6 +174,13 @@ bool mark_trap_entry(int trapnr, struct pt_regs *r=
egs)
> >               return true;
> >       }
> >
> > +     /*
> > +      * If the oob core did not switch us inband, our caller is
> > +      * expected to leave the trap handler immediately, so we may
> > +      * notify the core about this right now.
> > +      */
> > +     oob_trap_unwind(trapnr, regs);
> > +
> >       return false;
> >  }
> >
> > @@ -188,7 +195,13 @@ static __always_inline
> >  bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
> >  {
> >       oob_trap_notify(trapnr, regs);
> > -     return running_inband();
> > +
> > +     if (unlikely(running_oob())) {
> > +             oob_trap_unwind(trapnr, regs);
> > +             return false;
> > +     }
> > +
> > +     return true;
> >  }
> >
> >  static __always_inline
>=20
> The patch for mm/fault.c above is not correct, the following one is
> better, i.e. since we are still running oob, we must not alter the
> in-band interrupt state, plus oob_trap_unwind() turns hard irqs off
> unconditionally on entry and leaves them that way, therefore we can and
> _must_ skip local_irq_disable_full():
>=20
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 4b697ef4bd678..c7999b493865b 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -922,10 +922,8 @@ __bad_area_nosemaphore(struct pt_regs *regs,
> unsigned long error_code,
>                 return;
>=20
>         oob_trap_notify(X86_TRAP_PF, regs);
> -       if (!running_inband()) {
> -               local_irq_disable_full();
> -               return;
> -       }
> +       if (!running_inband())
> +               goto out;
>=20
>         if (likely(show_unhandled_signals))
>                 show_signal_msg(regs, error_code, address, tsk);
> @@ -938,6 +936,7 @@ __bad_area_nosemaphore(struct pt_regs *regs,
> unsigned long error_code,
>                 force_sig_fault(SIGSEGV, si_code, (void __user *)address)=
;
>=20
>         local_irq_disable_full();
> +out:
>         oob_trap_unwind(X86_TRAP_PF, regs);
>  }
>=20
> @@ -1401,7 +1400,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>          */
>         oob_trap_notify(X86_TRAP_PF, regs);
>         if (!running_inband())
> -               return;
> +               goto out;
>=20
>         perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>=20
> --
> Philippe.
