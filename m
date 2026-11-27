Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787237;
	b=CP2dmzIYtHf+ks/fLlMw3byMOsQcX3uTPWxwb4RrCDOOyKE+Te6TmJypgleEstuS6PrA
	 i1Vr41k57y6agB37WkYFCGEtTcJMXnNjyz+NZxzI/m36an2V/S5QcjMlZPlY9N9C3ZMm2
	 0HRZl5KcqJUHRbkY72oFVgty38gc4dFl8OXkP2efSGTN+lQmwCB6d4AWieKDYIJeQuOni
	 dfn83V+FM/9c8nMPwBGMg4Cix0qSiUAVM6aqhGYiLRXt27K6xyJHtpIfZWQaXEqcGuf2k
	 z5sf8vraEp80bNV8R6bvvdjIa/36RYks09ccqjDZxgMsRbW6ULJc8qsGWc2wA1jxSjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787237;
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
	bh=KueDzxLM6T5IaZqV3CVsTh1zYtDL53zCtSo9+5jnSJw=;
	b=IqQV/+0wp5JDDmYixYVNLGP395xiCtjV19Cz6fQD5EnhoL1ks6KjXRHImv8RQD4MsbaP
	 j1RVa1MF1MM/TEAfNUvjb/SygBoMVlR307jikL42c6ifUnpoGYIFxCpX8a2DxbJGLxKbd
	 fwcwbM0W26A0lWgDnIuhejSecSHjXcetKWc9dHgkIMih73V+m87LsNrD+TwHWPTSMIbnQ
	 GIZAcYX/rQByn1YMHo/misco8mfaGBUu9Unjpa6WdZSOa9VDugLGkASXcC/DPl7yqoHjq
	 s8Jpq1NqJd+pr9zLy60LANzY3sxjKWey/eAigPA9r0tlCCxjgOymrbYmkNSnih3oFBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=m+NmseLc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F32606A323
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 13:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F32606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=m+NmseLc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V31jPrkTCVdHWhi42k9zbKOXjEzxppgmqujkIMgeaaid2u8fc8hRk1F+iYCjL8SnaxeUMBjlWbNOVwTV+cUUTHxVRp5RTL1vImPrzWv99qOEDPeLffxy8HU0+y64O4AG+LkDJjekgCh9tjVWmmHX3D5Uhsp5rOf+VdlIEHUdxLHiD2cjdtgJl8VbPRhft60fc79k1wEyxxGA0jBbr0QWNkFYRq58ZDDmUJVSvQxgTHxSe3evGaL1i1WJDn4BQ6W2NWSJFKGUMSfbhBLKgjHn4G6NVh7+7Hv8amkyO46yUgFKDMFOGGvmHg4ZlVinIFtywcT4XQYprqu3c1ob7TLZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KueDzxLM6T5IaZqV3CVsTh1zYtDL53zCtSo9+5jnSJw=;
 b=lOOcWM36O7Xh4yCqYfh4mtJSZwUcqZRVgcSwbceyPkG8tdKa03n4P6Wqch8nTlroQwA2aUuoAXFYYkmtTGL3BnAc7GA9mHJjDN/I+wuMbG0oa0UWNd92hBwwZjui1tm9xHSXHGa2tiu+2BAcpp6EXXFrpsPIU4a/tZrd+fljO5v0vz3TstVI8fWD34CbsylH2YpCnFxYd2Ah2lhjPlS/1fYagDzjrIoo+4zxGIiJ3WxiZyty/O9RXV0LcyAOCxieVgjZvnuFRVsqy2PjQwpKDOGQwu/YNJOilh36utrRwuu/pMEzEtjgiXcTZpWAG97oH4+Fwi+1Oo4h3y4pWrQkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KueDzxLM6T5IaZqV3CVsTh1zYtDL53zCtSo9+5jnSJw=;
 b=m+NmseLcTY31f8w4EyhACSnIopM8oQR8De3LGL0283m9Ot8rPs1TTw6BzbRtIGBpSnFbM6FuOZOSxZhEbBPm/tJRYvSMtEteP/RvoMLgYWyZkzbQUnCEkLY2KBkRXM5uRLzi8OmlCLOolH8NYUuaSzy+4tqY4kbytcIywUa7icBRkvpcl1nricNyNqVgktUI+nOJK815CvnDwvLuV+2gxmMEOMfzXWOTheM3LEaFBK7dhmxi3PJmzQMg4YrKkzc+UUznVPAaWWcBN2N4k4qf2iLzSPFimh9GofjChqOxOxaYpKsomBkU7Fk3jia/fuTmuNrIPGCmtS+JsgIXBBu+9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA3PR10MB9260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Fri, 27 Nov
 2026 13:47:09 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 13:47:09 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail v2 4/7] dovetail: trace out-of-band trap notifications
