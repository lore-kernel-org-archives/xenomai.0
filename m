Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334123;
	b=LE+Cg/Mfyb/Y0v4eA0wFLVA41vIO0xRsRz0wg70X5KvvfRL0huelxQqv+T247a0Z4OMd
	 zlcRmz2aUa/Q5mFHFa+ZL/uX2cUIgcEr1PRS69ch3m0vVSaHMigpH1OFDyHQX94k0h96Y
	 locnTtStD8sDtN6G95iF3N/7c1ksRNqFfmqYASnuV8bqQ0O8QLEw0cMf534WqK2gIFV37
	 bBdIQe053mTO0GcA5Wmmn2YnAeBTBOnE5N+W5YMZbVYVdbBaU93VM/jxSM1eL41TDC7OX
	 7ZIrsVGxwdLrsxdQlB4yerz/dG2hRdIDylIrJvM/dwpShnYferSqHcwEtHe5Y15rE+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334123;
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
	bh=KCrP3ynNYsRF3P28/N+5XBsrtlVJO1pssoNPHwQ6IsU=;
	b=2MYwHBQmmcFdzYl4Psv/cEDX2iG6fBq9hYGpFDr9n4SN+Muu7ez2A18NqaRpCQ/06SsX
	 I54PM+mKIQgGmJbaV9h6nGKHn3UlURShnmzBu1nIP3EfqZ+EH+XkdivUzw9XCPKcq2UKL
	 JdFNQA4Ct5Od5as25bNEInNfLrWoBdOVYtnhnKzNhelo6x5sWMAbeSzS1y4YQGphAbI6T
	 UAb4g3owYvI72bkdhFQq4xogLszxtRtIVkxSgs6+rf3ez0zD77fVx02PLIG53Chrm9VRf
	 zHXNRkMHbEL+u2K8w7KWWkdpvIaBjmP2rKIy/quO61QwW1TfydFCv8ywtggabkP8i/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="q8n8a/ky";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362F606A331
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 18:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C362F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=q8n8a/ky
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIE4m95kAcOfG27PmzPz6CXfzhMKa6T9LBrDaPaZe4yMnGHY9TFdY/zN5/3vEXozM56vZSFRrkkOri+HHU8w83aWKYTEWoKlwZQUSp/LcpqwE7wxiXCbzBQegK4679csuaDgO3szhvFssgEzpQA8oo4b5X922kCQIKToKM7u7sUXbuhOolQVgXSAGDrmZuQ1F9OBsEDXKi+qIYaEpGMF33umPTkYKbrI4wvMBpSY7VvVx++YVKAlWwomcO+L1kAADzIBz9Y+Vf9oh0skpyLxU2QPWGQyewIQGyJUBoAzEZoXmyRsOPfhm2PVt/zTpJFN4nveehoTSZKdhUeS2624ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCrP3ynNYsRF3P28/N+5XBsrtlVJO1pssoNPHwQ6IsU=;
 b=qMYF+HiKog34mKLJOw3UkY2G82CEYx71Uf7QGYRmf7M8A2ZE9QfcKP8Peh9whS8uqJhjHDk+qhOWugI/K2zt6bbm8luwesBzi6UOMurFDX0n0jF/UFBbt5VVYjHlP2bLvnT/fJDBzGFtlKfP/fjOsa4ExrFzkSgVJiD7wHWhvNaPKdYIZUe56CayQgs2YaHPwYoTbgikAl0iZ66BZ/gO/JKzQPa4g3mkzalMN9mYDEf8oubVeTDjpwr4gRyNUUsAS3obMXzLb3a0ZXEQCe0zRWjlPA/jopJwT/YLOnj8F2CljfhOlIk8T91o4i6qDfopUuRML5cTGLKkdrMgD88q3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCrP3ynNYsRF3P28/N+5XBsrtlVJO1pssoNPHwQ6IsU=;
 b=q8n8a/kyYq78/JkfufYwXu8NpXytqTPspkKHetmgTUIxZz1D6+XX6Qx+PSlOlDFEzYJlbiTJ4kDmGyODQM3Qn6Q8YCJIoOiQzJ2v5NwGUtXNMQy6eeYV+iO+xSei97PwdFATPgh3ovHiZSdOqgRys1u4RpYGwcaD0D6EZ5rFcetXl1rY70kEioVisKKHeaDmkqg0QD97AjOWymbKcgFMDcY+KNkp2IYGuUcbwCfrAY+piKmdH2ADT2CSmOoHRK04ZSYzh0fxtzt0WGACdgY2wr+i6FJrRtlC1AwoAuNV3EwIJKrv0fep4OO70+3fwzuAGM+jRO+VOkdRSZRrIZ+fDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:781::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:08:39 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:08:39 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail 2/7] dovetail: trace stage switches
