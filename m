Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BD312B6A
	for <xenomai@lists.linux.dev>; Thu,  7 Sep 2023 15:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivf6erehfM5U5gvDSTtE3n93M2TOaVZYcACECjXBok16Za4qWD1EcUrM3kfGFy1YAOihj2rsXVC71pevH51c5e7zUb14q7+M+TUTKnPsd8jNawZzTVV0WThTOS5wsf7tZmRpVDECxw7tqrgGyncn94bp+TVDM+Ow+NYycfZ/FkFoZMeczGWeCJN8+3AItAat7uQshqnhfA3hMETGc0uADQSA3OsobysBeLtItxzVu/piNwaRz7ekA/os7fJWn8oq+rcAb2b4quij0PknUO2p4lgcsjylIdXty98m1dqlW5xZ1mMCS6VT1wNTJghUnaA/ACoHOn6ElMNqcH6t7NhAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E1r4sGs+iE1gB5QwSlvsXd/DFdXwDzGJNrsV/No1Wo=;
 b=JXzilWmWDaRd4S69JVKek1SjwA2+zun6CEPVgsE+UODPIUGXXiuF2h11P+wSMLYMl+oWLVN1we5CmqNHcvQLr1PxEwGceuOhKowQ3H0NyFltEISJSj4GzFD5itthnwQsJ+Yaw+yimmDvlDgtWJvdmPDgyBs31FTSRHSEO8EsnR9HEm2MPyD4K60HdI9KHy2CZ0x5X4kSrXEbiE5P4uGQ2lrjAILK6RDH9JEheXBig56VfQiZxDEju/5Mad0abJ6BmoHY7hN5aWHh31/svVpzRmJPqBr8PeIRAq86lDpGT9qgEWEZ6S3fMFrCrTelaA6YdyIbTdz/+AE8BF6eMSVAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E1r4sGs+iE1gB5QwSlvsXd/DFdXwDzGJNrsV/No1Wo=;
 b=MpZakLSh8O/SvNH4lFKIG5iwm+D/z+rT2B/z7o5u08wpNUYXz2HEraNCUwMxawewfYPz4L+TZGFopvaBgHVPpkWfptnlBgMt5hnIJ/0h3tX2gQfBNoczyx9DsH+aYgfWmUh5Oz5Au/dGW/6P7Kij6lAj+WvKc+9x4QvciZQHAnFI4BtWFIxzFqfi+dJGxn7Pz31+gKdb75xSRLkE69XXH4DWhbkTlhK3i5we/Ap+GFpoqrHRsB9jbAn47KFDK3sM2iQfiG0d+4+gKbTVmcgDqAdMCdrWGX50t8HfJ2IudTSwfP3Mfd6Xdtn6cGUXH5jTniMacnuxReUZ/eoy0NRNEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:499::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 15:33:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 15:33:42 +0000
