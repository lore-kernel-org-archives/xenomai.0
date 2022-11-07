Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED27F
	for <xenomai@lists.linux.dev>; Mon,  7 Nov 2022 17:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0BC2+qmJA1EoPdK9xpR0CYEN5DMnOg9O3qOmKoGeN5UxIAMUFe/4QWx2jW+z477SKMJKv+CKWuBoLWmQxPnr2J+UZXcgcaa4l/k+VfIomuvXsDPbHxLuJf7baXUSp75umfjby7v+wjRSdub9Xo9FWvEGF8MhDu6QiVpwdnjF1lNuYPEJ2v3emIC0BVZsdhzhvCSRW0wjvFWnoW7Cpkll4/D2y98dbZJ+AXWNlhm7tWEzMvRild/KZvtlIf+uN5OSmVeRrWBOwFujZWWCJigxPdfDMuzE7B1E4g2ZC9PcjC1aNSH95TbIbJLhQs8QCXi0S0YJdLeF5bJsE1r976ODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47JNiAnjIYj5y2n5CW7a7+63SFkCLojXdl6+VV6LyUc=;
 b=JPnpc7cGLPMGwkbf52XN2a88NrHRQ0QHI9BuaT9Lqaev9cOiLzvyukRYP0QeH7Q4VD4bvyAeZe/ChTMVuAr/Ir4uGXy6IJmE5YqXZ0YJy3k9+pPktmUbYpqyE14ISnTTH9kaK2LXUD+2SepjQD+IgT0K6H5YCaSAekJbLg/dS7dD08RHkvhwFC9sJZsUc4NMMfmT8quMk0JofegwU1BoHg678CExvQkP/oGb80nUrEXb5paMDHdJUp3FB7xzYJ2IroiET5VBuuGAbPIOsWQcS3E5qemwWr4ufS8Zn87lA3kQHvsWYtclKvnYqsKNV86RPi0QtTrboiZQ5PZwreZu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47JNiAnjIYj5y2n5CW7a7+63SFkCLojXdl6+VV6LyUc=;
 b=DGY7PZ5D6HThl+cfrhEEpsCcxW9ZbIpjX9TDxT2BNFznAMMkdHO50Id96YtTohKzbSwXhQWxgW+xq1UrPvKBP/jKv9m2J6nbRVyc98KXZMtYp6BDrbJwD/kJQsKfIDG/Eyex/YtVBHKTE3cLRm2oN+HPuC4kBMDZGN7y1YrcRpj5s2S+2L2ZUMpXfa8I/awlcCKLrLxU8yzSFwZ/ihD8lT0ZzwEqn12neeGlns4q2151hRA6z021lfri2HRV+N8tNa6YX9vYCMpEcQSVaHzLwR2r/YdTZeq487ODD3sr90FRuk2C1rQRFuPQZ0ctTKYE4YTAHXGx1/JM8TlY2yibwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 17:42:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 17:42:15 +0000