Date: Tue, 10 Nov 2026 19:08:42 +0100
Message-ID: <20261110180847.633167-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9cf3e15a-2cfd-4917-bb46-08df3f55a584
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|261009223027099003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261022075727099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nLiO8b/c3J7l5VTsIC5jF6ftVQLuhUTSuH44388SJpwaSAmWv4PeJCZAxhH5s4I2HckBa2vPWiCtfFovfMDrzhod+uahEzDpa48a8GcTq5A0QMEQbOlGM9v3RxsGjyNGg5jZIl49q+hwpvdlKzSk/NzBwo45aX2iJSWeAEZ3GlaoNjL0jkExp/4+l3vmflcqu+3u4ZMEVpDn61WYujm1le+mfRgyLwn6n31YPHEFaWjCZpx3f48P71fQ/tJi4zATCG10DC0d+0EWQty0axOvgDB1y6H3CuZxE4+sAx8aEayqr+d2Q070KpE/s4X93q9RAylA10xj0aNEsOh0IxOO4l43mFPnhGzoB/WQOc9EawsMsEuV/OgFpjm28kgAiiwlC5+n6GiuFZW4bozEcilQJaLR0q9SzzbMgMKSgLSh5U11WeTTVJp3kwVWvzjoAHWwUGlzyrXOLJj3GVxEriB7AuTaOBfFEClUrEJvcOHddjRCIXv5H7vaIbumazY+2SRSyzYHJp/f8Mk6B9NSXbXLJNfqGfwht4jKAgHMF2jH+Nepebm/41BFzbfYcMh60dkc+cuBGg/sCFuuTZhlWdIDA++qZBNo7C8ZOc+2p5i9DwMKv/EGaOUV5A/TzXnRqr2Rs1Vgdd3Agwfiij0OxNkGpk78g0Pt4Fz0AaZPFDgsE/Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m2Y0/znhC1J2rls4xtlHsaCf1Rk3gWmfOwqdTvzX5MGT9U3z3765frRjkpfL?=
 =?us-ascii?Q?DqLzD0UDD2f7xwzczoMCWmOgBCO4+1akJsqaEDj9qwXDEvJdPNYQXJivyPII?=
 =?us-ascii?Q?SinAIfVs+qQfA7p29bjIWohmX3v7RgDPod0fD7lN4AViWK4UNxRQxtSCHfDj?=
 =?us-ascii?Q?iSGy7rZEC7YKKOSnGiMrLsYP7WSIaQZiC7ciM0xpCJdWhlZaIu/wLoTOBMhl?=
 =?us-ascii?Q?yjYzvRbxfu3ol/DGXxisbLfVZVMxYptFleSQhVUrkDe68rulaSfWJ+RlTLr1?=
 =?us-ascii?Q?ATFk8/oHYZ7bhwRGQVgWaj1VyazmGnIBLw9I4k+VzJ30GZSC/gYUub1xlx5c?=
 =?us-ascii?Q?IWrDRATY7mzdAKT0U9mRV3guXgkKInw10Xttxnq5xOq2f/Gwh95U6G7YzKxj?=
 =?us-ascii?Q?CADpAquRPt4e/ibIzumpR0Y735PXB3wsxxiMyn6VOb+DXhWwFe6B84CL9RVn?=
 =?us-ascii?Q?GeyrKHaBHKhNW2P8PIUaxzYf9qNqk5R1JvKV/n8WE+nmclk/tdIoUkJaYZvM?=
 =?us-ascii?Q?5zPm0px+O8S7TleMnWcUp07su4Ercu2xFjRRmvCd3rl7MO9rm1q/UYFeg52B?=
 =?us-ascii?Q?4eh1sVO/0uHPB5equmrJI0rc5VXcvZx78shkweZNtEM1Ob1aEKrRGRwThtfD?=
 =?us-ascii?Q?G6wawtfS3h5CMIfHl1UfDRvptVPlkA2GwtkEZDbhuO0dtQgBfsRP3YejUM8P?=
 =?us-ascii?Q?UOcgHeaGFR+2v6s/RgZyUSWHRv5cp+UaDYeUnN9WUZspAbjYrzMBCppdhXqo?=
 =?us-ascii?Q?AqucIqnbWv0s+46r3/QVWUp2YePXJadsDVhwywReXhwwuaXLHHQB33YHX8Zt?=
 =?us-ascii?Q?1/Di846GhBbU7nzpylY0npm5EiyCs59i7jNX4RrQxCPscEI6vHLCASZccR2e?=
 =?us-ascii?Q?yuxGWbgH7wfYD3zEG0jX6EhOgUIip0Gqb8HSPa9sN+JF22Qlo3mOhsKKyItB?=
 =?us-ascii?Q?z0iIwj+sNTZd+CkZzagkZqFVm3Y4NXO89+j3eDZTyw96py30ctxA+gameluC?=
 =?us-ascii?Q?CtN9x6sxpdVw2K+CQIqxpltNuJiC++btfBzuIiCI7Ck6og+rn2uoBNtxO/XS?=
 =?us-ascii?Q?8LF9fxW3KixTDKLnMBx9fsnx39drgg3gGYMWH9HjsRDC5jmVplb5f2gZw5Th?=
 =?us-ascii?Q?eq71gYumMhlDW+z1Xzv2nXznXPbagOmkoVteOVi4p05bNAnIexo1XgzvUvys?=
 =?us-ascii?Q?D4pBQJcKAWVhABXQ5ZWh34lM+oDCR7Cs2Ol0WSySrtrqB/KHEZ8Tlx8ZLdBX?=
 =?us-ascii?Q?5uD5TFgQEUhJAbuXIwIPFRWKUY4qyYF6BZRakTOUwA9cLXVSDRsoGmb/HdsK?=
 =?us-ascii?Q?NLkxwfQukErtHz8mMIcdkwyYFmQWLNjSDoWhWxMOLQTSxIRWnBMmqHGY5IwP?=
 =?us-ascii?Q?imciE1+IoS1M2eMSE3e3z1tU/yrNQhOJFp9WHDAo6n/+BFT7/Er0Uv09TxNC?=
 =?us-ascii?Q?eoO6l5sW2I75z8CY2HFNJmPkYN0OaocakOq1Fji+Hd/pEJ7qFl1uFqrCzNuM?=
 =?us-ascii?Q?vdr9xMmLBgs1ait6AkSJSMLgjiqrcpSiXih1fFgfzedZ3ONOOCkqRe8u2C0/?=
 =?us-ascii?Q?FaKglrrGPkUNvlQeTcKPjXcMJOVkx86zARVfrzbF4vmBveTXU9sCo7jlI5Ko?=
 =?us-ascii?Q?EZi1AzOa+6ZIYAElvo5bkoUdrnZyXuqHMDwlkv9Oo/ci2ew4lzYU4SF1gFCm?=
 =?us-ascii?Q?3rOOpTxOIc9zphzXIeZKhTnLUD6QR5Wq4HOg4wuxftWAeOS2YjyVUfv7xU0q?=
 =?us-ascii?Q?OopfcYewIrNJ0hlXeHfRrTFPUI0nUUg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf3e15a-2cfd-4917-bb46-08df3f55a584
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:08:39.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwm1t78J7DdPn+ZbRBtRpqcZL8StZOCn7iX3ZIE4CIzrWpxWcZo8jkkdc4gZNLFWWNaxHZFn2JFonHfWjRqK9+X9bQpVsDTJ9W8DNUdD/xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992240