Message-ID: <a59cde89-8bf6-4f94-814d-20c3456cab05@siemens.com>
Date: Thu, 7 Sep 2023 17:33:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH v2] x86: dovetail: add dovetail signal setup function
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:610:32::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 581f3e51-d2b0-4df3-1e17-08dbafb7d0e2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 YHyBXstCXTiHQcl0it696UM/piTGLRrQ2VBh1N9trqt4aRzhviAA6Y3Gm/na2GMvmHhhxcPuugaCC2uFFjRodZ2CVEEkKAJV9d/dBdWNzzfw5iq7j03JXiOFfjuXreP2V5qgn3gGNvFcwgrazN/7VImhQeewumParyeHmCVndA3pKKRFCzIaUplacE3SVEqv7Ir3qMwG4lzpla+CFwOEiyqiAqKtMcU9R2Vt7FSBkiufbEqbmYQF7TuEGTdxYW7gASQ5jc7DimDTT//IJEI5ej3sj+x5UCkXR0MFwrBmpQ2h6RMwt11+zc+WmMw0Iala1I9NHN1z9cGuH0JhEzh6LglC25Qks1Y3JW189UwAV8c2s+mLqNSRwD4b7wUurBQCq4o+kcBI1rYNH0Mp47v5cVi2rAaKpy3rgpnV+9Tv1Qy7l/Jx/Pn5LmFKb71yUKUFPUvibTwzGAhy4yaBL11YBELe7uy6Nxb3rcjCyZT3toRxkUOqiwQg9HDSxryx6w1C0Tn7nOuXSXWrTGkd0y64Lv7HwjHV428E3nV+iTJHmcGLgHFWm5rTc1ocFBKBhTWHIM+Uh9qTqSz/HvmwjDS6ElBJNZnuka57xE4z19/t8iEF+gwyLmT/AkA9LmNhQm7KoDJuzQfQyLVCU87YHS6nzA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(186009)(1800799009)(451199024)(2906002)(83380400001)(110136005)(6506007)(316002)(66476007)(6486002)(66556008)(478600001)(6666004)(26005)(5660300002)(66946007)(41300700001)(44832011)(4326008)(2616005)(6512007)(8676002)(8936002)(36756003)(82960400001)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TmxDZXFiS2gxalRlNlRHRDJHM3dadUNCZVNjRURXQVplc2czSTUwRmxsTDF6?=
 =?utf-8?B?RjNUUzFMYk43ZVR4eE9DMUlZSmxFSVVuZXBXQURFRHlpOUppUU1IKys5cGZG?=
 =?utf-8?B?ZWNaY1laZjZWaElXTGc0VlV6UlIxVUNRd2lpNXN1VlRQQWZnMUIzNkNVREdS?=
 =?utf-8?B?SW10Sy9XcmM4NGl5aDhnT0kvZHgycndhNjlDN1p1Tk9mS2VCUTdYQm5Yc2Y3?=
 =?utf-8?B?QzA3NXRIQWVjc0V4amRUcFROTUdOZ1V4NVpmOEp2TkZ1YU9tRlB6MGRlaFF5?=
 =?utf-8?B?Z3ZPbVg3UnR3KzExKzJLS1ZPczdtSXRTUnlyd0dDV3o0WFhSc29QRkczS0lG?=
 =?utf-8?B?S2xjZTVZUzNFYU4wOWEyWG95d09jNm1EQWpGT2JMNXVDd3VtbmhHRWhOZENR?=
 =?utf-8?B?WnRmL1MvbC9nWjA5a2NScTZJcW5yR09GRVZYUWQ4ZFBKWEhQdmFyNStZVk1R?=
 =?utf-8?B?NHV2K01lOG1CcXBabndtOUpGSVd0aUJSQ1BuYTRKa2ZpNmJnNUZISkNvMUJE?=
 =?utf-8?B?M21TWjF2SVZYZDFMK3NsWTFJOGtDZExodjhlVVc2MzNiS3NQQk4xZFFKckhs?=
 =?utf-8?B?akJZNzNXc0t6N2txNHRFUm1URGNua3dORWUzK1ZFWW9iUVRKWGdzUkxqcUdq?=
 =?utf-8?B?OEM3NmdQVGJ2cTh4bzBQNEZiUVk0US9QM1V5dTRFbjVCb0R2UTBMUk1adDVi?=
 =?utf-8?B?WThoNVVTVU5xLzdabUN4RnlUdmYwdXhEK0VwdTJZejJ1NS9ocG5lRDNNNkEw?=
 =?utf-8?B?YlZWNVB4VUZrcmJmaFlRZTl1ek1sZWluUEd1MUk2c0NTU0VueXdiNmt1Zzg0?=
 =?utf-8?B?VXlyZHUvRjRyREdUd1IvcEJ3ZFJzRjJlZkpMNkk1MyswdHFzMTFWWHdTeCta?=
 =?utf-8?B?Znl6T2hia1ZTcUlhZnI2VS8rY0MxazJmODBEcFh4V1d2RXdqNlRIRmZCeGxD?=
 =?utf-8?B?VGRhMkpSWmZBWXFXSE1lRjhuMlBWS0tJVHZ5Q0pZekt6VFZYWjdlZjRQdWxu?=
 =?utf-8?B?aTJ3TkZ1TU5PRjBQSm9nYjVXaGl3SHVhVHV5cEE1SHVIYjVpMk5Wb2xVbWpC?=
 =?utf-8?B?NkJPNy9YTldnWGlHd3QzL0cvazQrOC8yc0lHeGRERVdlNmRiekRJVFJqc1kv?=
 =?utf-8?B?OHBKRlMveFpPaXZkOXg3UDJzbitsZ1RpVkJOM0M4WEphMmdXR0htZUt4WkxW?=
 =?utf-8?B?QjFXYnc5SnJEdzluNFh2c3ZUVkpNWDlWRW15T3ZDcWFSRUxzOXVKTWZoUXFS?=
 =?utf-8?B?c09ZWHNXNUwwZmdrd0xUc3B1cVNISlV6TTB0SjN2bW9GU0VDTUE0KzlLSVVa?=
 =?utf-8?B?blltQWFLMjE5dkI1dGQ4RklPOUJxZDhWUzhxZWFlZHlmN2hHT1IzU2hvVnJp?=
 =?utf-8?B?UWptczNLQ2NYMkExdU81dFlVKy9kUEh1NEg2QytKWFovSUk1bk5QdWE4Ymo3?=
 =?utf-8?B?eGpnUXF0MWJhQ1FzSWk1Qkt2bmJKTUZvRm9VQSs0cUVrSEpqMUhQWkl5d0FF?=
 =?utf-8?B?dmpSdlRsb01DNXZiRGlpU09EUTBkaGlRaHVkTzBnazZZTHU4NUo3dXpKL25z?=
 =?utf-8?B?K1N2MmhnTWJQOXZCQWJ4aWlDRllHd0RnOWd2b05GUFVLNzlCRXlobTJ2WVpS?=
 =?utf-8?B?N2M1YndFcThVbjRTUElENTN4Y05kdEFyaDFlWmlSNDZiZlVCYlRlelFjVTdj?=
 =?utf-8?B?Q3RnV2YrMXdvNVBqM29EdU92dGVDZWIvVFk3UkQ5RklxS2V0Mzl1dVRNUGt2?=
 =?utf-8?B?bm5hTXJZa1NlU01IVUJWOGswc1NxeVpZWmVGNmVRSklNZGE5cjVhdjNQSFFC?=
 =?utf-8?B?cnlMQ1ZoV1p0UTVzMmJLRkJDY21NNW9vTmlBUW9tNllRbWMvSVRHVTdGTUR2?=
 =?utf-8?B?Q3U5N3UyVUlub3BmbjFaMkNQTzVIM0Fzd2VWcllYWk5rdWhmd1pnTEZ6Q212?=
 =?utf-8?B?dGk5Z3hRRmF6UnIvTStaL2pWYnFzb2VTdU5wdkJjZk1Hc0lNelU5Slp1cGcx?=
 =?utf-8?B?T1NKSzQrdG9reWgyMC9MbERTc281ekVjamlwWFowVWJiM3ZzZm9XNm1qcHZY?=
 =?utf-8?B?eExoWkhlNnlZb2ZhTmYwZFZyVFYzM1pkNVdqM2Q0MTdjWmdXWkM5ckR2Nm9z?=
 =?utf-8?B?R09pbzJ4NFRjblp5cU5POWRSQ0VzdEU5SnRNbVYxN1dDT0Z4TXJYSUQxVmxz?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581f3e51-d2b0-4df3-1e17-08dbafb7d0e2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:33:42.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ifh+cNdo2Kti7Gvu8jvZxN6Z67YRqCtUTTWEB9mLEYmy+aZ5bVGW+01YrPb1Z4pqPzF+33P1l0PvNl4bZMiAtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7680

