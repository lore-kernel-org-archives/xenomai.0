Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAB3FA5D6
	for <xenomai@lists.linux.dev>; Fri, 15 May 2026 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833002; cv=fail; b=NYcoo0e2mcsUnphslanh+uNdxo7oislq+mg8cpeIEcSCkbVdliVYJbt4KKEliol+D5NiWBSrQW8YFYE0FmunCi2tniFy7uDNSmv2pORIVGKvKWdq2VsZReJUUyvEUEHHNH7qiIVu22kG40PuVCCKUoiu/nEuB6+PqxnhC1FMf5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833002; c=relaxed/simple;
	bh=5n+ibAEGlbpets3Cawdm2GbZT1jDEtOfV0jmARIF4ZQ=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=Z8c4gHy6Q2qDY1GeDXsZokO3zhyIm1VthpqKrl8QljPOGW/+ajuSchSoaCtTkR08jcYO0plGVzByc1pknn3gsuVFu/ml9C1HA66MaQIjpWJRxi47qmY5gDyT8S2QExzorMlE8NRG1bSMuJh94ZUxRiAMtruVFw/bdpBobyz/H/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=i9Aox16f; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="i9Aox16f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAhsrVjbLJ4A2u4OVJfsGi+aNFZTBPsTyG+Y4zQfFs9ABmcK9Sa8MY/OHWMyuNs7pLUPGQMDivPpObT5OsKsqb9zEG0Ay0LUUbRG/VUGRWhjtDpL5z80JdsTlo+OKO+XSrl9hDm9gkzeJSBHNErBp5Rxu0IRbNB3NC2zzTPlixM9w+3S9UwR46i5kan5jFtmUprFRydJhlMWB8KnJLWDWJYRDuDYi/5BVJ6/cNYDp0tD4heu4d6Dl6yrOw24nAlBNEjubh+ut2OCfUKN8DYloB/TcMIdoOw7te9M6sVXyqx0iR8ugNIOgPUlCHGa5AyCrYlW5p/2oLeoVgR3OsYOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwYnkQ/qFsovNuAKDjm/us4JG4h6de2hVEuDFF9CCWo=;
 b=SCUFxb7bmGFUYS17MCtqXMjz+LNYJiA64XMp7VdpMxsq2q/NMxc/RgCE/4eKzs/E5+prjYJiepI7l36eT41pLQedfghZhVr3KXYpusakUgUgkXykMN7ghrc5V+IsqIcF4tEG6Xe3akk0YZ5FwM5WcdHG6S+dJ5K70Xoe/3Q0diAnd10NdV6Am/rJEXRSrUhoWL1CeadG68EPf9b5zEvhSZsTFQhl+WVg9UweFnqAXeC9WaYmLzxkbhsiKS2a5EPui0gf234ywNa2BjDEjPLwPf4qTmVRzOV22kQqbVnQofwmzgIQh452PJOB6EIDYoS7HcevbfPBy5YINAwktnuzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwYnkQ/qFsovNuAKDjm/us4JG4h6de2hVEuDFF9CCWo=;
 b=i9Aox16fMqqKf2xN56ZHrzID+x6QskGzUFCeThYHaA3dZvxOkmhQp0Ualme+h8b1F8Mc3wKciZekdvt2/+/iiE3fV80C2GmgZW2Bq69q8Vu3OxnuXyfqf4Mu4vAT8XKuOBC49UyPJYAWhbUaS3OPUl4PmZeHwmb3vKxJEJy1sELGZMC5Ne2z/ZXkABab6XtB8CFCtqT5HJXcopfmy/6fGrW/+4lp/O53dPsJfAtIqrRorFCXmrOLAE8X5Ir7KyFAN1NNTYvDqfrc8kdIjZpALAv1Y1Tqk2rhzgGtlnw5OEGXgejyZ8TpJfXixPkBcMEWqcHRisOXTSckmKpU6U4wAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 08:16:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 08:16:38 +0000