Date: Fri, 27 Nov 2026 14:47:22 +0100
Message-ID: <a244dc22c16fc275e04e0b41621b173a5c7c1b1e.1795786695.git.tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8faf0211-4d00-41a7-e00d-08df4c8cee26
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|366016|22082099003|55112099003|18002099003|56012099006|261021121427099003|261022105027099003|11063799006|261026121527099003|261028144727099003|261026140227099003|261009223027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	VCGvgIE61fqmQtbLSe7m7UFUl0anJ82wn4+lKzr0psq4ikgynWJwCClgbWXkoMo6cLscZf5LN2t0VKLHjxxGs38hpXL7s9ztOsyfGnrhjxLHhyJFZJRLi7axqd9JMIJ0/Lc8coqXf0xZ8n74Hl5EEzfoqKVLXBI+ajaoo3eDZc8YX7mBvAQwDC+/a93DrofZomjzHX//fQxcq7w2uj1Ce6lMtr7aB2pIAQhr4gU0zCstPvHURqh2d+sLWmejsN1UK/K7FSYJ2yEvpvoofOajCmM93mDoshhveRRWJCJeSAE9fLxWXaBXDRbULyT423F5HdGDCZMGrcP1vVeEar58BbGHr4FsfBtNE3HzpX9wjMm0td5p9GQPSjcIWy23z3e5J213LuOThJEPS3Q//6OwdhVQyRbXfrSK1VVFWsud72Y0QMCZIbz6gfgAVJxiC6E1U7Z9dPY6OCqllhJQnlBvq+PFlCTWRnNVmn8OtiHFtw4Dztxxn0aTmcgKc+poLc7iFMcMIKPoBuh5dbhEc7anAEJ2ewQ4PKComG69EeACAgknv8Jbv4RDwc0sb4Xvp9s4S2NyDRSniXQYCAP0zcwDTN5yE2cPeZyDhT8e/CfaCXs6DG4LCM/go+mv0d6w28i2xbUdHra57IGaP2/rtwmFQn3mq2CIVA4hDfJwPeJ96oc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(22082099003)(55112099003)(18002099003)(56012099006)(261021121427099003)(261022105027099003)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261009223027099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XrsQBhdYUm2631C/ZfOhAGPI45INjFYcKrKIh+5pmadQHGh+SteaE9JIMkV2?=
 =?us-ascii?Q?ZDnpLVMLyhDRlV7tiTKKhCaLPErtJipsu6q9jlDXIoi0LqD4T5ff1ECytayZ?=
 =?us-ascii?Q?mbIlpxIEyiCDPuLjeQfipDDPIRdCKznr+ruOeltbyDMjVLNvt3qElrO/OFwY?=
 =?us-ascii?Q?ScS/yzrr/w4R+awX3jToEpI/8N3u/fubAQF9gYlgdeHKVAE3GaL8ZLyKPiCQ?=
 =?us-ascii?Q?CVGVUSCVjK0buXq7s/Po33X2OoyT3FW14OC9uWDinTPMSWrjzgbvtESAokHO?=
 =?us-ascii?Q?zNM99ouLp46qs4+LWBWTqheJbXHsFyC7FP9bMCRSXtrI5KkoDiuhbvUjrCmK?=
 =?us-ascii?Q?gb78hBfcLfRPZ8Ld3hwprMpda1hnmR7Krd2gJTFCjUzvhljCPpBOE1Ou7jZ9?=
 =?us-ascii?Q?Xpim3vOIGc5212rssdoaX7TFhLiggMCI0LyRkdL+0wq/XcxWQBbUazDadfC5?=
 =?us-ascii?Q?ktio0miX9trS/9sepQBCP96nVKIZUnd5X9APvhqlk1Y+DiXZeP2zxrNhgDp+?=
 =?us-ascii?Q?sZ1X+8MNrHCgzo80MvApSbT9x01/7rUZeI8wiIhslu23BqHI2qfpa9SD3Rs4?=
 =?us-ascii?Q?83HLceFcj6eo1yIkoC+xznyt1fE4g7YR87FpalDFpTOtDMpMLtv+vOzvV5Xt?=
 =?us-ascii?Q?guzmUeApIQEXVXnY+oX9gXbMDbxjeFdU5vDAauXiKoAOhAjB68/km36Ww2v1?=
 =?us-ascii?Q?jZ2RFhZVFDYTVETYeyNVOIOWsBNR64apCtxssV8hWhj//Vi9OJIko3VR5gI2?=
 =?us-ascii?Q?40z0sCEjWo8mAonQCwYkaPSSEiL78K6tOSsiA5amRfYtC/X9LtncwkqBCsPi?=
 =?us-ascii?Q?ZItL8MgKptRCoFGM60a56pLC+o4Xsnt9m338DjSwbBudkmzBDeo2HY/iLMq4?=
 =?us-ascii?Q?djEwYXdDXPyHh9x3th+F+HrUXLC4vGak23OSoOEWKNZs76sxk0xlaK5RkvNf?=
 =?us-ascii?Q?/VMVlqx+LF2zpFnGdrAQFPcPbCBX63FP6G/M9VEMnC9KcAxtlMnZBYOuIgbQ?=
 =?us-ascii?Q?M9NSGLh1PdueOZ42ZcicOevbaldJ2RIDYcP1WyOk0TOIXUpkcJ801ULsoZQ+?=
 =?us-ascii?Q?Vg6GmeQ5vONz4FqoU43b74emgQkQDjXbUkgW6xYvkBGdrCIXuTp9qmYwtmUY?=
 =?us-ascii?Q?nk7wll/iL/Lv/4QA4n8xp0gkAfbv5/Zt1zV7y9bdbouDkPtnTfIqIy+p+Zk8?=
 =?us-ascii?Q?d2p/PrYqW8LFhXz71IVbws0hPGusNBNxToqOhEDj53QnLWjP7jzN3EB5IKLy?=
 =?us-ascii?Q?iSnVMyIQj7Z9QVoPNo/7T2jGJCxGd4u/Vpc8k7JMZwDvoIYwIboEyL+GBDhs?=
 =?us-ascii?Q?faWs8Q5Y7/ld3PrD7gfPmREeUui0tDLpneWyZmv5jMDNCm7N4Jk8jPlXVn+c?=
 =?us-ascii?Q?j6FmRZub2Qz11eo+4mo1K1aivRCXV1OqsiBX67nn7sqZ6qKSZYDi8fORHR7G?=
 =?us-ascii?Q?hnJditVjbIiDS/y8WjotA1h1v4onTYlPt2y6hSbYppufexNJu4Q4qkfIY+/o?=
 =?us-ascii?Q?VG/rpXmScR3zorK3Yhhg5KTrZAyGPlb0YNRme0Tw6LJyi3+hHdTddSxBt8aA?=
 =?us-ascii?Q?GJFCUyt+Ohv1Pcr0NvCR3KVjmH/JWv5v6qOWMvN8Ch3+7IPX03Estg8We1x6?=
 =?us-ascii?Q?ZvMnzmvmK3+BOOTbrc3sqf1DNmc9NjkrNUo4rUuwmDhR9+KDaM3ITmua5oRt?=
 =?us-ascii?Q?vP5UBl+GTa5p3kx7HlOAdzjFm8TsO6NQ4wN3fBKpTYUOtwMOYsB4C0J6kagW?=
 =?us-ascii?Q?4hELJjXBnFymjXe+tnDsAJGAkvWVAcHqgk9xnHX0h+cbu1S+dlcD3USdBGLq?=