From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>

add an interface to dovetail for signal frame setup and restoring.

This is useful for implementing rt signals within Xenomai.

The interface makes it possible to use the setup use functions provided
by Linux.

This is just a proof of concept using a very naive approach using most
of the code provided by Linux to setup signals.
The patch should be discussed, especially considering if using the
Linux functions is viable in a rt context.

Also to discuss would be the interface itself,
for convenience I used the kernels struct ksignal for testing. But maybe
we should maintain our own struct, that is not that feature rich.

<missing signed-off by Johannes>
[Jan: moved everything into x86, fixed might_sleep issues, return code massaging]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Philippe, this is not yet final, but the question is already if we are 
at the right abstraction level with this - and if the EVL core would 
consider implementing RT fault signals on top of that as well.

 arch/x86/include/asm/sighandling.h |  3 ++
 arch/x86/kernel/signal.c           | 71 ++++++++++++++++++++++++++++++
 arch/x86/kernel/signal_32.c        |  2 +-
 arch/x86/kernel/signal_64.c        |  2 +-
 include/linux/dovetail.h           |  4 ++
 5 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index e770c4fc47f4c..ed6b7fcd72503 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -24,4 +24,7 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 
+bool ia32_restore_sigcontext(struct pt_regs *regs, struct sigcontext_32 __user *usc);
+bool restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *usc, unsigned long uc_flags);
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index cfeec3ee877eb..fef321d6c7664 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -408,3 +408,74 @@ bool sigaltstack_size_valid(size_t ss_size)
 	return true;
 }
 #endif /* CONFIG_DYNAMIC_SIGFRAME */
