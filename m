Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30058.outbound.protection.outlook.com [40.107.3.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C767EB
	for <xenomai@lists.linux.dev>; Fri,  8 Jul 2022 07:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbC9UtRdcxWmcbB72eitzkdPlYf81Fva93To4AeBowT/vxEcQ+B6zfczeU4bWJmj85iLX00nSEQdA1lfj8D8tSmxb/xoWDPc60nEuDMp83IkKCaCltx7EWNrlekjecZxTiIJmwM5Chz3jrsGNj5alFvMh1aWKPnc0j8MEp4x/GZj9f8JGEQghyDRyFPXDfEmY8Y4wOq264ImU+4sgMBv9DPpzd+IBWwXdXS/4o3cteabaqgpB8+2WE6wuFgvT18tgLefr2Wd2+ak+HzHFBQ/DjJEtgLObi2H2MpBdLMjw15+Pr/d+UIOHS2by0dzpa0xBZf7iQT917e3itaEj4c9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFcH1314NhDij0TWNbLFPkgKg6KZUxtEqZa0vfMFltI=;
 b=A1fhb7Gymqc2iyFoQck4qcTmLMqP3pnjJX0iCmzXcyihw4JmuTk8lplu2NRG5nHCf91AS95t1+PMUkBDwJEvHcG/4eHpy6h8U5lZUfKalEVDwCv/Xj8tkKN4jVOy7CxyS0u6Cg0xBEe3Xh1/Ib/Pgphy6VyuPw5plhm21neTYM921uhH3XOXyGZNJYuq8KPKxR7B5Euil8lFRxG4OORcGenFielGZONW9T1kpxvFVdcrfxSOg1UgjhKMGThxaEQTb7rGJMO8hz2fhPvJ1dEcWif+kpLvHnu7U252LC7r13B8PHDuVDHj+4IQv0khP6i6K3A+7znS5s8J3X9BvNLEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFcH1314NhDij0TWNbLFPkgKg6KZUxtEqZa0vfMFltI=;
 b=IODjImOCmI7VeR1yn7nCL+QICKHO/W4JOnRQKwPYOaXPdUsrxRweUV5YiZVMO/55iooSfs9h0KM/II8Lxc+TrTUc3/n/3lqp8xo2CNZxPd7vh20mWfmUkK5kD/XUAv/Tp0e/zgu7GdF04iToWlHBx+VSwZZPS7YQx0I7IZSvQ/VMkPk3mWkFeummSGVTOeCHl2jMNdRUtabNOBkgUhb1pbfPjeGbYoCHYUChOleITRsvOuscQjw6Kbf2iSQp3ZVqQwRAyNUGNEOaWlY6qVCbfkf8KNozH4IqV0n85XaRQaLzd/FM6Y9ZXxsgJCa6jWS59jNqpUiMTEuV7d4kE0694g==
Received: from DB6PR07CA0162.eurprd07.prod.outlook.com (2603:10a6:6:43::16) by
 AM8PR10MB4114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17; Fri, 8 Jul
 2022 07:11:04 +0000
Received: from DB5EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:43:cafe::a4) by DB6PR07CA0162.outlook.office365.com
 (2603:10a6:6:43::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.6 via Frontend
 Transport; Fri, 8 Jul 2022 07:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT029.mail.protection.outlook.com (10.152.4.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 07:11:04 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 8 Jul 2022 09:11:04 +0200
Received: from [139.21.19.112] (139.21.19.112) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 8 Jul 2022 09:11:03 +0200
Message-ID: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
Date: Fri, 8 Jul 2022 09:11:03 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, Richard Weinberger
	<richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.112]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.538400-8.000000
X-TMASE-MatchedRID: KkAe3/TPGQpA7NIb/hR3oOmWxAgjfDfrDGsvSm+tjWHi3aa5wOREERJS
	x+7Qm/dKZBS9rNHmGlCINheLaEgz+dcDWT+bno+nxmJ07fhF3NZC+amDTCdIs6JVTu7sjgg1F4r
	8H5YrEqzLkl8e9W70izZxczjXn+SumiCJ0WtA0U1sTJ5+0BsLPYxxTMlLewfdggra2NOo2i0/pO
	SL72dTfwdkFovAReUoaUXs6FguVy2Wkqk2IvguWk4JukPmkVP5OYaLvc/+qakgCPGiZqtI8FDi5
	vmx8OsRAkSnL4YTrqFn4/nMWJ1Bm6czyh8Nv2q46s99/ddG+MPTpuJrFQmMLCoiRKlBVkYIS3sN
	HVAxomz7XVidhKCWnoHQ9Kct9aq8fdruklhVME2SSDwXemPNUlNq22uBrzfY/LSVFH0Kn4j865Q
	lVwxmGyuGKh4AkqKVLK/0ECO56Oixoz8tfWWF04VWjMf7ysVUYMgr6Vt6S5K628cXbnOhT1Rn/7
	j4scmhJsGUXROOpVmjxYyRBa/qJQPTK4qtAgwIPcCXjNqUmkW8QIu4z6HhEH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.538400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 6CBD78D0A13AFC53287CBFFA1283CCC9B9477920816F97D3947883D4CDB185492000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5d432d0-f7b6-4f09-d88a-08da60b105a4
X-MS-TrafficTypeDiagnostic: AM8PR10MB4114:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kbhCN3BpPkuuvCkip8stYKydulYNB4V8MyH3Byll8/DqkPPsnWtIiRxZt6017DxmbJhTsMoe/i5xZv6Zuf6vpynYIlt539gDi2be1L3Tvbc7wyn0nx/NiSISESCYVtVM1Yy9giLT5sSZSd2VriPOtUt5KcLO78a/qrEKq/s6qQGVn1HzGO/XzFYjudIfBjrUm1wwq0zV8U37eUGBvp8BLfghoPnjsvYSefyRNjBCZ/T6Tixz98IkeeChb716AETIcCxgg+k4qNPfIV87jJ3ZjJ4lT9FXmwVuCA7pPYTSSOIG1sIjsC9UrKFuOcJQFx5ddZO2r2lkzr+V7NN1DURdscHVjIwl9l4cO9enuzJ6R/0H/E3urCbFqn4TfCDmMU/llU2vtlJGeXMrChJFI3Z+NO1CWL7dfDS30Nn8/UpQCeK2WZh/6M+22xM8ibXuOReoZOk/m7hQIrFkYqc2Wt+1g9gIyklwbbecLnMh6I7cbB4G+c1/Qy5rLR9cCEzaCjHg1i3Q9v2UQz+mnrRuJ0nvrdpJ8krs9mxp1mWJOL7hWPvmGHky1kVfojCeUMkfj7yTvbuOIVblCBq0k+KwAQeJHt/uET9fxTgeW4drqruly78lQdaPM2Tj6FdKDGve8ZBDojCmdp1zEH4RZtfR717r0NsJGlJuhMcmfkw+ozofP+Lo9j0YlKuyT/b1k/SVwvzCpxRGP/Kc9OWPYhfIeBleASKYFBdtRKYNKlJSH8Tj3IJt6y7HUMamu1TjgCu/tdyW2NHfbXCUuvJUbVkyfxsjgzbExPgKI5wTSJZfLuZJO2sht7Nypj6wIcwojWwXxDY1olXajWaLZ4iYbGehIVxDQOwZ2/unilsI/wPmIUWB0JeCix0rDA81frt5e2ZlN52SKZdM8BKUcEU4nTQQKE5p/J5gX2u+uRpcd/yg1cYELOA=
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(40470700004)(46966006)(36840700001)(40480700001)(36756003)(47076005)(31686004)(40460700003)(82740400003)(186003)(36860700001)(16526019)(2906002)(2616005)(956004)(82310400005)(336012)(83380400001)(81166007)(316002)(31696002)(16576012)(5660300002)(26005)(44832011)(110136005)(478600001)(8936002)(70206006)(70586007)(8676002)(41300700001)(82960400001)(6706004)(356005)(86362001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 07:11:04.5732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d432d0-f7b6-4f09-d88a-08da60b105a4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4114

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to skip reporting a trap to Linux when the OOB handler
resolved it directly. The handler can signal this condition by returning
"true". This feature was present in I-pipe as well.

By intention, not all spots of oob_trap_notify are enabled for this.
Debug traps are left out as well as asyncpf in kvm - no use cases from
OOB-perspective.

NOTE: breaks unprepared users, breaks non-x86.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I'm happy to add non-x86 support as well if the direction is fine.

And if we introduce that to dovetail, we will have to add some kernel 
version checks to Xenomai so that it does the right thing with the right 
dovetail versions. Feature flags are out of fashion there as far as I 
understood.

 arch/x86/kernel/traps.c  | 38 ++++++++++++++++++++++----------------
 arch/x86/mm/fault.c      |  9 ++++++---
 include/linux/dovetail.h |  9 +++++----
 kernel/dovetail.c        |  9 ++++++---
 4 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3d04a80a1464..daf222f444f4 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -163,10 +163,12 @@ static void show_signal(struct task_struct *tsk, int signr,
 }
 
 static __always_inline
-void mark_trap_entry(int trapnr, struct pt_regs *regs)
+bool mark_trap_entry(int trapnr, struct pt_regs *regs)
 {
-	oob_trap_notify(trapnr, regs);
+	if (oob_trap_notify(trapnr, regs))
+		return false;
 	hard_cond_local_irq_enable();
+	return true;
 }
 
 static __always_inline
@@ -211,9 +213,8 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 
-	mark_trap_entry(trapnr, regs);
-
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
+	if (mark_trap_entry(trapnr, regs) &&
+	    notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
 			NOTIFY_STOP) {
 		cond_local_irq_enable(regs);
 		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
@@ -375,10 +376,12 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 		return;
 
 	state = irqentry_enter(regs);
-	mark_trap_entry(X86_TRAP_UD, regs);
+	if (!mark_trap_entry(X86_TRAP_UD, regs))
+		goto mark_exit;
 	instrumentation_begin();
 	handle_invalid_op(regs);
 	instrumentation_end();
+mark_exit:
 	mark_trap_exit(X86_TRAP_UD, regs);
 	irqentry_exit(regs, state);
 }
@@ -411,7 +414,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
 {
 	char *str = "alignment check";
 
-	mark_trap_entry(X86_TRAP_AC, regs);
+	if (!mark_trap_entry(X86_TRAP_AC, regs))
+		goto mark_exit;
 
 	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
 		goto mark_exit;
@@ -595,7 +599,8 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 
 DEFINE_IDTENTRY(exc_bounds)
 {
-	mark_trap_entry(X86_TRAP_BR, regs);
+	if (!mark_trap_entry(X86_TRAP_BR, regs))
+		goto out;
 
 	if (notify_die(DIE_TRAP, "bounds", regs, 0,
 			X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
@@ -806,7 +811,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
-		mark_trap_entry(X86_TRAP_GP, regs);
+		if (!mark_trap_entry(X86_TRAP_GP, regs))
+			goto mark_exit;
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto mark_exit;
 	}
@@ -1273,7 +1279,8 @@ static void math_error(struct pt_regs *regs, int trapnr)
 		if (fixup_exception(regs, trapnr, 0, 0))
 			goto exit;
 
-		mark_trap_entry(trapnr, regs);
+		if (!mark_trap_entry(trapnr, regs))
+			goto mark_exit;
 		task->thread.error_code = 0;
 		task->thread.trap_nr = trapnr;
 
@@ -1300,10 +1307,9 @@ static void math_error(struct pt_regs *regs, int trapnr)
 	if (fixup_vdso_exception(regs, trapnr, 0, 0))
 		goto exit;
 
-	mark_trap_entry(trapnr, regs);
-
-	force_sig_fault(SIGFPE, si_code,
-			(void __user *)uprobe_get_trap_addr(regs));
+	if (mark_trap_entry(trapnr, regs))
+		force_sig_fault(SIGFPE, si_code,
+				(void __user *)uprobe_get_trap_addr(regs));
 mark_exit:
 	mark_trap_exit(trapnr, regs);
 exit:
@@ -1416,8 +1422,8 @@ DEFINE_IDTENTRY(exc_device_not_available)
 		 * to kill the task than getting stuck in a never-ending
 		 * loop of #NM faults.
 		 */
-		mark_trap_entry(X86_TRAP_NM, regs);
-		die("unexpected #NM exception", regs, 0);
+		if (mark_trap_entry(X86_TRAP_NM, regs))
+			die("unexpected #NM exception", regs, 0);
 		mark_trap_exit(X86_TRAP_NM, regs);
 	}
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 834a6edd0be5..1cffd321878f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -650,7 +650,8 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 	 * Do not bother unwinding the notification context on
 	 * CPU/firmware/kernel bug.
 	 */
-	oob_trap_notify(X86_TRAP_PF, regs);
+	if (oob_trap_notify(X86_TRAP_PF, regs))
+		return;
 
 #ifdef CONFIG_VMAP_STACK
 	/*
@@ -890,7 +891,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
 		return;
 
-	oob_trap_notify(X86_TRAP_PF, regs);
+	if (oob_trap_notify(X86_TRAP_PF, regs))
+		return;
 
 	if (likely(show_unhandled_signals))
 		show_signal_msg(regs, error_code, address, tsk);
@@ -1363,7 +1365,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * event, so that it might switch current to in-band mode if
 	 * need be.
 	 */
-	oob_trap_notify(X86_TRAP_PF, regs);
+	if (oob_trap_notify(X86_TRAP_PF, regs))
+		return;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index 6a244a44ab1f..4bd27531f9e5 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -58,14 +58,15 @@ void inband_task_init(struct task_struct *p);
 
 int pipeline_syscall(unsigned int nr, struct pt_regs *regs);
 
-void __oob_trap_notify(unsigned int exception,
+bool __oob_trap_notify(unsigned int exception,
 		       struct pt_regs *regs);
 
-static __always_inline void oob_trap_notify(unsigned int exception,
+static __always_inline bool oob_trap_notify(unsigned int exception,
 					struct pt_regs *regs)
 {
 	if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
-		__oob_trap_notify(exception, regs);
+		return __oob_trap_notify(exception, regs);
+	return false;
 }
 
 void __oob_trap_unwind(unsigned int exception,
@@ -248,7 +249,7 @@ static inline void arch_dovetail_exec_prepare(void)
  * Keep the trap helpers as macros, we might not be able to resolve
  * trap numbers if CONFIG_DOVETAIL is off.
  */
-#define oob_trap_notify(__exception, __regs)	do { } while (0)
+#define oob_trap_notify(__exception, __regs)	false
 #define oob_trap_unwind(__exception, __regs)	do { } while (0)
 
 static inline
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 79fd75918b37..167dc61dbcce 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -254,14 +254,16 @@ int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
 	return 0; /* pass syscall down to the in-band dispatcher. */
 }
 
-void __weak handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
+bool __weak handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
 {
+	return false;
 }
 
-noinstr void __oob_trap_notify(unsigned int exception,
+noinstr bool __oob_trap_notify(unsigned int exception,
 			       struct pt_regs *regs)
 {
 	unsigned long flags;
+	bool handled;
 
 	/*
 	 * We send a notification about exceptions raised over a
@@ -273,10 +275,11 @@ noinstr void __oob_trap_notify(unsigned int exception,
 		set_thread_local_flags(_TLF_OOBTRAP);
 		flags = hard_local_irq_save();
 		instrumentation_begin();
-		handle_oob_trap_entry(exception, regs);
+		handled = handle_oob_trap_entry(exception, regs);
 		instrumentation_end();
 		hard_local_irq_restore(flags);
 	}
+	return handled;
 }
 
 void __weak handle_oob_trap_exit(unsigned int trapnr, struct pt_regs *regs)
-- 
2.35.3
