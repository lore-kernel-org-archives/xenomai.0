Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDADDAB
	for <xenomai@lists.linux.dev>; Sat, 23 Sep 2023 09:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuRgr0NFtsrhF3CjwqXI3RjaqXhA8gvn2fyxx5krk2ONs0IyZe6kWCWyNUjc2oXYRP0tqYp7m7NsrL1ysFAGzP7gcePkmL4W/N3ALllbzsgsmiddpEJCB9OFaaZWHk6pjzzNOu9Wrh/F5J0kkfZqkZkm54NF77HRBdxQRqsVlpOt+IX2j/rJVdXmXImm2Lrpl+08PcaKQtdFaUX1K+oqLTFui09bd4VqScfo644hw1FjvSEO2QHE/kUC/x8Z2iFV8xu2ECNvgGsQNkQlpqU8lcPwAJrbFaCjnq47X8nr7R35FXcTJBUcw+Ep87jFxAregB52mVU3GiaRuVv+9nyq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OWEaLzVC+M3Ju3KeI0NO1/J3c4g5WMVxTbrq7Pk+90=;
 b=LxACPjnV2jK2CdRXcskR7yGKwhtQakzS9cF/3Khl9cUTtWICYcbLSCly6RSYxGUIs/eQcQNOvb7EbpfQLAAhVCB2CK0BYB9fLRnZEYoc158xrG6NsPLCFP9baiVF18hl+yZoISrp6Z6wgccfyZnacydqM1CEPsWiWBTovwxmeYVhQRHGWIq/GBi0/vFrJOyZwYd7mKsjb4mnhwZ77+erf9/jnNkp9FfjAFknwcnIs2seLjbyLkvelvFpuoZPDRm5L5guLskvKhloOszu5Nv6rz33EO4hB3oU7X7Yebs+TPSTdjEOgbUfs0Cmq8KWeNArLFt5zD8V/KrXQWgJGWrlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OWEaLzVC+M3Ju3KeI0NO1/J3c4g5WMVxTbrq7Pk+90=;
 b=kqaeV4aJssLLiWtYBSxxqhJRzNkJw1NQQJp3bfr5oeNcA0ztjp9L7rRRbT7u+LL1DJq5WTiPufM+l3Sj1Zd93mGjn0r/9QckUl0/EnvbUgoalL3NeJrU0h15TMNnN6JpNv/TGt7+ABicz4laVdHpRz0rNZzNZWuI/S+87uw8PDe9Y+eVnvv3be2u54l9TWMdsKq0uHzLzTSelZzQNeAZNJ+VKCioDU+gGqN0GuOzfbwJ8RI0EZLGw3Iz1lT8tiNAlPV6QNUbBDgnsYNIUHNKDOfULXv2D92L4VZh4++1qd2kYnp+jhrSqH8vnXw9O3MOAFDGXfVqhGilSmYqcy3bnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 09:56:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 09:56:19 +0000