Add tracepoints for a task leaving the in-band and the out-of-band stage,
for use by the Dovetail RV monitors.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/dovetail.h        |  9 +++++++++
 include/trace/events/dovetail.h | 23 +++++++++++++++++++++++
 kernel/dovetail.c               | 13 +++++++++++++
 kernel/sched/core.c             |  2 ++
 4 files changed, 47 insertions(+)
 create mode 100644 include/trace/events/dovetail.h

diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index b41ea0f8fc4e..5ab07e69152a 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -18,6 +18,7 @@ struct files_struct;
 #include <linux/mm.h>
 #include <linux/thread_info.h>
 #include <linux/irqstage.h>
+#include <linux/tracepoint-defs.h>
 #include <uapi/asm-generic/dovetail.h>
 #include <asm/dovetail.h>
 
@@ -163,8 +164,16 @@ void dovetail_stop_altsched(void);
 
 __must_check int dovetail_leave_inband(void);
 
+DECLARE_TRACEPOINT(dovetail_leave_inband_tp);
+void __trace_dovetail_leave_inband(struct task_struct *p);
+
+DECLARE_TRACEPOINT(dovetail_leave_oob_tp);
+void __trace_dovetail_leave_oob(void);
+
 static inline void dovetail_leave_oob(void)
 {
+	if (tracepoint_enabled(dovetail_leave_oob_tp))
+		__trace_dovetail_leave_oob();
 	clear_thread_local_flags(_TLF_OOB|_TLF_OFFSTAGE);
 	clear_thread_flag(TIF_MAYDAY);
 }
