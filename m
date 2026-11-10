Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334125;
	b=o35fHVps+utkAEZPe9bw+l9EVbYE7uyukNtn/c4s8AklC9ibgxkCio/DZwRPBfKFgZlU
	 HIIYt7PmaWPhIczsKK+Filq6Ysn7Vm6ZJdwrZUTFUb4JvudSHrUdDlY8RM2aFl3LTcniA
	 EFLfb66Cw3oEs6J2f6RHrbm+izPsM6ntU3ZXh9/nUpSggMvcircSO52UpEDd+AYJHVBJM
	 QZQNnLC2TiNXKhClI2rWBaBERUwATVXE+K4aArqthUq/7rmjbCmD4pOgroStsn987Ws+1
	 Mtx5REj7Ly/lWMrD2HXFRnag6xyw8UIozOj75gvW0oor7E9JKnZZWC2wpvbJZ7jC0Yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334125;
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
	bh=+7mZtYx0j7IA1HZuCiH2UBGOuR1VY3JYcWZ7q9XDhLc=;
	b=X3SSDOqOjaTY+I0yCHOo0/qod7ZCAuuIXC8DNMPQS/lP6ERxp15h+GM7+RhsoiMf/4zW
	 +pjzFhii6rniN/DnGQ12jm8yc5JslcP5QaeQNN1NuWR0zDQpGxrRifxidZYRZiK3EOfpM
	 5lsDZX6KnYQdlIa7UmQCVi7BKV72WIQBtdHHJxczlqF1JgQ7TEe0K690Bjo5+5agH+CeB
	 QTIKYnwycGzV9rYapeJ9L/HDELYNPe7TTCXZdH/hlTz/6FHboNIHGpEvl98r5tdEp9ITv
	 5b4lDZnOujNfQ3TLxO+Em91CQ3cLSGNSAZDlPrS48zTI2P178tTgn51VQ/aeLw4ExXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="uTlOWQ/g";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FB606A330
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 18:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF5FB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=uTlOWQ/g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjnNtPQlyF7PRn60pgAWVtXHrx3ws3hfgVsQXc77P291GSS1+sPGOvWvo9KRThjW+2EcCo1+6cr6hyPQSZqChZ9SMeT6nWz1eTkokMh8IPu+8q9Om0DiI1fKkEaR4h/LgmIhizxdDs/EPhf/zdurSLmAAXrC5CFRUgF6wU+lIJPXoTPxH4wHxdBmSYwthq284ovoBRkHRaW45n2ET3velwxvZ3poAGbqFYKaSkUy8tKZp4qmb7sei/6VjJlMARkIGMUQy7KgrEO9xTiGjeg7hYNC11rpNOQvnq+jQPbFRO4NuSnha3Z2LkGax7suCXhfB0e02vyTQsR1E2H43EXSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7mZtYx0j7IA1HZuCiH2UBGOuR1VY3JYcWZ7q9XDhLc=;
 b=eWc5TKZKhqejdI/AvDzVVljYmGWUwstQGbWz3gque/TkyyNlVaVvuOfV9Q3UrO+k2XUTRdKWFFhOBF31jXle/SkA9ION7OPXMeKdbx0s9iDalHw1c2mLiW9bjuqrqMRTDVKgyHZ/SsamfGs2HmA6P/ksR2lvUL/Ok0KKZps1DD6KRgofZHEPvepPiS0P0MBNEtBEEqCj4UFJDeNTMBzL1eGBsc0tdHOedS66uOf097Wo8g6W95wxG3XkChBg4fjGp6FngUBAs0IaD+REml/i+A3HoSqcQ8B3qEcFtBtNXvpqd4mckSnfIIfM9oT/9Jx+3FIv6dr0dWrD1AoCuT7FXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7mZtYx0j7IA1HZuCiH2UBGOuR1VY3JYcWZ7q9XDhLc=;
 b=uTlOWQ/gCLVpiez53lfx5iEykgM/HNHWn5IbbOXNoG2zopqInxyMBgXp3GuOAQ1F3XXNkM0rVp+jvSMx8cynwtwnSoTGuim8HBwPHUIfq5m4ekpeDohoD+hpVvxlGXFERuOqS9tcqp6gl23klPqNhL+ET30T7vVSaB8PmTpBGy9lJuqSnNjaq9zofney/Wytg2mrkofLT0mdyYt71EQhz2LZaOcK2r8Y9A4qv9IMAkgrloYmEYE0iFVk0KJcE4q2I//AiGqtGKk6qZvCyXUE5wsykQCl1BM1g9v3lNzHCUdxw+wL/2HibDcp9g93T7LnZwjH+E2/0L7iwR/9+lLW0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:781::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:08:41 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:08:41 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail 4/7] dovetail: trace out-of-band trap notifications
