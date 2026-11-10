Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334127;
	b=O+Uw/shx8sHx3DzBEaLQ/fQNK64Wxu9FPGN0iXwd+FBcF48Wbp0Rt1L8A5I7N34+XYxk
	 EUokuGDoDxfXTjNNitSIrxI3KUpoZ4tGiflu/QzF55ea0ptTuaco+4O3kWDGmTkNTbJUp
	 GiTj7z9RQ5tYeSMqe9bTFzmd2MLmXZacOqerlLxpmBP84Ly26Gxn13krPIpwALIGU1VSJ
	 ZqlO+C5+8UTtVC8qsiTPha2qzoF8J1bPIe0AsRf6SB0fZtHzPzkIyfKJSG831cR2OkYiI
	 ugkQP97/fy/VvXJQC/EkMvIm6L32YzleRd8VVcOt8/qRxR8Jb8vN6wqECp6JNbh9MBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334127;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3QX6Pc6/saU4t1AEofHtwkc1FWrWZM9QpWwsIVbqG70=;
	b=NeDl168Z5RuGLL8Zsc0Kg0mQAbXPyq5l1v3b5ytyGM5ZH150swxyQYbMZoXLVgra6pmA
	 7uKLkZsbS0qn66ET3GVWOK+1z/sw80hXZd7+IjVfGvdQ/J/1N/suXzW9fH/2C0Zssc0rz
	 ypvtGrIlmMcy3ICeJw+GrDnXNBiT5Ri9Dp0ojpEdiVBbA9vv5PX4GQmTMmIx67g27hOzl
	 7BXUQbuU6+fCoGOjqwdPwbB5v1d4ksbbC2zzBSe4iyrohVkGOxbcOIiBLPsPZrpOLVZtz
	 g45l7mZYKGPLoz6dQE13ldMFOG55BFRT0HJUzEPtcQKCVne0nvE0DgkT1KvDO8hfJTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=epAZ38cO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92589606A327
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 18:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92589606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=epAZ38cO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPRveCUkbdjmeAQufXDfBvDGzFAFMfNlB6EkL6KwLVAdUvKxAfiqBYaPrNCw4LQWGUCReDfOV53M+mvYOnsYkE2I12ih+82jPSCE4Vhkf4lB7tZegBDf/+7sBP6IkNsAwKQnAfNVRpGvBnKGkH/hp78s8ixAHJeJQZYdD9YnhnLRASMzKsMqk1AgUW+b6a9YoP+m29gYeY6NuoWZLaX45gPNuxxMYXVsmsaqqeW1oWZEWjERimH+8VR4kQZ4cqs7btfcFZvJ2cS/NjszJI1A89c/V+MT5qw8VwbIkYElVxGc2+nqOXVJGdtte27EzE+CPZXs+L0PzgJXzcHUFuWPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QX6Pc6/saU4t1AEofHtwkc1FWrWZM9QpWwsIVbqG70=;
 b=JoIV+Sp+beJlqwdQcUn9IrQMEfXchgxbL8prHgZ5Rx/b979bBUx2bnn29G3bLBVItDljKtZ4rkNFOjxxogDH5HMtSgvh/H+QsxvmKTM1yMLkeSEEfMCyorcIzd+HfgAINshkNlKap5XWaRj4PKSBPZV84f3AZu90ng3g9sMZ0F2vhFI9YvsceCojGIuI7pV5egWD4E92J2c1CglzFO3UjvJ8j2aC38iW6ZPCOS+X3Kwc8CqMu4zKbCGTt8FFLKOrX9e3ZKnvm2E+3ChwI+QJN58sb33fnLhiu8BjeaBbFA6t8oyd06cY0HRwSJupEq+HY6PMOfj2ZDFLnU1GwXQSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QX6Pc6/saU4t1AEofHtwkc1FWrWZM9QpWwsIVbqG70=;
 b=epAZ38cOeosJgbYNW3VLrmZaT/+fujkGBivY+EhIWdjJurJXA0M8MqpWB3/24+UGgjj13MXkUCQ3UWMUrKQAgkL3unnz9cOQHD9DhxXp+4NI8t3X2lMQiIV0QfzW7ZF0LhVwaJqcvsGeRTBcw9iA7n+mfRaHKPm7PcQ7Misf4ypUSK8z3skXcl/+VVFCSXhYA2v+opgJRviiaFbcXPAletTieleKTUfjX+/s9gbYdK2nANRgquSmriWcDvnd8FhDCYPCJyukcJM71B6g0kCsAFnFuycr+LavM2uqTx+h/aw8aTLyG/n/155i5BoBSL1lU2knMLC4KwddEXAfmAgVWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:781::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:08:42 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:08:42 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail 6/7] dovetail: trace signal notifications and out-of-band returns