Message-ID: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
Date: Fri, 15 May 2026 10:16:37 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
Content-Language: en-US
Cc: Richard Weinberger <richard@nod.at>, Philippe Gerum <rpm@xenomai.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 11973a57-5d18-41c1-7738-08deb25a493a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	5zh0ikbHnNu/2l7z/xtzCdXWEd9jpLvlBbQeRTkc086brTNQcxY3sy4dL2XTo5/7LIszRUs5+b1VEnJRP8oqVzyd1cJNbZLDKnfIEHBfdfYp/+HDwlWAiRi/yZC2yhI9jez9zHcXvcrEhPe40NLqIuNj4k8XTLwdlO5GrXquNT37ZvcjfjegEymzrwiLlzmpMlBX1joqRNQwYWIgtM3p42OaOQ8zgTwhnRoZ02WsK5tGPwOpR4CJENqK8WFp0DHE/vNEZvehZkjCbjX6OzIjO2qr0TOoHRMtJdpwRJyLKnaLmm8I/ZIT7xfDD6Gkoga4H7taY57EJjoSexMTLdEKyG3Xa6ajkPFYjP943j3XZ8ww9b9dsRmlZjSWEvw6JxOyGsTOQmpoMo8JeCZnemyfTdMoCl0O8ayooYXdnA49JOWdSO4MjdRGpxKNxIsLsOUtCWpuvgGQuQlTlpVjbC8Zom6i56yr9qHotWsuiWhzSgmjPJD0As2S2DEzeDHdXZ1CCz6ePsiTeYiaQl5TZLw4bPjFnDb8lqf7joM/EjIm69RItmn48Ehl6l9mXX9IXR8141bGXvDObTRVnEpeOvuk4od/efvUVfJN4iis+Gq2iTbYGy2ORvDmkTAjXxka10A9yEiFwvV4AnlilEDcjY+udPU1g1x3xstu7APhCOtRvVo856es/IzPFMgHSpO0G1Y5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGhCSkhzRGZkZ3laazdsQWtwaEtqd3FsN1RnckZPNmF4ZmFkOEhFTWw3TVUx?=
 =?utf-8?B?d3IwYWdtWmRUc3pTZkNjUnY3M2huSjN3WlNJUjBQSk1BY0RWWUNxTndWNGdr?=
 =?utf-8?B?cUxPSUFmb0pRRXkyT1RBOCs2UzFMVnVJSzZBNlVrb3daUy9JeXBUWXVIeSsr?=
 =?utf-8?B?NlNzVmU1cjY0bVhGSnkzMlFqN1Q3V005RDBNMjVHaHF3TDhCRktVdlhyQXM1?=
 =?utf-8?B?T3JKaG01aitEQlV0bm9teUFaWmk3cGU2c01YYXhTeTM4TXVGcVpFUW9YMWNN?=
 =?utf-8?B?dDkxNVdOMlhTajdrQnZia1hpaVd4czhVM3A2bDI2UkE5Vy90ZTJ2R3ZaR085?=
 =?utf-8?B?Z2RsVzdvWlVIb0hDNE8zMHEzOXJjYThpdU5JaXZNMUY4S3VZSmNWUGROUGxJ?=
 =?utf-8?B?U2ZobTZvSmpNWmpoS3Q5R1ROSGxZbzdmQ0hkTlovWHJhRGd1M3RHSElZSTUx?=
 =?utf-8?B?TWx5cXg3Uzdjem4rekU3ZUJQb3N0ZTlsS2FwMStBTVVFektTQ244L2lnS0ZY?=
 =?utf-8?B?Y1o2V21uakVPaFNCMWJLVGlFRFo2bmJRSkpnYlpVZkZIbUcwZEhJRkRCeUVX?=
 =?utf-8?B?QmxlNU5MUWpBY3FFNkM1L2FyTjZRbEEwTVZ0enhGY2N4UWtFNU5ybmZOWTl1?=
 =?utf-8?B?T1pXTGR1RXc4ZnpjNU9MeEViajd4eGhWbkJtZFZ0ZS9weENCV1dOWUNERGcr?=
 =?utf-8?B?SUI4L2w5ZTBLNWlVVGJmUHZBN05SZWl0SEhrMEErbFFWOUJzTzR5V1BZMXZi?=
 =?utf-8?B?MmZrcnpSQ2xIME02K1YvUmVlZ3hKeFdFNlJWRkdYaHNlVEFzS21yNFlGeWVK?=
 =?utf-8?B?YjRqWGtoODBzYklPZUJyTUdubFVxcklrc1p4NUpWSitodG9QZE9QVlhsWndy?=
 =?utf-8?B?Q0NkNGpPSmQ1UytmTS9pcS9qb1drbVNpaVFRR3h0Tm9uT0xJVDY2UFZOQ09n?=
 =?utf-8?B?TU1Oa3ZIbzZyWmRybUIyYTdSOTA2U1BDSWVWRGhDSlFNeTZNWFJycGtlT3NV?=
 =?utf-8?B?c29lOWhMd1ZEY1AvVXh3VGdheWJWbFJOcmt5MnFIc0s2RzNXTU1SQm90TWhl?=
 =?utf-8?B?S3dCYTdqTSs4bmpEOHlNNW1IMHJhUkdONGpBeDU0OFpoOUtEUVBLUjBGeDA2?=
 =?utf-8?B?eTBzamhyeFNPblk5MDl6ODBTN0pHVHpYSTFna1NOYTBYK1NibDNqY0QwN2ZI?=
 =?utf-8?B?ZG44cy9BenpBY3EwVU15V0gvbUJTOWNnK01Gc005Qm56OWpkMURTNlRVL00y?=
 =?utf-8?B?TDB5Y2Z4RTY4NmhucSs1NWlrWmtyak12VjBLRFAxeGhtR2lJTEhiMjNCRXVo?=
 =?utf-8?B?akgyemkyN2d5Ymh6cEU1cXVvRndSeG9JSzVQTVpDRWhPK29CcCs2R2R6a2dH?=
 =?utf-8?B?RktycXFWVVhUWTEzbW41cUZWeENkR051YXhrWWIxRWdzbkFBbUpDaW5OTUdv?=
 =?utf-8?B?TlptZU5vL0Jrb0VpbUlRQmhJK0h0VllkNU42TFFUTTVtNUNiREVJTENRRThK?=
 =?utf-8?B?dVFuQlNiRzRSczdRTERTNzMxY05hWlJlbXU5Uk44OEZyTTBhU0s2TlF6VUVI?=
 =?utf-8?B?QlhPN1UvWDdZVEIvcEJUU3JmcGdRVVBOMEtWeDVBd1R3eGtzUHNtVGozc1c5?=
 =?utf-8?B?Q09TaWxpS2h2N0YrTmFxQW1FTnZ5bHMwL0ZBQkRQRHJjdVpmbDNQNmNEb3Fo?=
 =?utf-8?B?ZmxrTHRYK29wb3ptaldNNE9tYWtMQldMeCtmdi9WZDNrTnFzclROdUlZZzRv?=
 =?utf-8?B?bDlmTlJXYXN2bWFFcEdsY25mc1RsWEp6WGMzTURrMmlGdTlkZzdyLzJkc1BE?=
 =?utf-8?B?YTZya0IwZk4yY2RTa2NTcnVpNSs4WUdTbVN2WElnbUVkTmFTTldpK0U3cFZJ?=
 =?utf-8?B?b0YrLzBWaU9DU0ZjUXVKbTl2aUdMQmNtdElTOU1MUklDZjFKa1dPSjRCVWRX?=
 =?utf-8?B?Wi9UWGVaT0I1K3ZZekpTcTJOK3pPRE4vR2dBbm9WempaWFNRU2ZPUkN5ekln?=
 =?utf-8?B?dUhEVzgxcFlvemUwOGVXS2NIc20zMHZDQ3g5aGwxRm9DaXRZeWpvajI1Vk9T?=
 =?utf-8?B?cVlYS0lUKzAwZlNyOHB6ZHlNRXVBMW9jOHVjcEtzbWNyK3pSV2F0bkR2SUxx?=
 =?utf-8?B?ZkozK2Q3NjJLdUJZSk54RUFWalBMSFp5a2NGTGFFd2puTEh1WVl1TitWYXpK?=
 =?utf-8?B?RnhoU2NuT2wrT0NqOEtMeXRFVWwyZjNKQ2tGb1JIQXlTeStWdjREOWRmRWYw?=
 =?utf-8?B?L3hkaWlmRDQ4dzhlV0RML0dFOWxHZXZJUWVHSFZvaGIvS1V3WDFHaHYyRlF6?=
 =?utf-8?B?ZWk4SFJhYjlXN3ZxVGZPc3FtRXpwU1RGVldYbGVIeUdpOUI1NmI5QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11973a57-5d18-41c1-7738-08deb25a493a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 08:16:37.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeHitHwHVVnssSEPugXQ5Ke5T5anJBPP6TkDVBMeo439HnBVEm0XrZgG21CAYa+ppeh6QY2IRy4rY9wfzkt5Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7943