Date: Tue, 10 Nov 2026 19:08:44 +0100
Message-ID: <20261110180847.633167-5-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 538b9cdd-000a-4cee-69b3-08df3f55a66e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|261009223027099003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t/bv2FjyvQhpSpsdUXs16jmtv/n4zf9Oizd3fqrXXl2grZRSv3b2/IEw0RQI1z3t3EBqHr9Osu7LZLUH0pfURkac3UA1j3Aj7YsYIjLQzsmRken4cA7iUm4Wf+aP40bZKDNaTGZuishidN+VOtTihGMGrEA3bULQiVuD+X8nkX0qqV8+NL4hFZ268jwjkD28DfqH4EFXM8wd0SHJRRvLHVPuLBnSpqDp3vlCA0e6Bf14vF/iB1Xc1vEPonETd9Q0iByU3wjCS31I7dxcIuw2GGrvNW/Ssf0QT62l0cz+F+QRDmWYUvkGDSepHUr3RFxTUfYr0fOtS3OPQtw4Ueb2Z/WNfaMsmNRz5Er0snk+T2QYV8BJg4e+xxLgxWQXFL0vyxy0YyWY4hvEpPsWrrV1HhKr/UFFzDMEVSTCXq6SUA/X5N0vO+TjC2gqYKVpaa16fUBCX5qwHNJ28xcPn+sS8PkTKG7vUwl5TR6FFQ340nDOZAFeFgXqvos1Z+JbFmAKbDyifA7P3BvjqP2pMC5/NZSTiZDRujbexI6LQWr+zBs1DlSdkNy9EiYZ64gbWltUDkrE6U931ZzHokC2kwsae7iNJm0Diw3fy/uyv38SHy0djtD/EUBPJvyoRolK7MgmUyvOb391RGLS7l8nfh5A3P4uidGznJ86XsouMCRY3Ug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D0OtPpH9pt01vIWzLVGDA7lpaN+1wq+1e6dSGBB3ZiSsCcT8umiRB7PdjSgr?=
 =?us-ascii?Q?0YUwVU9RegxBJBcBnEu7VUNczQ32xex1exq5TVFIdQlcX543Rx0bqMHwbLPO?=
 =?us-ascii?Q?ujjDY7qwleHa/zm1fhz95dIldO+GFKVHmuV7dwZDdweYn+Sze4kIUmbfPgdd?=
 =?us-ascii?Q?B5uy8yJbGU3KFu1Tzj+JL1eO5zMnTJ9blZyuoIX9IO+fh48l9TbuQM5Trkyz?=
 =?us-ascii?Q?9gkhS34YzeifTmCsG58/ywFpHjrPNeqG5Z6m0HZqBbh04DXEOGBl5Nc6RniF?=
 =?us-ascii?Q?96+PvLtVpaUJLSVgLRaEIH4GLYzUVviS9+fR5THSMctA/rzS9sY22f6E47NI?=
 =?us-ascii?Q?brWv/R5mHbnrPx1sJmstg85QjVqnSLlqVuypMRNxdwJj0/opCtOJGCSCxwla?=
 =?us-ascii?Q?VBJZpq0/1GSv/xTW4bnAFR7eNzyOt9NKHn4ikRFZ3ZbVbLaXxaEixHDkuKfm?=
 =?us-ascii?Q?J+VT2HQH5BEUjxUDE3ksgCcYn9+7gXm7ZoE/BRNY+q+5omsikTKde5ejR3Tt?=
 =?us-ascii?Q?C2Gpd9ebxLmCc+jrHNOF+QRX+zkkeKHyv+AriwHaOeh+74LOUkITf4YSjN9/?=
 =?us-ascii?Q?pKmvaGTtRnnBOJpLLTpBedxgxByqyHWSCLWy2kHRNTcgPvG/YW1KPDaWLucO?=
 =?us-ascii?Q?1s9cwnOZfJYBLt66Lmm0raodhAiX0yT/XIlaVetzov6+4iGvXDDuRB5gDcTf?=
 =?us-ascii?Q?2bgMOrMIerH6DOr3FtcUryScxAmz3xg8Col85z5pG87fKcdoies+WajMgwCE?=
 =?us-ascii?Q?6s4Log6xFhKDrLsGxG6oQb9jzNZQoKpZZYRlcVitsakg+iXK0bi+Lr6N/7qF?=
 =?us-ascii?Q?RddJMXhMcFH7wDYk0y1rsT03IFrRhILIAL9uKnwfSS2IVxk3sNnjBhdT3Ybj?=
 =?us-ascii?Q?HcaWd2ntek5nAvzy+CIDXDB9AhrNztFDhsKHSrBSjodEGbqZXlBcRg0/zPHN?=
 =?us-ascii?Q?MJyGHDGdFnuFvpICtwVPliL4NYdCA8cqux55BxDk4zJl63l2/lFd//ha5wYT?=
 =?us-ascii?Q?X2cVZiFRVbWJwhJzpAC6qY5eyyobDuafN+kIpla1Qej+NNK2R6aQbCB6IRWq?=
 =?us-ascii?Q?VboA4fKnLChbXF8lMJo9cXmfNCCWxZ0XTMfaPAwXQKeICdr3sQVrVTtpvvkm?=
 =?us-ascii?Q?WuSTTHe/WqeP9ZmAlVD4Rr19aVDgfWb6mUMxn/QevR0BpfzVxNIeBgH5SICv?=
 =?us-ascii?Q?z85tLt7ro1Pxn7ju6Ci3BlL57KYxvZQ65KbjuCDmnYaehOU+gYPSlg75RX3x?=
 =?us-ascii?Q?tpn7bZLNIZ0xMivYTrOHYulWBApIWmUHKlvpMKni3l8BUwfaTTrWGBtD0OxJ?=
 =?us-ascii?Q?5JwiQ8qQRMWBAe1RLpj2004Y4TurIKs7BBBAAB1CY80v+SmNNJpM9VMM4wth?=
 =?us-ascii?Q?U/NDAEgBUlqxpiHqqHeqaMM9DnMT3VLIJdToZ2T3EEjD9+EjLLE7xcKGGzy8?=
 =?us-ascii?Q?BWpNUxdgu+v4tzJcy9La+VjN0QPlgq+sZSIb8z+n21SHif6BDbLkztrHemj2?=
 =?us-ascii?Q?qhkjT8DpQ/0Z1RygzoTZ7HVGhsFK5qxm/iourha2FvQgN5YhgSnhbjgIEbAB?=
 =?us-ascii?Q?WIQfrFjUGU2BHEgqQkac+R6tOk69/tg4qye6rDzHY203GMcHw0TrWU6qWf66?=
 =?us-ascii?Q?IUlo3pcTy5JuJjP08ynEFleDPbkhTzHZNzF12CXkjHnZao9aFGjZnPXbg10b?=
 =?us-ascii?Q?W4Z3Kp+T5o4smsKPOEPHXzgV9vuuNFm4x0xirjDo9+UI/q1oI2xdkXjbce3N?=
 =?us-ascii?Q?0wi8JpkT9SzFXploQM4WPBrghq1up2o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538b9cdd-000a-4cee-69b3-08df3f55a66e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:08:40.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IT00nUoj2u2vbDuqo90kaKEL9b/j2ZnEd/qWy3hP3r5oLf4TzXdkoLdMoofK0Vh3XAfkgwAc02XuzhjtQU+Gp0HUa/V8jkz0vTiaRbCi6Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992240