Date: Tue, 10 Nov 2026 19:08:46 +0100
Message-ID: <20261110180847.633167-7-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110180847.633167-1-tobias.schaffner@siemens.com>
References: <20261110180847.633167-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AMCPR10MB992240:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcfa12f-b701-437e-01af-08df3f55a729
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|261009223027099003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261021123027099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BqQwSg+jjxEAbOvrkbxNATpTyVP7C2oWW/j3Kxe4dkq0JU6FJp/Jpz0U/59SCZKxQ/4YMWN8QlvlTJ6nIePY/GWs38dNGZQ+QgMi2Po2LFcdIYLJJPLZ7HbC/HcVSWZ4txEQwmiFtKbDauF2hMYL51Mj18nvCLhYVRqCVcZEgvRoLDryrDKNgfdLxsTNRmWRrQe+62UQOEgVwvheP88os7fPxW0UNcwQdtY6FNo5BYm5p4CMpGiR8oDxp5I+hK35cfFk64tQPEer32cbdD1xUkMLCOCKleIuq52AturHpUDBiodSEG5VgYxZXQ0MiqEfOvcVpIt1Zg1m0Px2VCPhDx+2JCQy+s9L6v4Dt2gkMn2WTKLsQzFN1082QHKd2LSvSKrT+1w0daGlMCfpBQiqHcMNSFZoP0AEwkQDweXzl9UOJaPeWJvZjB3qj16PT9NHCeodJPLQK9pMh3190h0Uqe8WNtiWhYz4IGiPZE4kWtw9rcYSqagL3Vrg9WRD7+CnlGoSQ4faHtkw7FpGxWLz4sm032fZ+6ZJtnzlY7EM0hE5UOea7Owoasc0ohXZZ/hUZq2r9Rb8g1Giz1RLdV7vxWfqFgBhCe0nPB81vgNtnDQ01uDrZZEUbAOWoT+0nhFPCeP/7pI4dR7zHB8476Ay0OtURzORzOkzd21kGV/xRmM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261021123027099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GNKlOXEc93Rxlo9CkPwSa/sxXeNbiOrQWSDdcnWJvt6anbp8b6SAugGpzIFd?=
 =?us-ascii?Q?1IrNfeCRHcWFF+Z0aeByhRwfpUBEr/ZgGmvsLMlk3QR19lMop0o1jdChgUbv?=
 =?us-ascii?Q?YRRdppIRnrYxvOV8M69BFUhczcUdyaJXLMe1YPyccXBOHoW94+31WFvKKaz3?=
 =?us-ascii?Q?EH9ndoZMjCgH5Sf2AE3/MtSSCtebY6pXkFeCoBpqIOzxgmNHdPHaQWDCiaxF?=
 =?us-ascii?Q?bB2M2jiVtlfbGi7KFRQ/s7Fs50ISKAIEVR78LcqD6HrDEAOhKXgPoMS0eU2n?=
 =?us-ascii?Q?x7orud/TfsVEWGfXkeYJuCSWzA5f50DEbab2EDK4cpqPq2Z0gB0HBaDMWhBJ?=
 =?us-ascii?Q?S3e8bid9HasreDwmHEfXtwdvI4Qtz64a7ZPxEuI/9exnTERd7qfUvDBcdIO/?=
 =?us-ascii?Q?kctYq6erNp3WXj2Auj2p/OwgJBdvdIi3p295FhOliWskzuXIDKSGD9Ak6D9f?=
 =?us-ascii?Q?w8tw68PXmnZhvvCbiW2kXgtN+rKRuCKizmXf4LWW5Sm6GAPl3v25Y/DyvWHk?=
 =?us-ascii?Q?pflYADZRxC9EG+2WvtgF5lC9ckklQJn2U0wjV5nigifoqtld+cSKcRVb7sx6?=
 =?us-ascii?Q?V++gmtXOsm7GwEDQSFcwSNQJnEGH0BjthleutlbTFIGa+5rSPqahqJnwOX4C?=
 =?us-ascii?Q?DzOf60nwnWcFu7oRZ/wUgs/hyI0Dqj1qAsqLxCb/Iij7Wt4kT26ZT3voP3ao?=
 =?us-ascii?Q?W2mfGJf9v+Lk1TIwU2E6jTpxvAPxR2/e2KIMrm0SQ/ev2VrM4aqWH2QMbaF2?=
 =?us-ascii?Q?1/+SWWBD41F+WTl4VezQ2p3XBBsD8wAytU3ckufshy4dHsqjxZc8fh4CcirZ?=
 =?us-ascii?Q?kzXW4mC2QUxv9BwyDQH80iebpjefoHEy6EE7P8+zw0gaFw4sQq+i0n9fqK0w?=
 =?us-ascii?Q?QBXvtjKJ5eIo/yAjL7+ntj71OryBYQtT3UnQ4lGDRAYxhoXfNFMkXnfNn46V?=
 =?us-ascii?Q?k2Jd3PGuXZBdiyXME5T/DgtjMGCI/TOYvD1QE4eF8LuQ0220AebmpG4DtE8I?=
 =?us-ascii?Q?3VvPfonAV6gsF7GAhQ/aLSQoSIguO6FoB5gVfJ7w1PyNgcNRCT9VOHxmBpkM?=
 =?us-ascii?Q?C/aUB/g+REF2XbwLhGEg1c/NIBugXVbGjUnydHfeD6heymRGRf7rCO9jDq2E?=
 =?us-ascii?Q?JeIeMtwfS8RU2JewldiwwA0gN5cHP6ICnZ6XmgVWHeWd3cT4p1msXnNfIb3i?=
 =?us-ascii?Q?E0InladRBwcudiVeqFcC2ymWsjrL7QrafJFmQDvqjAYsYlfWDXKn9BaGR3TX?=
 =?us-ascii?Q?RGoHX4C6Jgjv7Udo09N/MZwrp2aWeQPgPCqfqge5c3Q+l8w/HYxnxAU/FfQU?=
 =?us-ascii?Q?yeO6EAw7qQZ5cgZCleSDy0dUJ8gr/ABqG3HGpwbBVwTE1VuBjeNHiB4L4zT9?=
 =?us-ascii?Q?iAXkx6IxXK3LnSGMpAPvbVUnuq2fTMA+u02PBdtJGOYUxCshe/Au2Q7B1OdW?=
 =?us-ascii?Q?pzArXbAGscZv+bqj4ascy5mvCG0xfrvS5LtQ0eaq4dq1H6CHddmt+A/Axq9d?=
 =?us-ascii?Q?2Fkv0pUuEY/QMyKyPYig+CR/81H+5mtpIhRgE7mRxZQDT1oyBp5+5jg+kh2C?=
 =?us-ascii?Q?WWuGUDl2FY1EWwrio94pQdbBQyoXIW6B+E8i9YjXNFgHlIc1cwTJXib/6cCe?=
 =?us-ascii?Q?spIMcyByRAMXP+CHs8/HUxzZaiIrKZcUdNq1q5Zl6SGCjJoNehUd936hqHLy?=
 =?us-ascii?Q?TwtWuhdBb8UBdbQAn+Dy4mDjIcgojw+/+ukRQbEZTR7rzvVVw9nCgimvbhdp?=
 =?us-ascii?Q?swUhLCvBazDoEOiVRiPopzhCP3b+c2U=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcfa12f-b701-437e-01af-08df3f55a729
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:08:42.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Z5cU7s2vqnTcBAIBhCt3Bm/cWURkrkihFEoAkpGSd3D/eQxINdLtnyl0bsIlMJEN5NmsYwzevK8zlnvlBzC2h+yq9vNheLarm53G92KJOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992240