Message-ID: <20586e6d-090b-4cff-b616-e637f2e4d9d1@siemens.com>
Date: Sat, 23 Sep 2023 11:56:16 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail 6.6][PATCH] x86: dovetail: Fix Intel shadow stack support
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3766:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a643e91-0764-4ef9-101b-08dbbc1b55b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kanuq8N4UGy981o4j5l8BE3iKYKvLNzKG/6zu2HGh0SjXFi1P2OeeFVzsUK9dMz2Psgo/h8VYR7DEB89/h8rl/AhO7wacWC6d2IlgwTFrxFv0bOOSroXPiHjK2nm2Ch0oFY8ALsBgD5po++RFoVZPAonLmf4ByfIdOI7T7yJbUO6MKSzMXX3ccLr1+psGI8/UhbBhxe4726faCoGTIs+xUtOLAAh3ruEU9ohDAs9e+2E1VAPhzUrGRNkzwJgIB+QE67dK1IRog8EpQJw1ArMigzU2qx9xZiY/lBMhEyZFmG5R7K2xlxGfIHFIxz3G+ipiaYJTmwcflbVM39Ozzz3fk7uCucOglDy99SPpXnYgtY5UVh4oFSqmc2OJTIf5GL+TUuMmL5iY3AuEX0O+SXEgDHhmPbBA/7kkRULbPhRxiruW7cNDGn84XA+4GBqLMV5zSwWg3D8YZZ3BF7lsrmuWYqbzRT0SZ6HDthIwzVD1TghNPkgIm8UVLCfX0H9IDWyTLvPdQGAnrPuG9FKHzUOw63rNPp2lAR0I36g2UMOXDDRUmPTyGMyorwAiOgV76HVhY3ez73pZB5I+RxcXnnU4ENXuc+Odgu31PFqhaU9ES3B4GhyZZ8Won9jh9WGd6XbmftInWGk3NyHJoshsphDew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(6506007)(5660300002)(36756003)(38100700002)(6666004)(83380400001)(82960400001)(478600001)(6486002)(2616005)(8676002)(4326008)(8936002)(41300700001)(26005)(31686004)(44832011)(66476007)(66556008)(66946007)(31696002)(316002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVIyNGd3WFkzRlBYUjRpclhmeGUxOS9uWUZMaVcyZzB4dGY0N1FQeEt6NTJQ?=
 =?utf-8?B?cUhnSU9Fa2l3L1ptQmQ5RithT1hZbkFFaDB1WCtJV2liZTRmRFJURVRiSFZP?=
 =?utf-8?B?bzdhTjhUM0prN21qR25hQVg4eUxoRVMzanJGeXlhU2grTWZHMjMvUG9RRUx4?=
 =?utf-8?B?TU5YS3FSTlJGS0lXMnZROUlpWTFaek9hTCtSVWlLMU9BS2lhblhISUNLTXE1?=
 =?utf-8?B?aCtsd29FSHB6OFU4WUZkYnpZUTl6cHFXemlyNHlDVXVWYkVMRTcxcW8rT25Z?=
 =?utf-8?B?K2NLM2VvMFBkQXZpbE4wbG5pUWxhWnl2UkVwTHFLQU9HaDg5Q1IyQ1BnUGE1?=
 =?utf-8?B?UTE0a3A1VkQyRXdzQkFIeFp4bDY0VnAwa0dOVFlnNW5mUlJlM2wrcGgrNmcx?=
 =?utf-8?B?VHF5UFVxTXFYNjZITUNKMmpkNXdCdkhRM2ZTdGppRE9lV3pxVFJNQ05pamo4?=
 =?utf-8?B?bmM5Wm9ETE5CVEcxVHdVTXdScm5iVDNZVndMZ3ZUcHJrN1ZsN2M4ZU1Md245?=
 =?utf-8?B?R05jdE9QdFdodXJTcStqaDNVRk9UOFZjQU9NdTFlY043NTB3eE1lZEp5bDRG?=
 =?utf-8?B?VnVYVGsrWnp6MXdoTFlnMzdxaUxKenB5cHFBU1FUUkJGb2RQTktWUTVvcWlw?=
 =?utf-8?B?cXcwMVBHYlJOZ0Q2dnFIcnRMTVBaM1FtRUlDR2E1WS85cVlLMnNwRjV0ZFFR?=
 =?utf-8?B?cEMwMzRtS2dqS2xlRGFnWDlYWGFZMkFOUHhiUU1TbnozS2FIU0tmcWJkb1lm?=
 =?utf-8?B?TzJKR1ZDc3g2ck9OQkpjdkRyRjFqRDlYQ3pJWEtETHNQK2lJelpCY29NeHd6?=
 =?utf-8?B?eFczVlg5cEFUT1o2d1FWcVlZRklCUG90UGdwU05WUTJPVk42UkhFOWFsQ0R2?=
 =?utf-8?B?VmhPR0lFZ0JhM3lFalhNa3NrOWVmbE9aaUNLdXA5bFVDenBFaDJaREVYZWU0?=
 =?utf-8?B?VzBNVjM2UG9rNnBzbklkc2Q5V0dCUzhvR0lTUnp3a1dkZ05hY2J6b0dJaWhi?=
 =?utf-8?B?QkZNVzlSVUl2bzlLMWk4ODk3K25aZjZLM0krRlNYbmY3WUM1WXB6QnNSbHky?=
 =?utf-8?B?Ny9aWmhNRnNEalVETHVQSnRvZ0hwN1NCdk16WVZubmJ4QXVtTG9ERUF3azZM?=
 =?utf-8?B?MDNsZVJnZ1p4czNRZ3hRRnBYOWR1Z3ZMdGxmbHV0c1VkZmNKYTRmckwrblZo?=
 =?utf-8?B?cjBQdkc4NkxyeWIyYlFVYWY4Nlp2RG8zZWNZblVobEtEOVBFZHZPOWpqSklq?=
 =?utf-8?B?bGwxU3g1amJEYXlManNqQ05obXN5NUxlVVpobDJ1YVRXUm1GWCtGU210ZDV5?=
 =?utf-8?B?S3V3VjR2SlJGdjNYL3U0QTFhZlhFRHVHN3hjdVRDUXNpT1pBWFVlVm5qUVA2?=
 =?utf-8?B?UHNKL05iZy95dVZOY05NbDUxSDM4OEtKY1pNWkNZcHpSVGsxMWhPZmY5VGdn?=
 =?utf-8?B?UUZObEora1RXSW1EZDJta256K1ZVSk91cEdWT2l1M3dNYy9LZ0UyeklDRS9S?=
 =?utf-8?B?YjdSYmdBZjAwcFpCS1o1MFJXR04vMVM5aGJia2lKbXNSN3VtOEt3MUR1VXoz?=
 =?utf-8?B?N1Zka2lpN0tNa2dlOUFzQjZRaDJCSlNVK3ZxeUQ4NFd3eXUrMzAyRXhoVzhu?=
 =?utf-8?B?dFlwWlhvVVJvYjZKamhRcjkxTVMwOG9keUltWi9kNXdwUElrczVvRmVQV0Zz?=
 =?utf-8?B?VW53VzlJbWpwTGFrSm45aTQ4YkltVHcyajRMMHJ5NEZVMGpTN0ExWFlrY0Y2?=
 =?utf-8?B?MGhpWUw3aDdzZDFyRmNuelJET0xVNHg4NE1QY1NFa3VzaFYxN2lkRWU5RGlM?=
 =?utf-8?B?Uzk1YWxtakVDNkxEOXBEZDNqRHFJOE1VSEJoSjJNdXRSVk9lVUU5L0FOWnVC?=
 =?utf-8?B?dUZFK2w4b2wydUNVcnZtekMrc3NzdTY1QnA2TDM3SkZPekVPSU11YjlMSkZw?=
 =?utf-8?B?NXY3SlhTVkMyb0FLMDZZQXg5dWVJeGtUZ21IdU83Mm4zSHhVOGIrdkM0azFE?=
 =?utf-8?B?VjAzemhsc1hsUUVXNGxSYStHWEVSS04yUVdWVUJ2VHBTR3NBOFM1ZmF1TTNy?=
 =?utf-8?B?QzV0azFUbXUzekkxUmJKUGg3Y2czNVNSRFQxajlsYVR6ajdsU3o4TDJoQ05s?=
 =?utf-8?B?YkYwUTRodE5JOExGR2h2TTR1QUZwMUI1Yng5VHdadnZoblErVU9BaU03b0dW?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a643e91-0764-4ef9-101b-08dbbc1b55b8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 09:56:19.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOEgnv/V3ZrDiGG7U2dPAvJxmUQChQCYgQ1ZisHEIJ5lLMdNOYFEYbsOd4kfvfFaqzW7HCFSW3IIScFHijoDNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3766

From: Jan Kiszka <jan.kiszka@siemens.com>

Let fpregs_lock_and_load return the saved flags of fpregs_lock and make
sure that the shadow stack callers use that properly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/include/asm/fpu/api.h |  2 +-
 arch/x86/kernel/fpu/core.c     |  8 ++++++--
 arch/x86/kernel/shstk.c        | 31 +++++++++++++++++++------------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 84ce78d643792..0cd5f7642326f 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -98,7 +98,7 @@ static inline void fpregs_unlock(unsigned long flags)
  * being automatically saved/restored. Then FPU state can be modified safely in the
  * registers, before unlocking with fpregs_unlock().
  */
-void fpregs_lock_and_load(void);
+unsigned long fpregs_lock_and_load(void);
 
 #ifdef CONFIG_X86_DEBUG_FPU
 extern void fpregs_assert_state_consistent(void);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 0d86706b962a4..85925b10ee045 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -817,8 +817,10 @@ void switch_fpu_return(void)
 }
 EXPORT_SYMBOL_GPL(switch_fpu_return);
 
