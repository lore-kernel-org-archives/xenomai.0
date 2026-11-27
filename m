Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787236;
	b=3nGn7TXUTTDnPmAhWxYE6lSwoJHsIsmh1yrUOt3fuBIGukrOysQe5LgexiLJFyA5Topn
	 dqbN7Sl5L7f5Fmm27gXmPKthBeg/J0gzN4ZlWwNRWYcc5FEJvTV6i4GgPdd7tc8bz6SIm
	 FD2+MvBTEsAULM9wJhgrRz8oU8/6P+dPf/o0F+oWCHEAFctHzoQI/GNVAwGTF1xDsZrmN
	 BZ7wZkogHkykuKv9sHkrgAnZojxbRmIhI2o7A0DT3lel54zfLlFJD2wMA8PIE9Xo1lNT3
	 hj2g8dcZ+Tg3ifraFa7x3iQ9MUkBfMt+gbAYLCGOeTr9piqWrJzd0E3qs8ho4F87GLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787236;
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
	bh=d6P/AYj8t3H8oFKLfVw8MqrAoe0eMYom4pmxD4QZ0v8=;
	b=fKoiE3H0Va01jjcpiGAGG3kHySMS1KUruO8whGqHXwqtZfWf00xx1Chf3uhsOGKnPTCu
	 4tIUF8lW8as9SgV44eBtmbRT/hKop9hSwj39tgtV9X3lv2QurIclp3pwETfE4c9H9dsya
	 YA1ifhgzLSR2UdiqTE1hGM9ScpT3GNg76PLUyyS7bt9BNM8mgWrrVBYvSjdIdeCjM5xxU
	 HKnqDy0uIB7DLj6MQIvOR2V4dtbxRU2BOyiYYeW0R1qk4+tclQNufGfFTYIeC4jE8OlbX
	 QtaaCBQLUItoplYZt7sdM/0v3i2xbI4VPnle9kxGKmsbX51HTfxucVQIHWMc5Sb6oow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="KR/Do0HO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F3606A327
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 13:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C8F3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=KR/Do0HO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmMyfhSZoAwc9aCG4w1wXYAtEcVKk9oA4A93uTmPTU5/xjP6qVc9l+sIjg530M/QoN+hYYVphWLjL2cPZbfv6SoFixFpq/Kjwqpv35Jw0mmgsDDXfAnbuSa0W524yLwiVirhfYV0/Fy6ycM6HR8jaMH74huAAXXsy0P5aq0AAqTx/jtRk7IaTd/h/zebWDLOx+kC8Ev1tgUptQ5WC02sCO27hKJmw/32N1gVMrwaAyAcIdSADOL/+wZtqPGoFEeDiuksfbUR/o/+8ETFUjhJSUe427uS9LLTXfdmrNb1fLybppT1FKJYD8pdqnfcyczIq5une5d2uAseAovgOwtziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6P/AYj8t3H8oFKLfVw8MqrAoe0eMYom4pmxD4QZ0v8=;
 b=dqkU+Y2eaZrnoLleMdeVXvf0E3Ow/WcRoFR60MATdtzuPekIzhyEyWgQtRW3N54R7Ms1rmu/YpoeEyV1+J4Nf7jBH/Z1xCOISujmm24HS+xKEICJ00oGXgl6LSdLjkw27YX03sDk3sYfHdzOyfuMUNIeLvZuWIPegthmNqnquaDfs8Prk7gD2mGCSqUYvzVBJvH+qm4gHZBBcDfh3kPzZhdjh0UxlnTmCK1OnzZDKBfCxeLKdSKMgwhMkcpestAUQ4ZWxyFpMjj+O5X6yIiWykH8r3jxvf3yBBgJ7F2vHFtD7yaV9l3VCbSlIR1J8DwMnm+cZrL01GrF4cXmU+dDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6P/AYj8t3H8oFKLfVw8MqrAoe0eMYom4pmxD4QZ0v8=;
 b=KR/Do0HOx69LzTUC5B+Sk4QxA7XtkpIt3Ohk2/ednAbHF5u+ybWi4xY+lTWgpdHMlpbwLiPDtcgGxdnOZC18c1iZJCSu6spCf7WbRpGVCDX8Ezc5cSqigyTHf6Dzy33+fU2aFj+stxP9s1esoIVShToOmO8LrK+uhgbF3cfCS1YSZTH93SnkS4jTFDTbdoM/sEjPrt+e13tq7HPwCWaeyGAhS8+UonapZE+/6mg2DijkiiqiNa2fFY6AYXCEZ9M7anUSRQY1umKvrcFxUVDok3HBIGVyWNjzCp2mUID7cHZgEmmy3bSWPD7bOPPOzTj2Hn/w30XBNhPTAZe6d1PVDg==
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
Subject: [RFC PATCH dovetail v2 7/7] rv: add oob_signal monitor
Date: Fri, 27 Nov 2026 14:47:25 +0100
Message-ID: <119488604b5ca8f726b485d18939279f3ca53006.1795786695.git.tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34d028bb-21ee-47b7-fe75-08df4c8ceee5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|366016|22082099003|6133799003|55112099003|18002099003|261021123027099003|56012099006|261021121427099003|261022105027099003|11063799006|261026121527099003|261028144727099003|261022075727099003|261026140227099003|261009223027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	zuIO2/RnvW6H16FvEJR/WPLo6gn18Hq9xVoMCk3U/PzZF7Wkuv33wkmlNGUKC+h8FOTetnRqDzy5yvVoEcXgQvr3gceTG/eD1ycgoo1zkdCywRUJFJJe648uaJ3L4Cgwa7LByXnh0dw3my3aR3zLBbTH6ZbNeifq4mybTzZzxwF65j2o/HkwC9eRLIpuO1UTtu9UEjzuxZ4lC2C0Ck/xY9LkSpdatPQf7F+eqfWPMR3OtiNLKRkb4YZNBlOD7CQSA8yz/3Sr91nXGB8Af+zjrIiLnzj+JNnpHLTlc1a9SxOCFtIyuzC09g2Ji5frQ1yGrgcncT3NBvLCn2VINMozOWOx8K19sW9jJpovGs2b/hYyqcLKfPE87BpFKy0Xoty8Y4LoTyZ5XzVWEHvM+opZx2Ye2dxFrq6Q+9vabK06gu7uxsV69ByNyT07wuxEkuHnZqZj1MXcJSN2JodW/rjeBeRRzoTtC4S0dLTGpOTyYFJXkJxYc9Lq9j1vAFWTakhjfyGjRaHd+i+rk3nqW+9+0MN606r6qROSeHdJrt7jit76CjwZWbk8eVb3sORzTUseeJx/EYCTTeyI/bPuDdpMnfkJJ7hjrw5IDKvDtRGBDDcmHMHVirrmapxMfzyO79p64bDBVLAqSVExoVcKzQYNroHdSQqN2wrHVQ7KtFv/9rs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(22082099003)(6133799003)(55112099003)(18002099003)(261021123027099003)(56012099006)(261021121427099003)(261022105027099003)(11063799006)(261026121527099003)(261028144727099003)(261022075727099003)(261026140227099003)(261009223027099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zCn/EEBaQ7roZ5KWzAiVDvBxfDNulX9+miUd90/k/NDvfFj4xAy1iJ2fGKEt?=
 =?us-ascii?Q?ZowS4XhwSxAuv7Fpk4lVgail4bHuoKtAIpk5p1+7jhOmklfyUdKlLzI75AmX?=
 =?us-ascii?Q?22HHHjy20mpNEfpcL68Ww6+vDaf2gZ04+muQA3nXcH5mt7g2C6q7vIRHwn0y?=
 =?us-ascii?Q?pRO4HmbznDKP+qW/RDDWgd7IlmfN2rrW97ZOGnpra2fsZ3EljrhfW54fHps/?=
 =?us-ascii?Q?IMzayNwIb3Zqb+JMzYNk/R+W1zuqZSePX3HqqV7/znvbvkPSe2hnL09EiiAy?=
 =?us-ascii?Q?OB/x++4J8sT22G7mJlGWwMK+75UDGSH9a4fuylph8294DQ7vD4sRuIUUuMsW?=
 =?us-ascii?Q?OBSXDWcyuSM4uRK8neCCHt6y8A95lAZBwZhAWkSdtxcC9ZYafTl83GrCW5k+?=
 =?us-ascii?Q?iGF85Y6BuVivdNobOKUcMc2mEQAkZLb2On8zqCoFKixGu6w/ndYJVdn4YaEk?=
 =?us-ascii?Q?pMYq1vfqwKrSHT0H88cFuI5uihmabNyROGvmkiK4+u9MYzDhe7FEAPylfPkj?=
 =?us-ascii?Q?HqztIi0xo/ki8mqffLFEyHgKYzcNLfI2R54xG92efrf3Ai5K4wowY5tCdJ1T?=
 =?us-ascii?Q?SWwwbQClJW2XKQZ0YDmvI3czIKeZZp/n3D14xWRm6mOsf0Cn+De70/CisWuY?=
 =?us-ascii?Q?o64MtAqOPYPLhxQSI+0kI/CFS8Vrhd6deq0uHp/L3af+foc5ya2Cg/VMwIft?=
 =?us-ascii?Q?S/EST12BsyoQybSrquqdEiZ1LMQZyRx+x1Ztrlc5khyxQAKAnmAh0ZQ7zI0/?=
 =?us-ascii?Q?foniMjUSiAJ5xoMHe2mVtSeve+t/rqScMjr23wsf4DnrBH7Yzpmeh6yJkoHa?=
 =?us-ascii?Q?o6XJ0D365RPGXzjrC59+Adw7WqusbHItD79xbJL1YCRUcNv8eqIHJ7iqW7ib?=
 =?us-ascii?Q?4Jismxh6oc1hWujBR8QJn3FI7neKZkOwju5NM71CDn7ZAmEyE9PtsDXez6Fg?=
 =?us-ascii?Q?rMZHCYLk1VQDoaAKL3FCZ8MfAOVyfu/yiqiI+NjE5FfArr6g9OJOkKLXgGfv?=
 =?us-ascii?Q?NuV4/uUlKS7KdoR1I4ugo9mmMu2rzxAC8NS+7BFGEPQsnC0pbYYdYUJJf2v3?=
 =?us-ascii?Q?7/wfFyoWDcXGfqXKtVFFsgNEcnRZrwzEhySfC9EVNABPMeGJgEI6nPKLD+US?=
 =?us-ascii?Q?xAgFscnaRrKsEmR9mCVyd7YhIDV2xqcj7V5TipSd1FEsQFTF7c9bGsWxZbIg?=
 =?us-ascii?Q?MyUGOaJJi7s9FTB5H6wkAlsR1+m4RiFDdz8tTnU6NGdPM3kWQZ+6a9siA62Q?=
 =?us-ascii?Q?iqeMsNtz3K4XsQ1coXa+B8QFa2VoRSyuFXUlgr21g2UJIT14J0soZ9qwPpP4?=
 =?us-ascii?Q?0xYQvXAczwbZDFltXLHZ2knkadXbSFTX31uU3Kh83zPyihRf8Rsj5WftI+Ks?=
 =?us-ascii?Q?5vUt6oH/nnZTs75yhzXzAxNoL+eFcsyIDbE2ylaPha+d8a9Kwz0Q+SraWrBC?=
 =?us-ascii?Q?NtsWHfbr+O6F7Ucj9cRINhwtKNXgugElJAqgPPEkujNXoIvjlK9MzknbIU4u?=
 =?us-ascii?Q?ZQhd4K1QrE43q5TU7U1hLOvWBY00rZPNmScufprehTH5yMvSDkVAMVPwEFZ/?=
 =?us-ascii?Q?rFcm6EaAP8XFzuY+pzLgjLc60gZ488qMAzYa+pL3vbU1aoBAtG29H9dQLW0j?=
 =?us-ascii?Q?mC1bmVuXZCIdCPTZRqPbqDq/3gxnW3/yD1jZkxTH4ZF3R7E2BjkPrcv/0ZqK?=
 =?us-ascii?Q?3zJp9fLCACsSm46dilDdv3lhBrdGjESRtIT482yw673w5iA0b7gdrKJFBBMB?=
 =?us-ascii?Q?FowRB2Vtq8m9cYrgpsZZLbhkhfaGOHVRtLsPerCeHFG5XjG2mnuRpgrJI/ct?=
X-MS-Exchange-AntiSpam-MessageData-1: 8jJvZvTE8eF6EL0S8fenm1s5wDRuYe8X0CA=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d028bb-21ee-47b7-fe75-08df4c8ceee5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:47:09.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kUKQQSsixKrT2uJqfJ1BoWEM9/0DY2dxfsnmF66gCsBYN2Xe/JO0A89h+rzniCK0qb+EjomxuQDnSinZZ46coOIRDV2MipINqPk8derAs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9260

Signals are delivered in-band only, so the companion core has to kick a
task receiving a signal out-of-band, usually with a mayday.

Add a monitor checking that such a task does not return to user mode
out-of-band without a mayday pending.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 Documentation/trace/rv/monitor_dovetail.rst   |  34 ++++++
 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/oob_signal/Kconfig   |  16 +++
 .../trace/rv/monitors/oob_signal/oob_signal.c | 114 ++++++++++++++++++
 .../trace/rv/monitors/oob_signal/oob_signal.h |  74 ++++++++++++
 .../rv/monitors/oob_signal/oob_signal_trace.h |  15 +++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/oob_signal.dot      |  23 ++++
 9 files changed, 279 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/oob_signal/Kconfig
 create mode 100644 kernel/trace/rv/monitors/oob_signal/oob_signal.c
 create mode 100644 kernel/trace/rv/monitors/oob_signal/oob_signal.h
 create mode 100644 kernel/trace/rv/monitors/oob_signal/oob_signal_trace.h
 create mode 100644 tools/verification/models/oob_signal.dot

diff --git a/Documentation/trace/rv/monitor_dovetail.rst b/Documentation/trace/rv/monitor_dovetail.rst
index e660b5c9a1ea..de9f6f05db24 100644
--- a/Documentation/trace/rv/monitor_dovetail.rst
+++ b/Documentation/trace/rv/monitor_dovetail.rst
@@ -17,6 +17,10 @@ are per-task monitors fed by Dovetail and generic tracepoints only, meant for
 validation: while enabled, they add work to out-of-band hot paths.
 ``CONFIG_RV_DOVETAIL`` enables them with RV and the printk reactor.
 
+Each monitor takes one of ``CONFIG_RV_PER_TASK_MONITORS`` slots while
+enabled, so the container needs at least three, the default with
+``CONFIG_RV_DOVETAIL``.
+
 The Dovetail tracepoints fire in the context given here, so their probes must
 be safe there:
 
@@ -29,6 +33,11 @@ dovetail_leave_inband_tp    oob     after a successful switch; oob stage
 dovetail_leave_oob_tp       oob     before the switch to in-band, in the core
 dovetail_trap_notify_tp     oob     hard IRQs off, before the core is notified
 dovetail_trap_unwind_tp     either  hard IRQs off, before the core is notified
+dovetail_oob_return_tp      oob     on return to user mode from an interrupt
+                                    or an oob syscall; hard IRQs on at the oob
+                                    syscall return
+dovetail_signal_notify_tp   inband  after the core handled the notification,
+                                    siglock held
 ==========================  ======  ============================================
 
 Monitor offstage
@@ -73,6 +82,30 @@ out-of-band again. Traps taken in NMI context are ignored. The model uses no
 clock, so the hybrid automaton core arms no timer and is safe on the
 out-of-band stage.
 
+Monitor oob_signal
+++++++++++++++++++
+
+Signals are delivered in-band, so the companion core has to kick a task
+signaled out-of-band, with a mayday if the task may return to user mode
+there. Once the core handled the notification, the task must not return to
+user mode out-of-band without a mayday pending. A task reaching the
+out-of-band stage with a signal pending is held to the same rule::
+
+    state     leave_   leave_  oob_    oob_return_  signal
+              inband   oob     return  mayday
+    inband    oob      -       -       -            inband
+    oob       -        inband  oob     oob          signaled
+    signaled  -        inband  -       signaled     signaled
+
+The monitor takes no lock. The core sets ``TIF_MAYDAY`` in its
+``INBAND_TASK_SIGNAL`` handler, before the notification moves the task to
+signaled, and a return reads ``TIF_MAYDAY`` only once it sees signaled. As the
+notifier holds ``siglock``, the task cannot consume the signal and come back
+out-of-band before the notification is seen. A return from a trap the core
+does not demote, or after a RETUSER switch, is not seen. The monitor is not
+available on 32-bit arm, whose out-of-band syscall fast path is not
+instrumented.
+
 Usage
 -----
 
@@ -85,6 +118,7 @@ Usage
   dovetail
   dovetail:offstage
   dovetail:oob_trap
+  dovetail:oob_signal
 
 Violations are reported by the selected reactor and as ``error_*`` events in
 ``events/rv``. The models are in ``tools/verification/models/``.
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index d7207d7e9892..cf1c81e3df3f 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -87,6 +87,7 @@ source "kernel/trace/rv/monitors/nomiss/Kconfig"
 source "kernel/trace/rv/monitors/dovetail/Kconfig"
 source "kernel/trace/rv/monitors/offstage/Kconfig"
 source "kernel/trace/rv/monitors/oob_trap/Kconfig"
+source "kernel/trace/rv/monitors/oob_signal/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index c5848be60f5b..46bc8bf33e33 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_DOVETAIL) += monitors/dovetail/dovetail.o
 obj-$(CONFIG_RV_MON_OFFSTAGE) += monitors/offstage/offstage.o
 obj-$(CONFIG_RV_MON_OOB_TRAP) += monitors/oob_trap/oob_trap.o
+obj-$(CONFIG_RV_MON_OOB_SIGNAL) += monitors/oob_signal/oob_signal.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/oob_signal/Kconfig b/kernel/trace/rv/monitors/oob_signal/Kconfig
new file mode 100644
index 000000000000..82d3ca1dbed7
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_signal/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_OOB_SIGNAL
+	depends on RV
+	depends on RV_MON_DOVETAIL
+	depends on !ARM
+	default y
+	select DA_MON_EVENTS_ID
+	bool "oob_signal monitor"
+	help
+	  Per-task monitor checking that a dovetailed task which receives a
+	  signal while out-of-band does not return to user mode out-of-band
+	  without a mayday pending, since signals are delivered in-band only.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_dovetail.rst
diff --git a/kernel/trace/rv/monitors/oob_signal/oob_signal.c b/kernel/trace/rv/monitors/oob_signal/oob_signal.c
new file mode 100644
index 000000000000..44c3d53d9366
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_signal/oob_signal.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * oob_signal: a signaled task does not return to user mode out-of-band.
+ *
+ * Copyright (C) 2026 Siemens AG
+ * Author: Tobias Schaffner <tobias.schaffner@siemens.com>
+ */
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <linux/dovetail.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "oob_signal"
+
+#include <trace/events/dovetail.h>
+#include <rv_trace.h>
+#include <monitors/dovetail/dovetail.h>
+
+#define RV_MON_TYPE RV_MON_PER_TASK
+#include "oob_signal.h"
+#include <rv/da_monitor.h>
+
+/*
+ * No locking: the core sets TIF_MAYDAY before the notification moves the task
+ * to signaled, and a return reads TIF_MAYDAY only after seeing signaled.
+ */
+static void handle_leave_inband(void *data, struct task_struct *p)
+{
+	da_handle_start_run_event(p, leave_inband_oob_signal);
+	/* A signal notified before the switch is seen here, a later one finds oob. */
+	if (task_sigpending(p))
+		da_handle_event(p, signal_oob_signal);
+}
+
+static void handle_leave_oob(void *data, struct task_struct *p)
+{
+	da_handle_event(p, leave_oob_oob_signal);
+}
+
+static void handle_oob_return(void *data, struct task_struct *p)
+{
+	struct da_monitor *da_mon = da_get_monitor(p);
+
+	if (!da_monitoring(da_mon))
+		return;
+	/* Pairs with the cmpxchg of the notification moving to signaled. */
+	if (smp_load_acquire(&da_mon->curr_state) != signaled_oob_signal)
+		return;
+	da_handle_event(p, test_ti_thread_flag(task_thread_info(p), TIF_MAYDAY) ?
+			oob_return_mayday_oob_signal : oob_return_oob_signal);
+}
+
+static void handle_signal_notify(void *data, struct task_struct *p)
+{
+	da_handle_event(p, signal_oob_signal);
+}
+
+static int enable_oob_signal(void)
+{
+	int retval;
+
+	retval = da_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("oob_signal", dovetail_leave_inband_tp, handle_leave_inband);
+	rv_attach_trace_probe("oob_signal", dovetail_leave_oob_tp, handle_leave_oob);
+	rv_attach_trace_probe("oob_signal", dovetail_oob_return_tp, handle_oob_return);
+	rv_attach_trace_probe("oob_signal", dovetail_signal_notify_tp, handle_signal_notify);
+
+	return 0;
+}
+
+static void disable_oob_signal(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("oob_signal", dovetail_leave_inband_tp, handle_leave_inband);
+	rv_detach_trace_probe("oob_signal", dovetail_leave_oob_tp, handle_leave_oob);
+	rv_detach_trace_probe("oob_signal", dovetail_oob_return_tp, handle_oob_return);
+	rv_detach_trace_probe("oob_signal", dovetail_signal_notify_tp, handle_signal_notify);
+
+	da_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "oob_signal",
+	.description = "a signaled task does not return to user mode out-of-band",
+	.enable = enable_oob_signal,
+	.disable = disable_oob_signal,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_oob_signal(void)
+{
+	return rv_register_monitor(&rv_this, &rv_dovetail);
+}
+
+static void __exit unregister_oob_signal(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_oob_signal);
+module_exit(unregister_oob_signal);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobias Schaffner <tobias.schaffner@siemens.com>");
+MODULE_DESCRIPTION("oob_signal: a signaled task does not return to user mode out-of-band");
diff --git a/kernel/trace/rv/monitors/oob_signal/oob_signal.h b/kernel/trace/rv/monitors/oob_signal/oob_signal.h
new file mode 100644
index 000000000000..655636a0cdef
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_signal/oob_signal.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of oob_signal automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME oob_signal
+
+enum states_oob_signal {
+	inband_oob_signal,
+	oob_oob_signal,
+	signaled_oob_signal,
+	state_max_oob_signal,
+};
+
+#define INVALID_STATE state_max_oob_signal
+
+enum events_oob_signal {
+	leave_inband_oob_signal,
+	leave_oob_oob_signal,
+	oob_return_oob_signal,
+	oob_return_mayday_oob_signal,
+	signal_oob_signal,
+	event_max_oob_signal,
+};
+
+struct automaton_oob_signal {
+	char *state_names[state_max_oob_signal];
+	char *event_names[event_max_oob_signal];
+	unsigned char function[state_max_oob_signal][event_max_oob_signal];
+	unsigned char initial_state;
+	bool final_states[state_max_oob_signal];
+};
+
+static const struct automaton_oob_signal automaton_oob_signal = {
+	.state_names = {
+		"inband",
+		"oob",
+		"signaled",
+	},
+	.event_names = {
+		"leave_inband",
+		"leave_oob",
+		"oob_return",
+		"oob_return_mayday",
+		"signal",
+	},
+	.function = {
+		{
+			oob_oob_signal,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			inband_oob_signal,
+		},
+		{
+			INVALID_STATE,
+			inband_oob_signal,
+			oob_oob_signal,
+			oob_oob_signal,
+			signaled_oob_signal,
+		},
+		{
+			INVALID_STATE,
+			inband_oob_signal,
+			INVALID_STATE,
+			signaled_oob_signal,
+			signaled_oob_signal,
+		},
+	},
+	.initial_state = inband_oob_signal,
+	.final_states = { 1, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/oob_signal/oob_signal_trace.h b/kernel/trace/rv/monitors/oob_signal/oob_signal_trace.h
new file mode 100644
index 000000000000..63842f32effb
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_signal/oob_signal_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_OOB_SIGNAL
+DEFINE_EVENT(event_da_monitor_id, event_oob_signal,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_oob_signal,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+#endif /* CONFIG_RV_MON_OOB_SIGNAL */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index bcd7ee424e89..e590b753beab 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -157,6 +157,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 #include <monitors/nrp/nrp_trace.h>
 #include <monitors/sssw/sssw_trace.h>
 #include <monitors/offstage/offstage_trace.h>
+#include <monitors/oob_signal/oob_signal_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
 
 #ifdef CONFIG_HA_MON_EVENTS_ID
diff --git a/tools/verification/models/oob_signal.dot b/tools/verification/models/oob_signal.dot
new file mode 100644
index 000000000000..1a9e9b5c9e17
--- /dev/null
+++ b/tools/verification/models/oob_signal.dot
@@ -0,0 +1,23 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_inband"};
+	{node [shape = doublecircle] "inband"};
+	{node [shape = circle] "oob"};
+	{node [shape = circle] "signaled"};
+	"__init_inband" -> "inband";
+	"inband" [label = "inband", color = green3];
+	"oob" [label = "oob"];
+	"signaled" [label = "signaled"];
+	"inband" -> "inband" [ label = "signal" ];
+	"inband" -> "oob" [ label = "leave_inband" ];
+	"oob" -> "inband" [ label = "leave_oob" ];
+	"oob" -> "oob" [ label = "oob_return\noob_return_mayday" ];
+	"oob" -> "signaled" [ label = "signal" ];
+	"signaled" -> "inband" [ label = "leave_oob" ];
+	"signaled" -> "signaled" [ label = "signal\noob_return_mayday" ];
+	{ rank = min ;
+		"__init_inband";
+		"inband";
+	}
+}
-- 
2.53.0