X-MS-Exchange-AntiSpam-MessageData-1: Q/yT1IUytFuUp3eqhRBYhb1I44juLX5uBbY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faf0211-4d00-41a7-e00d-08df4c8cee26
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:47:08.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+nQcncx2135SFdLVIa9S4mFo1LneaGj6c9mt0IGcpeRymkYBpoew50UbWV4nUybvlvXmI0agbaSgVgJ+LL7DeiGJbOc7eCZ4TEaK2aQORA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9260

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
index b2ed57829a64..0f7dae3beeda 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -299,6 +299,7 @@ noinstr void __oob_trap_notify(unsigned int exception,
 		set_thread_local_flags(_TLF_OOBTRAP);
 		flags = hard_local_irq_save();
 		instrumentation_begin();
+		trace_dovetail_trap_notify_tp(exception, regs);
 		handle_oob_trap_entry(exception, regs);
 		instrumentation_end();
 		hard_local_irq_restore(flags);
@@ -320,6 +321,7 @@ noinstr void __oob_trap_unwind(unsigned int exception, struct pt_regs *regs)
 	hard_local_irq_disable();
 	clear_thread_local_flags(_TLF_OOBTRAP);
 	instrumentation_begin();
+	trace_dovetail_trap_unwind_tp(exception, regs);
 	handle_oob_trap_exit(exception, regs);
 	instrumentation_end();
 }
-- 
2.53.0