+
+#ifdef CONFIG_DOVETAIL
+int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	int ret;
+
+	pagefault_disable();
+
+	if (regs->cs == __USER_CS) {
+	        ret = x64_setup_rt_frame(ksig, regs);
+	} else if (regs->cs == __USER32_CS) {
+	        ksig->ka.sa.sa_flags |= SA_IA32_ABI;
+	        ret = ia32_setup_rt_frame(ksig, regs);
+	} else {
+		ret = -EINVAL;
+	}
+
+	pagefault_enable();
+
+	return ret;
+}
+
+static int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
+{
+	struct rt_sigframe __user *frame;
+	unsigned long uc_flags;
+
+	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		return -EFAULT;
+
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
+{
+	struct rt_sigframe_ia32 __user *frame;
+
+	frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
+	if (!access_ok(frame, sizeof(*frame)))
+	        return -EFAULT;
+
+	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+	        return -EFAULT;
+
+	return 0;
+}
+
+int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
+{
+	int ret;
+
+	pagefault_disable();
+
+	if (regs->cs == __USER_CS)
+		ret = dovetail_restore_64_rt_signal_frame(regs);
+	else if (regs->cs == __USER32_CS)
+		ret = dovetail_restore_32_rt_signal_frame(regs);
+	else
+		ret = -EINVAL;
+
+	pagefault_enable();
+
+	return ret;
+}
+#endif
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 9027fc088f971..dc8d60378e75d 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -74,7 +74,7 @@ static inline void reload_segments(struct sigcontext_32 *sc)
 /*
  * Do a signal return; undo the signal stack.
  */
-static bool ia32_restore_sigcontext(struct pt_regs *regs,
+bool ia32_restore_sigcontext(struct pt_regs *regs,
 				    struct sigcontext_32 __user *usc)
 {
 	struct sigcontext_32 sc;
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 13a1e6083837a..d24845ee6a8de 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -47,7 +47,7 @@ static void force_valid_ss(struct pt_regs *regs)
 		regs->ss = __USER_DS;
 }
 
-static bool restore_sigcontext(struct pt_regs *regs,
+bool restore_sigcontext(struct pt_regs *regs,
 			       struct sigcontext __user *usc,
 			       unsigned long uc_flags)
 {
diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index 70b78fd55d5ee..3384437a4c74f 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -150,6 +150,10 @@ void oob_trampoline(void);
 
 void arch_inband_task_init(struct task_struct *p);
 
+int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs);
+
+int dovetail_restore_rt_signal_frame(struct pt_regs *regs);
+
 int dovetail_start(void);
 
 void dovetail_stop(void);
-- 
2.35.3