-void fpregs_lock_and_load(void)
+unsigned long fpregs_lock_and_load(void)
 {
+	unsigned long flags;
+
 	/*
 	 * fpregs_lock() only disables preemption (mostly). So modifying state
 	 * in an interrupt could screw up some in progress fpregs operation.
@@ -827,12 +829,14 @@ void fpregs_lock_and_load(void)
 	WARN_ON_ONCE(!irq_fpu_usable());
 	WARN_ON_ONCE(current->flags & PF_KTHREAD);
 
-	fpregs_lock();
+	flags = fpregs_lock();
 
 	fpregs_assert_state_consistent();
 
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		fpregs_restore_userregs();
+
+	return flags;
 }
 
 #ifdef CONFIG_X86_DEBUG_FPU
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index fd689921a1dba..fbaeb08bdc8d0 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -158,6 +158,7 @@ static int shstk_setup(void)
 {
 	struct thread_shstk *shstk = &current->thread.shstk;
 	unsigned long addr, size;
+	unsigned long flags;
 
 	/* Already enabled */
 	if (features_enabled(ARCH_SHSTK_SHSTK))
@@ -172,10 +173,10 @@ static int shstk_setup(void)
 	if (IS_ERR_VALUE(addr))
 		return PTR_ERR((void *)addr);
 
-	fpregs_lock_and_load();
+	flags = fpregs_lock_and_load();
 	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
 	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
-	fpregs_unlock();
+	fpregs_unlock(flags);
 
 	shstk->base = addr;
 	shstk->size = size;
@@ -225,12 +226,13 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 static unsigned long get_user_shstk_addr(void)
 {
 	unsigned long long ssp;
+	unsigned long flags;
 
-	fpregs_lock_and_load();
+	flags = fpregs_lock_and_load();
 
 	rdmsrl(MSR_IA32_PL3_SSP, ssp);
 
-	fpregs_unlock();
+	fpregs_unlock(flags);
 
 	return ssp;
 }
@@ -336,6 +338,7 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 int setup_signal_shadow_stack(struct ksignal *ksig)
 {
 	void __user *restorer = ksig->ka.sa.sa_restorer;
+	unsigned long flags;
 	unsigned long ssp;
 	int err;
 
@@ -360,15 +363,16 @@ int setup_signal_shadow_stack(struct ksignal *ksig)
 	if (unlikely(err))
 		return -EFAULT;
 
-	fpregs_lock_and_load();
+	flags = fpregs_lock_and_load();
 	wrmsrl(MSR_IA32_PL3_SSP, ssp);
-	fpregs_unlock();
+	fpregs_unlock(flags);
 
 	return 0;
 }
 
 int restore_signal_shadow_stack(void)
 {
+	unsigned long flags;
 	unsigned long ssp;
 	int err;
 
@@ -384,9 +388,9 @@ int restore_signal_shadow_stack(void)
 	if (unlikely(err))
 		return err;
 
-	fpregs_lock_and_load();
+	flags = fpregs_lock_and_load();
 	wrmsrl(MSR_IA32_PL3_SSP, ssp);
-	fpregs_unlock();
+	fpregs_unlock(flags);
 
 	return 0;
 }
@@ -413,6 +417,7 @@ void shstk_free(struct task_struct *tsk)
 
 static int wrss_control(bool enable)
 {
+	unsigned long flags;
 	u64 msrval;
 
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
@@ -430,7 +435,7 @@ static int wrss_control(bool enable)
 	if (features_enabled(ARCH_SHSTK_WRSS) == enable)
 		return 0;
 
-	fpregs_lock_and_load();
+	flags = fpregs_lock_and_load();
 	rdmsrl(MSR_IA32_U_CET, msrval);
 
 	if (enable) {
@@ -447,13 +452,15 @@ static int wrss_control(bool enable)
 	wrmsrl(MSR_IA32_U_CET, msrval);
 
 unlock:
-	fpregs_unlock();
+	fpregs_unlock(flags);
 
 	return 0;
 }
 
 static int shstk_disable(void)
 {
+	unsigned long flags;
+
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
 		return -EOPNOTSUPP;
 
@@ -461,11 +468,11 @@ static int shstk_disable(void)
 	if (!features_enabled(ARCH_SHSTK_SHSTK))
 		return 0;
 
-	fpregs_lock_and_load();
+	flags = fpregs_lock_and_load();
 	/* Disable WRSS too when disabling shadow stack */
 	wrmsrl(MSR_IA32_U_CET, 0);
 	wrmsrl(MSR_IA32_PL3_SSP, 0);
-	fpregs_unlock();
+	fpregs_unlock(flags);
 
 	shstk_free(current);
 	features_clr(ARCH_SHSTK_SHSTK | ARCH_SHSTK_WRSS);
-- 
2.35.3
