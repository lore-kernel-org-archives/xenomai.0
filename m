Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787232;
	b=xXBvaDLPHNUc/wl8dwktQiCwdUcrkYyQuN2p+QXBTOp5AA+VcwDp5C0nuJNwqYWOBtmk
	 o4E1VL/Noi9+XZPiMB9zPTpqiBMaa9EZXjho6uiB8t+FcJDCw6cFUPUw2TFPC6hAXQd3m
	 ASo6xTJQcCEAMcklUktE0acRqcOtNmFhgIBCtg91djdRRGT5c4rdmLRoD5Cd+b57FUaEd
	 CCAaPDCAW1dfG7aP+L5lLsNfxvcmzW3jIBjdnBN2WGebqY9mRvG3ETG/r0HYfA7gU8qRa
	 ul6aaVSRZo/M3cZavy+S6C+K2TDOdI2OkmXtuRuIWG/bHoukGhUS/QscV5Gi+mvAqNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787232;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Jmb2gaANA1+svTQdHiU75x05lFhNJiPz1EoE+7EVHzA=;
	b=LM0D3S0TsVABmRFctPwodkmoVxu21FaxD7ZQ8gspM2YBRUpbvCmXdzPe8pN1sJtfmwVE
	 UMtJgLs1UWq0Qdvme8vQvevjPH1bsrLZC5XxBZppISjdTWr6Y/F4AMSMGYRqPPIz6UIYp
	 xeR1S9OeFn/Psx+ZCc94KVNjKTkhm1Pq/AB3YNR5Hxs+2OIIgGfX5F2q0dEYe9JAk3WxH
	 /H4W9m2ZbIdJAeF0sWNmdB3gFxQ4qcR45tIMBYmBUoCOQOYD93umLGmLoEX7X4uXXHQBQ
	 WF+DheE0ysqCwjfJfeFAm3Qnt5PTJ35LUf0tqF/GPweAO9yZMbWfmBmaj1TAMLlargg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=WdWCh0a9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.19
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC5606A31C
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 13:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BFC5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=WdWCh0a9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnN/5mKiFIWmRUrR8WXydFW3oVqUlSVM01ytJPy8YLlhu191p/dLLSkzj2WzyvKtYPJ2LHh9TH9IfuFGfe0DUVV/i5GHEcekanGwnkc3AwaTsicz28Njjt4SQ94rizz3Pt7wu5WyeLdqMmNSPzf4NCF4jTqZ7xZmOOSqKdvqACbDk08aDM4b7RHtO+L8W52xUTxZn5UiDDQFPml2nuOTsWIS8X/iFEsYxfMSyifTV16xsbk34ZfMjvEOFVNspA/6LDxt494//3V4mOYyZEgieRQ0egQC1OAGeEddC5qXb09ZD2RDJdorAZMH+xKpD/sir/wjJuhgjuTZ/fQUSdfUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jmb2gaANA1+svTQdHiU75x05lFhNJiPz1EoE+7EVHzA=;
 b=nZYf3hiYg3u7jOYnlUovZr71m6LnRtuJ+e6Gc1UvlpGQM1ytsDWpZUKZfUONZ6tx+h8+wzwVJFkFJ64HSONSxyphFbEoeK9nmjAPl3MeL3GlmlzU7QsGPpa9RW4Lrm68/V7ZwwwfF32O87ZlU+eJAiI3zB3pGRAimErU7+iOF0mqiTSM+JNrK7O3bwn2Rpz6V75ocBUPPXdy3yO0Q4LE8gJGgmjYk3wSbAqd25UlZ49m72tF+UiIbBPnn5xc15NjmKTj6nklod7E/SmMPoHTMbaBJcVn1xZvF/8uE8AxBZYx28PqKqmkEryL2FgOnW3HO3DAUWO00AGzbcDCI1bZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmb2gaANA1+svTQdHiU75x05lFhNJiPz1EoE+7EVHzA=;
 b=WdWCh0a9KPx3dbcYBnugZ0FGD5gcks9weM4v2WhzAoOyb3qeZrRp5VMvv94HnBJe9J81TJ2Z1nYDWweu17y5eKJtbQo2plnE8gUCMnIqw0OZBYxt29EY8L7KlUYQheaw+FaXWgloZaEhVblYTkakR2S1uurHIWCdVsHxcpLLMunJikMVYji8F2/91bzlf88ftWYiJH5PHqcGZjIn1rB6fVHYkN7++yY7ky+tYYinwbyN2vxm4D5WD93Cysbwu/fjGfWezvfudLc7V8FBZZP/qD17EbLOxLo+uMAG7tlmuHAUj/juMJywyU64NYElncUJu4e2XBeKnZ79AJLfYHWLnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA3PR10MB9260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Fri, 27 Nov
 2026 13:47:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 13:47:07 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail v2 2/7] dovetail: trace stage switches