Add a tracepoint for the signal notification to the companion core, fired
once the core handled it, and one in dovetail_oob_exit_to_user(), for use
by the oob_signal RV monitor.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/dovetail.h        | 8 +++++++-
 include/trace/events/dovetail.h | 8 ++++++++
 kernel/dovetail.c               | 6 ++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index 5ab07e69152a..a25a4ccfbded 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -85,10 +85,16 @@ void inband_event_notify(enum inband_event_type,
 
 void inband_clock_was_set(void);
 
+DECLARE_TRACEPOINT(dovetail_signal_notify_tp);
+void __trace_dovetail_signal_notify(struct task_struct *p);
+
 static inline void inband_signal_notify(struct task_struct *p)
 {
-	if (test_ti_local_flags(task_thread_info(p), _TLF_DOVETAIL))
+	if (test_ti_local_flags(task_thread_info(p), _TLF_DOVETAIL)) {
 		inband_event_notify(INBAND_TASK_SIGNAL, p);
+		if (tracepoint_enabled(dovetail_signal_notify_tp))
+			__trace_dovetail_signal_notify(p);
+	}
 }
 
 static inline void inband_migration_notify(struct task_struct *p, int cpu)
diff --git a/include/trace/events/dovetail.h b/include/trace/events/dovetail.h
index 86d6405e84f5..6ac5a7fed420 100644
--- a/include/trace/events/dovetail.h
+++ b/include/trace/events/dovetail.h
@@ -26,6 +26,14 @@ DECLARE_TRACE(dovetail_trap_unwind,
 	TP_PROTO(unsigned int trapnr, struct pt_regs *regs),
 	TP_ARGS(trapnr, regs));
 
+DECLARE_TRACE(dovetail_oob_return,
+	TP_PROTO(struct task_struct *p),
+	TP_ARGS(p));
+
+DECLARE_TRACE(dovetail_signal_notify,
+	TP_PROTO(struct task_struct *p),
+	TP_ARGS(p));
+
 #endif /* _TRACE_DOVETAIL_H */
 
 /* This part must be outside protection */
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 191fb651e396..c25ad3ee8e02 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -25,6 +25,11 @@ void __trace_dovetail_leave_oob(void)
 	trace_dovetail_leave_oob_tp(current);
 }
 
+void __trace_dovetail_signal_notify(struct task_struct *p)
+{
+	trace_dovetail_signal_notify_tp(p);
+}
+
 static bool dovetail_enabled;
 
 void __weak arch_inband_task_init(struct task_struct *p)
@@ -115,6 +120,7 @@ void dovetail_call_mayday(struct pt_regs *regs)
 /* Returning to user mode on the out-of-band stage. */
 void dovetail_oob_exit_to_user(struct pt_regs *regs)
 {
+	trace_dovetail_oob_return_tp(current);
 	if (test_thread_flag(TIF_MAYDAY))
 		dovetail_call_mayday(regs);
 }
-- 
2.53.0