Message-ID: <3a80ab49-09ac-2403-8e1f-6e61e3726657@siemens.com>
Date: Mon, 7 Nov 2022 18:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH, 3.2.x] cobalt/x86: Fix FPU switch during thread hardening
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Stefan Heber <Stefan.Heber@zwickroell.com>,
 "Zhang, Qiang1" <qiang1.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a74bcbd-458b-4a1b-15f7-08dac0e768e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2fYTBT6fSbru+wSijLNBO6CrBu+i8iL2aipbEJd8v88WvV/sEJMsZaDQQoelxbz76HSfTKEjqqXcqmV9/KOeSgNJB5/6pU8+ynDJz+2xUT8xVa2JEcl2ZjcZ06Nq8thXXFr3spNzdSrvOq3vLKHaZO/rA+oHUIaw5jM1PAdiJMn8s22D98jK3SM+eGHz/Vcqip/cKP1Fk6nF3C+w0UfpeQdei3V4Ff6+17IURsQ6KmsQ0JmNoQFpiesMXoPoTwKF/bmr6BwxvnEqBs2kyU3PPhaCoBYbrUs3VYFFM22iNF2IQVF86JuSc17kGLza70nmNYqSNzqQg6Cjk3WJ1GNkES3XDZRRffoa2xjfOTmmOyDdBeyCd5z3dNgN5HVurgbU2lQeQ9+lGYRO8vXj2n8Xb32rncTjJ7xVZlmiHE+PFh80+RNRokXT5EhCbALaQte1XyReotlfFMQqmVsjrsm/D4DRmrm3TN+n+6eVAHbS0jrF9QM08u84IVhVfbm09gfZT1/biwmQUmEWrpn7g6s99d7tISXUSSh2gnxXNMb/TpQI+DMY2oawQNGYWLY1/AWPklaatzG/+wX35lIisjOPpnAYF4GzGYID0UGwU4pxOqCSfduLkEiECgF3o9ArtFWF0hvx8EIQUCQg5vZvsSs2/erG/gXaMKrLFd8UPd1baVusFyrjzRZrjPLu+V07F/jEWa/3iqCeYIN6oAkIC7tJI5e8sN7GK/lZhGJ10u+HP7Q5ZziL6UPbLyJcNk1t5I3hl/cBLjLHFoXrcMVBIA5DUQ6kEFjVZzv8+V4SouInxcI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(31696002)(86362001)(66476007)(36756003)(186003)(66556008)(66946007)(316002)(6916009)(8676002)(2616005)(83380400001)(4326008)(41300700001)(6506007)(26005)(6512007)(54906003)(82960400001)(6486002)(478600001)(38100700002)(44832011)(5660300002)(8936002)(2906002)(31686004)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE9Pdjc2TFpzQWRENUZCaHo5NXNNR0VsallDaFJWR1Rrb3ExQTdkdE5SN0JV?=
 =?utf-8?B?bzhEOUhkV3ZvTkIvbDZRWk42Y2xXV3hwTnhGR1RTQVNrYmYwOGkwSnpneXV4?=
 =?utf-8?B?bnpwUzBKL1NFT245L0VPbmtwUjJHclNqUnlxdFBheEx6OTNIcWhpaTdVSFJP?=
 =?utf-8?B?dnc4cTdWVGRVcmNjcVp5NW0xc2NETTQxSzVTYjVzKzJQVjh5VmpYUEk3eGZm?=
 =?utf-8?B?WitBS1pvTS9HbU0zRXpVN2lhQUxzTzluS1kwWUN1c3JBYjdwdzQzNnovSWNS?=
 =?utf-8?B?WUdWRHh3Q1A2MytnTlRwMFJDM05rcVZUeW56TlFXWEtzL1pnaDMzaXRKQlAv?=
 =?utf-8?B?YWtVZlBNNHhTMWxVMXN1L21QeUx0YTRsdUQ0SVNocWdUWGNIcW1vaUwzdUFB?=
 =?utf-8?B?bTV1R1VPQVNEby90ZVVRUSs3d2ZtMnpMcTRjU3JDTkVLcnVPcllwcHdHZndR?=
 =?utf-8?B?S1ZLTFE1d0F5MkVlcUNmS0Nqbk1MMjhPeTlMMzlOanBIeFFlYi9zQjNRazZO?=
 =?utf-8?B?RFM2ZFIrckZXVmNML1FhZnUzRnZyVi9ITnZpaVkremx4dDhCZFQrT00rZ29M?=
 =?utf-8?B?SzU3U1lUMjNEbCs0MFplMTFnNUcya21oTTZvRkYyaDVmOXZ4bG5Bd3dPVnBr?=
 =?utf-8?B?Wmd1Z2U2SlpGRjZsRUFkd2NCdUdnaElCMDJ3T3BvVkRXVjNyejU3ZDRoVzVW?=
 =?utf-8?B?b2JCZTExeWxVWExzbnVpOVJCbHJpbnJyVWx6QUVhTVZTbm9KcU1MRkMveWh2?=
 =?utf-8?B?Z09oaUZWTjZ5YWs1bWo0bUxrWFJ4S0YvYlpsdUp2Qk1aT3Y2dERGZW9WSXNB?=
 =?utf-8?B?L2ZwMzJ2YTZiZ05lLzE5Rk94RmF1V3EzZXJKS3d0N2YwdDU4WEZlRms5cGpU?=
 =?utf-8?B?RTNibG03TkFmWlRKN0lCd0JFRmsrNTNDUW5FbHhGeTd4eklSeStsekl6Uyt6?=
 =?utf-8?B?aDBiZHBmbGpuQlZLQTFCa3VndEtaTDRqTXBZK3lObG5vZE9ZOG5ENXptNHFH?=
 =?utf-8?B?eG9PY3k1a0JmcEFZMlJrKzJXU2ZtdEJsSW5uWWZySDZtM3FSNUlpZ1EwOGxq?=
 =?utf-8?B?RGY5QlFqWXBzSjJDTGdlN2gxNEJEaFl5TGV0ZlhlSnB1Qnc0a3QzZ0ttbFho?=
 =?utf-8?B?UU1qczVHV2IxaUVaTHF0cXkvZ0t2TU9wK2UxMVBER01UdzVqKzdHb2NDb1ly?=
 =?utf-8?B?cHBHVDlwL014cm03U2xTaXIyMWI0NXdJUEliMmdhQmcyblRPUXNZQWU4OE1a?=
 =?utf-8?B?SGpVNmZUa3dkdlVvK1ZjWmhUTEluNk51NVBqT1dLcG1mVkpMeklzTDZjbGdv?=
 =?utf-8?B?eTVsSXJ3MFdYVjF2TWRCMmljQVRDT2pCNk9qSDFFbFg0cUdNZm5SSzV4eXlB?=
 =?utf-8?B?WEd0emlLbDU2RkpPVXI5K0l3WTZ3Qkdlc2ZFMVNkMWtGWFYzTlF6RDFJWUNu?=
 =?utf-8?B?b0pHK2hpYStNbWlpb2w3ckRDVDlZaVQwMXZGa2xQNFYrUFB2QzlhUFhQU01u?=
 =?utf-8?B?WklPVTNCS3dEV0JSTi8rZkJzOGNsUkNnOCtScjBzU05LSDJmWjZndVVjSm9U?=
 =?utf-8?B?OVZ3cnR5ZmtaWVhyUENla2RiektPWHRMZ3ZESyt4Qkl4M2ZZMzhqVWJYSjFH?=
 =?utf-8?B?cW5lSmJ3bWlMb2UrbnV0ZUduYUZTT3VFWDd5N0tCMU8xYW1oOWhTUW51Wkx1?=
 =?utf-8?B?MUJ0U3Z2M0kvZFZiS3BMci9RRWQ5U3pFTENKUGU3NUtVNWdhRGxMQTcwU2ta?=
 =?utf-8?B?T05iMWN2VUNQM0p4VW9yR0tjdW9KUmZLeHF1bjhla1M5NW1LcENOZFFIbkhq?=
 =?utf-8?B?ZkxqMlQ0NFJKSWp2N2FRVzVnZnBGc3N6cTVaQ2xsWWhPUzBGYlRUTUF5R25p?=
 =?utf-8?B?c090ZjZQMDdUZGZTSWZrcjhxcFFGOCtPTmZNYnBubm94Z3ZLYkhkNzNPbWlt?=
 =?utf-8?B?T2xURmkvSzRvOGpwWXlQeUhaV1hObENJTWNBOGdCZlEyRGRDMUJPVElEek1U?=
 =?utf-8?B?ZUVudzZUQmJUdEsxMzI2YTJtUytUMGlZdVFzTnJEZFR3cUdTa1VYdy90QjBx?=
 =?utf-8?B?bWx4a2RRS0hMVTZEWDdoUjljOW5kcVhmODhLNmQ2KzhURWlxU2Z2MEhxSnhu?=
 =?utf-8?B?R3ZmTTBwbHY4RW14Y2YyQjQrbW1kbnZmR0h0WDRtNGUzUVBaVTJ3WktnWXl0?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a74bcbd-458b-4a1b-15f7-08dac0e768e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:42:15.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/dF5HkK0zBS10otJHNO44zyXRKF3SoRVEaWn8VKJ3Hcla8BR0iq9D4PxARggYWmP9ZqcIoGrMj6wz8jmIN9ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6963

