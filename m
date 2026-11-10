Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334128;
	b=qIzrpjABNRjI51RRFz++W+q/Os4ohLIQ7f6OFkQE4tfoss9clM/IGgUj7HV6ZQefx5OV
	 e9jxluyz8QHBT3IJTcneK8XQlvSTy0EEk+mWqb8d29wTTN+Fx0DSbD+j5kIME6900y15j
	 wLQpK/GyB7LgQRSvzVQCZYDOZEtkaanmjqLbxn7OBKgBnCuRZAMM+poUsj4ntz7La0GtI
	 Rf6YC/X4KD9L13fgy3LpAN7VdxGnaOyHH3hqNrJKDTN1DYDsIMHeNKsqtGsh3DoXovPZe
	 QsCHYqroLDQCH+jjbCO3eRKHvqf4vDJPHRUqWSFIYlgqD5KqhJgF5aYx1UESvnVNjyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334128;
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
	bh=d6P/AYj8t3H8oFKLfVw8MqrAoe0eMYom4pmxD4QZ0v8=;
	b=a04QLT8eoOCh0kaQ8yppStOHOP7mIWsY6FS35Ibi5CU5nFOelXrR8mish6MnSKjQct/+
	 LLbI+P06ZYOTFEumXC8HTN1YNPwyYUiKV/yjNmggOyzs2/Ga15yPOXV+rFYhkYKfDLF2U
	 b79qfTfTBIIMAuODVctRIofGgSsHR5zkE+l8n55+cjw9HpwL/DP3NcXO2SMAMMDV9hBVM
	 pJaGy5iCBn2XjlEv/JbWcbpABDua7C4bGsECLc4ShigiG7FUTw9tm0EC69qF75zkV5Hx5
	 sPIx/5JmNAe4safZIX3jZS1DQLUz4vmJbzqWFsHo8PXx2Ig1sdjHdzcLIIlMjupk4QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Ujw86mky;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606E606A325
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 18:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7606E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Ujw86mky
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ3IdCXcqvfajhQZp7O4GNJPjwEue+SIAGQ8DdC9no6177MWWPQSOlxQH6UQ/wVbQ1Pgo+mtH7yLkeJnLJU2Xuv/GbWkTXZBUvpsIABNU3dXnxYdhp0Y64Dedulo7dvHYjb7GsatgVz5Hiyqp/DxxG3vnHk128M/29l4j32uvHRUTGwQuG+QJeIpisS5mU981Vi5t/mEcyEKA9bIT4gqJryhNatsadt/rY4kkpcSnuhgwniS9vF2DVJK/EASehs65zLCEJr0RxEY21O6wqTpkuWMiHXpgaLwsGollxWjKyx0lPP663IgFVkYCvEXNR9DHOwyrxsSrV6OM+O68aEOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6P/AYj8t3H8oFKLfVw8MqrAoe0eMYom4pmxD4QZ0v8=;
 b=kLKGs7Ga+6ds+7Hz5xlD8rz4EE+OUyu+rPcJmPZZbVP2QhoTwaWZ3wnaxNGID/5MYvPo5kfC5dhwdwbFvam80z1U4rGLZhHyzeR2B7ScaXdNQFUJog5m82Ivnl4SpE6nOo/mRv1tQKuEZxjtg49X2PbEmvM8MIXPpgpPsABRb6zxyGxglrm0Ht2S/A/mCsgRaVrZMe9U4Lt3hu7pi4JaKJJNlLEFfKkOThpXDd3VM3pDmAXd8qIQnfPrs5crbb7CjF4G2h4q3DGCAgFH/z6NnEjTgexicLkGfI5cSXaxZt3QesqHXJbvYpbaBzo3Cquf/KSIPWbtMqadYQ+fedN0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6P/AYj8t3H8oFKLfVw8MqrAoe0eMYom4pmxD4QZ0v8=;
 b=Ujw86mkynxr7KioKHm505ZgRnnHiGpAF4XJ3cQ3vqcZw+CPPb0YgPn6lWf6iYo0j9rnHXtCFxi3frRUEy1eTczpjg0w5v28IriN4HfFYR7xgtXoub8NYv1oJsamh72KHNWsWzj1bE6lmXBIV0KC+40zMRc6KCelWsJuP8+3E3dxoxyvRrS67fhKu8XrrK3fwCHXQj78dnYZd9o43sVosrapbSCuP2LmIdXh+RP5ccHBKW6PaZQ1Uj8dbxLeCRv24ASxzSjwJWa1Drr2nX/U/9kY6xWuYRphf55dk3lZ+E2wDxqWFYpTTOf+H/NJK7JBhe2fjdhx3UkOVuovKF/fotw==
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
Subject: [RFC PATCH dovetail 7/7] rv: add oob_signal monitor
Date: Tue, 10 Nov 2026 19:08:47 +0100
Message-ID: <20261110180847.633167-8-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4bd3cd0e-a196-47e0-7ed2-08df3f55a786
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|261009223027099003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261022075727099003|261021123027099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zBYQLH9C4gGonGGw+uxwro91NDTE3OEFaKUEos3IdBNQ96Y5c1QUtv1wE0vpV3g9QPXbOXsvA0aQ+QTwGM/RA4iJQ6/ywE6Q/kNmpsFtTYUmiUj9xfHvK0/Ubzc/+f1sM2PtdwAbPeDlVH+qZSYUOKce4RagYhQTFZSrBvJczabQ/BP5ewVIbZWly7w+q5+oiDqKTD4K18Zzr9PkZfQknDugrqgfc2bU09pS3RacQVqLpo1ohlFXHRexOz4oAENB4Yl0yG+RkbGkzBViBFhVWgG+QlGsv320lyil4cOjBiyAmxS/TbGwQa9LXMi89Wvf7K2QtGX1FwCmuk16etfVGYXRRYUrC2FGlV7NKf7aTg58vnpf+GHnh71tXWEmMdrjMnuYTmMr3CpMNRKshHWEJFFDTdFpM6W7HTxCcyZs++NNwtvvKftTAFtHoJkx1YeU70ZEN/C8dLK5ltIq8T7QvfUIk9LSLwC7N0qWB/Sm6Nsge9BCThJ8y78SXfZU9WvEeQzo2CctEkFtw0ekLKYoV25fSIw0JBJhhObqXr2Kfl/0Krlji4nfeXikUvJC/qc3vAkFweL/bqJZj4PHekjyAmKlqGaVzZ6ANGHn2sBiZETD7v7X1QPynH5ing4rR4x+KXV4k9nloy/2kzeDMuKgdNReVUm8V+/WiRKfzkqHqPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003)(261021123027099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FSssjvG5THBX9bRxLhHXrjUc09MhMGI5HEHaojuRPRfdODRTyLLBPp4D47BU?=
 =?us-ascii?Q?IiriT8H8faBu6KxzNBH3HEHzWrx05m1sIBa31ZEH3JRqYLsLfmHII0dR0toQ?=
 =?us-ascii?Q?b+vkbLtA61wIaIEWxuMSHmKPkclxX2Hyj9U284q0GHQZaG9lGXZH+n+e/M3W?=
 =?us-ascii?Q?2iNacQfomNy6+WiRRr0Qx7VCtIrPZZ5cB6CCW0MhN8gPmnMiz1SWpie3aHzX?=
 =?us-ascii?Q?PH0i+dxdvs6RnCtpu0LG0GgvDeqXkKDghB10CBJRHsWHI0/B+IB6BDvoeI6y?=
 =?us-ascii?Q?iE1Ftl7jzShZkyDYaYUdZjMg6f1kMXWkGt4YAZWz2i5kXzsFPQeDQeb9s91a?=
 =?us-ascii?Q?lNn90spIfQWDkYPIvK0c3/HyI+wZ3Kxa3ibYPowqoyBaT+884TvyaDoTHNfS?=
 =?us-ascii?Q?ZG6ILAkNVUl3IzgUvxJZ8jcEzDp6s2LXzWqnwC3Ix3k4rxWZ3fTc00LbTst4?=
 =?us-ascii?Q?jDYwkENV/zndFhPpjsEYRFS3h8kd59rRMKBZrqG3JDVg4Xts5SOuA7k0uYjz?=
 =?us-ascii?Q?lVUWw1xBjvskTAGShhfNtzwIYPYodKPGIBxI99fmxO7RHI/LvIkILRzk4llE?=
 =?us-ascii?Q?QjMwF3QkNMEsKCr77hr5A+wNu6VLJmOGtvDYtuBdzxTNUcvZKpqs+NHAd6av?=
 =?us-ascii?Q?8WhWBlTtuaBN+hANcscUNp685EHztZlP8lhMNxLWhfVFs5nUD4Mvg4T59QFu?=
 =?us-ascii?Q?Iqzsd3wPsrBlYss2RLt/3OW+hoqLL1q07UZAeZjluLUDQiR5BU20DGvZ8szc?=
 =?us-ascii?Q?Uxawbt2jb23p+H4oq73vEXhhWZM2ttkONuBTIK+lNfTtflL7QZyqucya0TwJ?=
 =?us-ascii?Q?3db9dKY788e7ZtUBQRM3dAmtSyIHzWmPQzF4GO8FpmyIEwe2htd+lwxejhgJ?=
 =?us-ascii?Q?LsyfPmjdojqk8LTiKG/xLuY/d6sVY9qGQbtUvmYl+LAnyrBZTGciyTFp5NKE?=
 =?us-ascii?Q?+ti4r70iMeGyDAb23X1XIpPiX6ndI8RGOrQdr0R/TggL0ZHI2G4fom6gstqU?=
 =?us-ascii?Q?ofo7kn+6tS6EzoTLoKUiMOzRvKAGNqBZ8Xrd+h6lKyIDfzsObMRPVN5fifCR?=
 =?us-ascii?Q?iIK4WUIsvgUR3h4vx9Z4PykA9Fg8sxQr+1ojElVIl6cL6TVg1nR3Id/LLn3w?=
 =?us-ascii?Q?+FO+fbjGqhl2Vl5NoNE1N/rkW92deng8oiaeo5FavndMSeuTQ6P/65bLKz2Y?=
 =?us-ascii?Q?/2PGSuq0DAILXXwIa628mFF2FUB9ECLwxWwsfEm7bBQcIC57ZCn1dmMSmmge?=
 =?us-ascii?Q?4p/Jk/g1faVIrDZ4YWUSvFisM30LLF5Ry/ljqj8ay3l0IANhMsgd+j+q2iUF?=
 =?us-ascii?Q?DURDP16w8r7eIUtTpiRW4qNG0Vvuvp74xWqVzLnhAWWCMz6yPW9HMe2mWUag?=
 =?us-ascii?Q?wWBI8oYBc+2y5WfMsV0aSXSJ+qG6KqwW6F8rKp9Q33YX2u8EW9/Derr2VrbZ?=
 =?us-ascii?Q?anx84h5Oibb0/ivpkDTrCCMsOrGBh+D/6YduMSUj4yNPzSuDEVHwNv4ZyzFY?=
 =?us-ascii?Q?LwD4Mo05nSTBKbxtCH3SkVRBi3Ib00glvT9lQFIzTiTFdYLqMOq8QbS1/Yis?=
 =?us-ascii?Q?QOtUwq9RfHsHQE0RwEGme2MMyUH/FOKdQQfBlYnfKB+tx+1sR7+xwt5a6U2E?=
 =?us-ascii?Q?Al2s05Z5Y7Sq4jYS16ffU0sBZNo2V609PhBvMtf6O5sItsRWWxKzPLTgFJ46?=
 =?us-ascii?Q?SDHNT48rk2MGbL7FT1G0aHXKeZSZVsUXuBIZyWuN3/pToBOZuPKIguxJ9/ZU?=
 =?us-ascii?Q?yCnRsuhHNKDouBPKFswW7UtqdMU0kwg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd3cd0e-a196-47e0-7ed2-08df3f55a786
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:08:42.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2fH6lWsssMj54BHszdnM7cd5xltKe0SF4kXhw+v6RoGUbimUaaeWcIU/B01ASnZxFpXXtyj1jZlEf4SBtpdRzPnJSoF+WRBVsiRf7/xO0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992240

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