From: Jan Kiszka <jan.kiszka@siemens.com>

When a remote thread is suspended, xnthread_suspend checks if it is
currently relaxed and then calls it into hardened state via SIGSHADOW.
However, this signal may race with the thread entering primary mode on
its own, e.g. via a syscall. In that case, the thread will be kicked out
of its suspension state by the pending signal, and the migrate syscall
it then executes will not perform the expected suspension anymore.

Plug this race by introducing two thread state flags, one for pending
XNSUSP and another one for XNHELD. After having performed the requested
hardening on SIGSHADOW_ACTION_HARDEN, we are now testing for those
pending suspension states and replay them via self-suspension as needed.
If a resume took place in the meantime, the state flags were cleared
again, and nothing will happen after the migration step.

Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Didn't check yet if EVL solves this topic differently or is exposed to 
similar race. But given that Richard found the pattern even in Xenomai 
2, it's likely worth to check EVL carefully.

 include/cobalt/uapi/kernel/thread.h |  2 ++
 kernel/cobalt/posix/signal.c        |  1 +
 kernel/cobalt/posix/syscall.c       | 26 +++++++++++++++++++++++++-
 kernel/cobalt/sched-sporadic.c      |  5 +++--
 kernel/cobalt/thread.c              |  7 ++++++-
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/uapi/kernel/thread.h b/include/cobalt/uapi/kernel/thread.h
index 664def08ef..279a96e19e 100644
--- a/include/cobalt/uapi/kernel/thread.h
+++ b/include/cobalt/uapi/kernel/thread.h
@@ -73,6 +73,8 @@
 #define XNPIALERT 0x00000080 /**< Priority inversion alert (SIGDEBUG sent) */
 #define XNSCHEDP  0x00000100 /**< schedparam propagation is pending */
 #define XNCONTHI  0x00000200 /**< Continue in primary mode after debugging */