From: Jan Kiszka <jan.kiszka@siemens.com>

The current place to account for the missing call to switch_fpu_return
when returning to userland in primary mode was missing one case: the
switch-in of a thread while migrating from secondary to primary mode.
Move the logic to xnarch_switch_fpu which is also called in that case.
This also avoids having to deal with NULL xnthread_current.

Reported-by: Stefan Heber <Stefan.Heber@zwickroell.com>
Fixes: 608c23297c4d ("cobalt/x86: Account for FPU changes in kernel 5.2")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

A similar fix will go into 3.1.x as well.

 kernel/cobalt/arch/x86/ipipe/thread.c | 54 ++++++++++++---------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/kernel/cobalt/arch/x86/ipipe/thread.c b/kernel/cobalt/arch/x86/ipipe/thread.c
index 7e28903a42..46c47af890 100644
--- a/kernel/cobalt/arch/x86/ipipe/thread.c
+++ b/kernel/cobalt/arch/x86/ipipe/thread.c
@@ -209,29 +209,6 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 #ifndef IPIPE_X86_FPU_EAGER
 	stts();
 #endif /* ! IPIPE_X86_FPU_EAGER */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
-	/* 
-	 * Refresh 'in', we switch the stacks. However, there might be no
-	 * current thread at this point.
-	 */
-	in = xnthread_current();
-	if (in && !xnthread_test_state(in, XNROOT) &&
-	    test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		/*
-		 * This is open-coded switch_fpu_return but without a test for
-		 * PF_KTHREAD, i.e including kernel threads.
-		 */
-		struct fpu *fpu = &current->thread.fpu;
-		int cpu = raw_smp_processor_id();
-
-		if (!fpregs_state_valid(fpu, cpu)) {
-			copy_kernel_to_fpregs(&fpu->state);
-			fpregs_activate(fpu);
-			fpu->last_cpu = cpu;
-		}
-		clear_thread_flag(TIF_NEED_FPU_LOAD);
-	}
-#endif
 }
 
 #ifndef IPIPE_X86_FPU_EAGER