diff --git a/include/trace/events/dovetail.h b/include/trace/events/dovetail.h
new file mode 100644
index 000000000000..785a653252d3
--- /dev/null
+++ b/include/trace/events/dovetail.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dovetail
+
+#if !defined(_TRACE_DOVETAIL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DOVETAIL_H
+
+#include <linux/tracepoint.h>
+
+struct task_struct;
+
+DECLARE_TRACE(dovetail_leave_inband,
+	TP_PROTO(struct task_struct *p),
+	TP_ARGS(p));
+
+DECLARE_TRACE(dovetail_leave_oob,
+	TP_PROTO(struct task_struct *p),
+	TP_ARGS(p));
+
+#endif /* _TRACE_DOVETAIL_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index da4016697b67..98892f0a63da 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -12,6 +12,19 @@
 #include <asm/syscall.h>
 #include <uapi/asm-generic/dovetail.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/dovetail.h>
+
+void __trace_dovetail_leave_inband(struct task_struct *p)
+{
+	trace_dovetail_leave_inband_tp(p);
+}
+
+void __trace_dovetail_leave_oob(void)
+{
+	trace_dovetail_leave_oob_tp(current);
+}
+
 static bool dovetail_enabled;
 
 void __weak arch_inband_task_init(struct task_struct *p)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3ec77a682c4a..b2ad0ab0626c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10689,6 +10689,8 @@ int dovetail_leave_inband(void)
 	 */
 	if (likely(__schedule(SM_NONE))) {
 		arch_dovetail_switch_finish(false);
+		if (tracepoint_enabled(dovetail_leave_inband_tp))
+			__trace_dovetail_leave_inband(p);
 		return 0;
 	}
 
-- 
2.53.0