+#define XNPNDSUSP 0x00000400 /**< Pending suspension on migrate syscall */
+#define XNPNDHELD 0x00000800 /**< Pending held on migrate syscall */
 
 /* Local information flags (private to current thread) */
 
diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 1842aa5e8a..71277d7ca6 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -510,6 +510,7 @@ int __cobalt_kill(struct cobalt_thread *thread, int sig, int group) /* nklocked,
 			ret = -EINTR;
 		break;
 	case SIGRESM:
+		xnthread_clear_info(&thread->threadbase, XNPNDSUSP);
 		xnthread_resume(&thread->threadbase, XNSUSP);
 		goto resched;
 	case SIGRELS:
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index bc1825676f..7dca49a424 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -118,6 +118,8 @@ static void prepare_for_signal(struct task_struct *p,
 static COBALT_SYSCALL(migrate, current, (int domain))
 {
 	struct xnthread *thread = xnthread_current();
+	int err;
+	spl_t s;
 
 	if (is_secondary_domain()) {
 		if (domain == COBALT_PRIMARY) {
@@ -131,7 +133,29 @@ static COBALT_SYSCALL(migrate, current, (int domain))
 			if (xnthread_test_state(thread, XNDORMANT))
 				return 0;
 
-			return xnthread_harden() ? : 1;
+			err = xnthread_harden();
+			if (err)
+				return err;
+
+			xnlock_get_irqsave(&nklock, s);
+
+			if (xnthread_test_info(thread, XNPNDSUSP|XNPNDHELD)) {
+				int mask = 0;
+
+				if (xnthread_test_info(thread, XNPNDSUSP))
+					mask |= XNSUSP;
+				if (xnthread_test_info(thread, XNPNDHELD))
+					mask |= XNHELD;
+
+				xnthread_clear_info(thread,
+						    XNPNDSUSP|XNPNDHELD);
+				xnthread_suspend(thread, mask, XN_INFINITE,
+						 XN_RELATIVE, NULL);
+			}
+
+			xnlock_put_irqrestore(&nklock, s);
+
+			return 1;
 		}
 		return 0;
 	}
diff --git a/kernel/cobalt/sched-sporadic.c b/kernel/cobalt/sched-sporadic.c
index bec8dcb533..80e99a1e7d 100644
--- a/kernel/cobalt/sched-sporadic.c
+++ b/kernel/cobalt/sched-sporadic.c
@@ -152,9 +152,10 @@ retry:
 	if (pss->budget == 0)
 		return;
 
-	if (xnthread_test_state(thread, XNHELD))
+	if (xnthread_test_state(thread, XNHELD)) {
+		xnthread_clear_info(thread, XNPNDHELD);
 		xnthread_resume(thread, XNHELD);
-	else if (thread->cprio < pss->param.normal_prio) {
+	} else if (thread->cprio < pss->param.normal_prio) {
 		p.pss.init_budget = 0;
 		p.pss.current_prio = pss->param.normal_prio;
 		/* Move sporadic thread to the foreground. */
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 60a7112844..b605781c64 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1013,8 +1013,13 @@ void xnthread_suspend(struct xnthread *thread, int mask,
 	 * state, since they are suspended by definition.
 	 */
 	if (((oldstate & (XNTHREAD_BLOCK_BITS|XNUSER)) == (XNRELAX|XNUSER)) &&
-	    (mask & (XNDELAY | XNSUSP | XNHELD)) != 0)
+	    (mask & (XNDELAY | XNSUSP | XNHELD)) != 0) {
+		if (mask & XNSUSP)
+			xnthread_set_info(thread, XNPNDSUSP);
+		if (mask & XNHELD)
+			xnthread_set_info(thread, XNPNDHELD);
 		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
+	}
 out:
 	xnlock_put_irqrestore(&nklock, s);
 	return;
-- 
2.47.3