Add tracepoints to oob_trap_notify() and oob_trap_unwind(), passing the
trap number and its register frame, for use by the oob_trap RV monitor.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/trace/events/dovetail.h | 9 +++++++++
 kernel/dovetail.c               | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/include/trace/events/dovetail.h b/include/trace/events/dovetail.h
index 785a653252d3..86d6405e84f5 100644
--- a/include/trace/events/dovetail.h
+++ b/include/trace/events/dovetail.h
@@ -7,6 +7,7 @@
 
 #include <linux/tracepoint.h>
 
+struct pt_regs;
 struct task_struct;
 
 DECLARE_TRACE(dovetail_leave_inband,
@@ -17,6 +18,14 @@ DECLARE_TRACE(dovetail_leave_oob,
 	TP_PROTO(struct task_struct *p),
 	TP_ARGS(p));
 
+DECLARE_TRACE(dovetail_trap_notify,
+	TP_PROTO(unsigned int trapnr, struct pt_regs *regs),
+	TP_ARGS(trapnr, regs));
+
+DECLARE_TRACE(dovetail_trap_unwind,
+	TP_PROTO(unsigned int trapnr, struct pt_regs *regs),
+	TP_ARGS(trapnr, regs));
+
 #endif /* _TRACE_DOVETAIL_H */
 
 /* This part must be outside protection */
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 98892f0a63da..191fb651e396 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -304,6 +304,7 @@ noinstr void __oob_trap_notify(unsigned int exception,
 		set_thread_local_flags(_TLF_OOBTRAP);
 		flags = hard_local_irq_save();
 		instrumentation_begin();
+		trace_dovetail_trap_notify_tp(exception, regs);
 		handle_oob_trap_entry(exception, regs);
 		instrumentation_end();
 		hard_local_irq_restore(flags);
@@ -325,6 +326,7 @@ noinstr void __oob_trap_unwind(unsigned int exception, struct pt_regs *regs)
 	hard_local_irq_disable();
 	clear_thread_local_flags(_TLF_OOBTRAP);
 	instrumentation_begin();
+	trace_dovetail_trap_unwind_tp(exception, regs);
 	handle_oob_trap_exit(exception, regs);
 	instrumentation_end();
 }
-- 
2.53.0