@@ -443,15 +420,32 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
 {
 	struct xnarchtcb *const to_tcb = xnthread_archtcb(to);
 
-	if (!tcb_used_kfpu(to_tcb))
-		return;
-
-	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
+	if (tcb_used_kfpu(to_tcb)) {
+		copy_kernel_to_fpregs(&to_tcb->kfpu->state);
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
-	/* redo the invalidation done by kernel_fpu_begin */
-	__cpu_invalidate_fpregs_state();
+		/* redo the invalidation done by kernel_fpu_begin */
+		__cpu_invalidate_fpregs_state();
+#endif
+		kernel_fpu_disable();
+	}
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
+	else if (!xnthread_test_state(to, XNROOT) &&
+		 test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		/*
+		 * This is open-coded switch_fpu_return but without a test for
+		 * PF_KTHREAD, i.e including kernel threads.
+		 */
+		struct fpu *fpu = &current->thread.fpu;
+		int cpu = raw_smp_processor_id();
+
+		if (!fpregs_state_valid(fpu, cpu)) {
+			copy_kernel_to_fpregs(&fpu->state);
+			fpregs_activate(fpu);
+			fpu->last_cpu = cpu;
+		}
+		clear_thread_flag(TIF_NEED_FPU_LOAD);
+	}
 #endif
-	kernel_fpu_disable();
 }
 #endif /* ! IPIPE_X86_FPU_EAGER */
 
-- 
2.35.3