Date: Fri, 27 Nov 2026 14:47:20 +0100
Message-ID: <de7864a68695ede73ffeee9392f5483cf7bf8be4.1795786695.git.tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795786695.git.tobias.schaffner@siemens.com>
References: <cover.1795786695.git.tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA3PR10MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 22296467-e9bd-48bd-1532-08df4c8cedad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|366016|22082099003|55112099003|18002099003|56012099006|261021121427099003|261022105027099003|11063799006|261026121527099003|261028144727099003|261022075727099003|261026140227099003|261009223027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	0ReffMp06tMv2jNeQLcul/oNzDvMquyFMtKSzfbPiWhGJr9a2DO/oUV2zZkfq3IUAUV6wJqjqNvILKw+apWrvzjSwjYQJgIGBlIsKSAj3KBfK8WOIzGVE1MmE1iC7xxzmjrZ1eioWf/Z9aRcHBJviBqp6IJ+s7sVXOxxWZfQ1afCRzML+RGlwwHWQVAGF6g97we1rPP7Bu+PlQNj2bok2VCwlwRAEnCqmtwqM3P7KrNNPXxd+Yh8CF0fYMnlNLeGn8VVVrhS7/mk2FshQFMiFJ119TEj3B9rYH6LxHcdZnhYYm6Z8oEjGTapdcvA0hNHhbaRuQ3ar+Xqoe36kKeehkt1B7z9+zwnwY1CSAPUb7AS/Xaw2ARU7syd1IzcfnFeB4SvwixTFm/UcC1evmEEWT8ue8Q41EVanUYoDuImEGTA0H3izB1x/jRwdn9iuvGh0We7MKLuFVNhUZUjHJOPSkAcDMgPIf20Dr9R45fhTXpGkx4vuob9pY2MYTq5d8p9meCWSAh1uP6CvrIX7IY0pe97Ll8cKIihak+rB5IXFlrd9SVVocICUP9eU2eKlfl7pQraDIOQHj2pu/2K32/pYlPOCbYBy7PXwgoFYZhhMjZDkuHxCDA2LgfvTD70wNMiceqBdYaxbtZxPEtXgDMhnwa+bx/T8L/o5h/LpyD94QY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(22082099003)(55112099003)(18002099003)(56012099006)(261021121427099003)(261022105027099003)(11063799006)(261026121527099003)(261028144727099003)(261022075727099003)(261026140227099003)(261009223027099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqLKyu/DMXutn61ZQRCSc6lfOAWYMcnQllmjU9k479/AxDkNUtYb5MUscR4R?=
 =?us-ascii?Q?9gTpbbFyceKnCP6lzm5/Y4aBAcvcU7cX6TVgD53qnbL5gRd4sHejQEp/S5FB?=
 =?us-ascii?Q?/HTAWUVdCEXXb1544FBLu0Gqt+Pb7bczRDvA4IcOvQJCPjeTB6uo5LXXiEXX?=
 =?us-ascii?Q?X3aR6L9W7pY1VJ8vjIMN6aoEeeUCnLoYXm26vdl/jge8sU7kXDm6OXeEVN2B?=
 =?us-ascii?Q?kdW1FAKHTYeOkvCE+mLNsT4j46lJabxp9GgeO4gUJU/UgD4rUlznxv9IN9Br?=
 =?us-ascii?Q?8iiJXQW0h9KKBoj5kYTk6WJJYNVHd+6Lx7y3+prF358CdCeag2YZphfwb5cI?=
 =?us-ascii?Q?oP6Uvai1G3e85OmQX+QuBG6+RcGGCm9oF9yGYYtKNSAynW6SDIKlYR6PdWJc?=
 =?us-ascii?Q?oVbX9TZGDXCuuj2B6WQqtN5uGFBEceA70EoDAR/uugDfhg//y3Te9im5or3z?=
 =?us-ascii?Q?jRI+smnwLd5/PLy5AjamzBK7sbd+P8w7HpLOyhsjPdC9h6xdgOUMYXWDyiqY?=
 =?us-ascii?Q?mgkZecaCK43Z6vxYz6FdSeXtj/6+Cqgn6vqySiP8/tn9zDXop9L0e9GT81v1?=
 =?us-ascii?Q?byGmV02rJBo34DfULMssXmzQhWXCCf2uD9BrjidYZp1i/DfzoLBqIV8X/Rr5?=
 =?us-ascii?Q?+cwQOq7gZqjLZ3rin8AyFew2Ey0+1gq+PtPRObexfKO8NwPTsl6A1H6AYCk8?=
 =?us-ascii?Q?isShbN+v6zsaslrPThmYIAASsBOMxpDiWmoh/CiXXehgNKwMFdU6IO9jONeI?=
 =?us-ascii?Q?XzA3pNPRBIxswXTXLl1ugeDJzpMUEy6+KKTzIci+EUglGWVyCx9Gd0RzaQtX?=
 =?us-ascii?Q?/bYyEdPcgaPGr2P0oLxNIkVBD90PqA+gpHCI7+zx7AUclzcxtnGNIw/VwQ2L?=
 =?us-ascii?Q?Z8ilKWfKYwwl1AxA1J/GctZNG3I/Qq47iYiHSVOKeNNZaBAwbOlrY50zUBCh?=
 =?us-ascii?Q?wIt6mdhKKHsXO0ywZcwqETF59asZUEW3Iy8XNkFG7D9NZVvdvDyUy7xD9yr9?=
 =?us-ascii?Q?WXBmjv/6GPj8Yavq/PbGsjsOhPts9UdE0zg4MiHvge8FdYtorakUjzO4+n5u?=
 =?us-ascii?Q?7cG7qKZR7j+exA2L5pOzfWTUEk8Plx1AHhNvVNWBW3QWWviHKVoZ4mR2w7WN?=
 =?us-ascii?Q?MYmLb1R0Sqp27BNvwbFIVBjaeANLQcLDp/3veOkpyVLMidfWBcxPPKsavvCZ?=
 =?us-ascii?Q?pu3K1tsnjMgjz9fZN50rfRYWe2XiwfMB1pvFvliDZpiZJvzXUKpkfrIBBbpN?=
 =?us-ascii?Q?GnQNdaejRe7D4rA2eBI+uQkyhEUB1kQ9pQFVlfW33k7yhfipDwj2KS76BmbH?=
 =?us-ascii?Q?PGhjVNo6LiFnsLOEgjylXLkII6ejGlDPhvf9u1Wz2OPOGcryFUTU3XMUQhmy?=
 =?us-ascii?Q?c1+Wh6UZCJ5hYmubHZCuto3vvGFYkalNRBS0sxu+rOBGD69tjagtq8kzJ8qQ?=
 =?us-ascii?Q?TsLoZKfF1AGXg680LSakw7npyWSZJyYrHr3MmpHBYAvmcWPvtgrxSDNpTlpi?=
 =?us-ascii?Q?E8Xwi7Bp3MrMzNoa7CEtWM4X/02CKEVyqlncyK72wMfrlTFqe2xpZs+rkniw?=
 =?us-ascii?Q?8uJh1zhCDVWZtWPmJgmjGJm/TxkG3uDtT0YXRI+iXSpctzgZKXU9hH+EmNB9?=
 =?us-ascii?Q?+Z6iJ9XexdPRWS/OeE6RBalHNHxP8rJRzWKK4VhWxTkcKxdBkdH/xJn8//e2?=
 =?us-ascii?Q?jKjYPi2Yj7fouLgzINkrqUIoqifM/e4chl2TDJ6LKplKXZqRol129Oruuyox?=
 =?us-ascii?Q?NF7oqhF9UM++68GfUz6dk37PG7yB41Tkgml1Rx3jwS9/D0GteUKOVpG00kjR?=
X-MS-Exchange-AntiSpam-MessageData-1: OgsCfxv8ReHQkhZOVCbTrQkhT+SEe6QIOwc=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22296467-e9bd-48bd-1532-08df4c8cedad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:47:07.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t1NIqK0Z2UciUxa+eKBXl1vgdbraAxO+M8lsOWkinUgsgRqJD7GoH9hGu26AG4WjNyOZa6WuvkegArexaCcpgb8Y/9Te36Zf8Mu8H9DkNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9260

Add tracepoints for a task leaving the in-band and the out-of-band stage,
for use by the Dovetail RV monitors.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/dovetail.h        |  6 ++++++
 include/trace/events/dovetail.h | 23 +++++++++++++++++++++++
 kernel/dovetail.c               |  8 ++++++++
 kernel/sched/core.c             |  3 +++
 4 files changed, 40 insertions(+)
 create mode 100644 include/trace/events/dovetail.h

diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index b41ea0f8fc4e..3c079e5bf373 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -18,6 +18,7 @@ struct files_struct;
 #include <linux/mm.h>
 #include <linux/thread_info.h>
 #include <linux/irqstage.h>
+#include <linux/tracepoint-defs.h>
 #include <uapi/asm-generic/dovetail.h>
 #include <asm/dovetail.h>
 
@@ -163,8 +164,13 @@ void dovetail_stop_altsched(void);
 
 __must_check int dovetail_leave_inband(void);
 
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
index da4016697b67..b2ed57829a64 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -12,6 +12,14 @@
 #include <asm/syscall.h>
 #include <uapi/asm-generic/dovetail.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/dovetail.h>
+
+void __trace_dovetail_leave_oob(void)
+{
+	trace_dovetail_leave_oob_tp(current);
+}
+
 static bool dovetail_enabled;
 
 void __weak arch_inband_task_init(struct task_struct *p)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3ec77a682c4a..aa742a4a9464 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -88,6 +88,8 @@
 #include <trace/events/ipi.h>
 #undef CREATE_TRACE_POINTS
 
+#include <trace/events/dovetail.h>
+
 #include "sched.h"
 #include "stats.h"
 
@@ -10689,6 +10691,7 @@ int dovetail_leave_inband(void)
 	 */
 	if (likely(__schedule(SM_NONE))) {
 		arch_dovetail_switch_finish(false);
+		trace_dovetail_leave_inband_tp(p);
 		return 0;
 	}
 
-- 
2.53.0

