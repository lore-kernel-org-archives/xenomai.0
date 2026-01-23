Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80B344DBF
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160347; cv=fail; b=IJRtB9JhG2IeIRAJA8EGNI3Ps6oyy0HwS75DPbPnH3XjZl6eVz6KRnP6ttkgAUdmmamjhxvYzXmQD2G1baMOgwnweng3tzOPziocsoLcesqUPEpNDfdOq9Pqkv5A5q6eSrhQiETpMKZ35572HTrMONUumOUmoTUE/h7gsBfJXbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160347; c=relaxed/simple;
	bh=aegaK56kpdyu34eVeOdBm3kNUV5TW5tgOMGERA/TSN4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QeHLtUtxc8NXLUHwRy779JSVMQ4O5tbCUQbVwDTxMNVnjqlpcd/w3vapG0AwQ9oGyirU8drt19cBdKIjCsFsB6itTl8AJcDQulXmkBTDJ3qJqud6ZR9NzgiLBBpphtO4HqlHaeNzxYpn4XAQlMb5TVGQwO9gauK3BsisCGWFRR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WSmzpNPu; arc=fail smtp.client-ip=52.101.84.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WSmzpNPu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8mtqyJbxVwjKYYW2KItH7BWhZ5iKjee5qYzR08vB9ZNQ63gDV0hn1J8BFqkcnq5pDAksRaJGZyw9I4ZBMF7AOS80By3OOKx293u3AnNflU4/OW9XKVqMNtj9mnDGCQQ+nKUwRmXPw5p6sVn5ESKcxrO+4W8kUG3y/LwQWZAfd58MzWSRXQddup4husiLJzDbt5BP6iB2dVeTRWm0wz+dFTzCxvtNQoRh8a5dt+U1Dkwpp5QRoL6h4eyhgrIpU8lTX24omwZCwGCWylBmWTwL1KbZ9MxWV+oIJnKSm9hwyDnFRLTWxyQcaM4XZiRGIg+GMycCSprsrarbZxuUkzzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwYws9F/E3gh9Ck7R3hfPxebHclNp77LNUMEIMj3ATc=;
 b=nOz70XtbwM3xujiSuu1huq2W2Uzlsky2PeiWEHXfMxX6SMq3HX6Zb/IoCnbOJIFdfgxL/4IJ6aKBV0M4Eg1FcpGtoynNlk6BRsb90TWSBi9RQzMTuoZ7/fCaEr9Yae5dfIiew3MiWsFhrduoYqMdJUK8T282uRXdEph8DOGpAyQHjUDKwgByy0svPseYsFcsOLGotOfV2DwyYzY567mVaCy8rHR1hKqt3QMOBfPTyG73VMYZ1Kq5kEcOtQ1yCAuA1nf+J0Hz5mMJvRmHzQ/A0ppZRv4Wdc9MYXm5sclLVMZ280CtIvJGQqndghqyZUivmS2ZBDc3b/oIV7xueUFJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwYws9F/E3gh9Ck7R3hfPxebHclNp77LNUMEIMj3ATc=;
 b=WSmzpNPu5V/9telLzzaIbg1iyEyT7x0qNFRKQsl5EjfCbg8eI6EnOdb/flcr1c0Og7Hub10SD/heqeHvxcQ66Rz06xO/DZDO3kX6G2YeUZkBh/PO9tZRUeF27moKKnDRS+HTQa9rfIxwEv/R9s7Puj/B3cBXJmi/IoccPibRTozntmceRYQYV/xyRuodjDtOJVEkxbVemNDpGo+CExYVlnPWTn1rRpK8Az8jXzooVoaK4zG3lyKC3Z3fwBOiwjrchGNZiZbuP8W9ihirvhnCXfK73Qkz8KG0RCS/P5PJvZElicQF6B0OF5DbP8KUtf1L12pyTGkxYotxMWiWlEgqIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB5272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 09:25:39 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 09:25:39 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH] tests: ptrace-sync: remove gdb prompt escape sequences
Date: Fri, 23 Jan 2026 10:25:31 +0100
Message-ID: <20260123092531.1143219-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS4PR10MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: 48477a6d-6b3c-4e1f-740c-08de5a615f40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LszkAKDD4zzRy5fXMC7mK9WW4+gAwh/40INS5hmByBzH33R5RcTEPYnQrD6M?=
 =?us-ascii?Q?WstrD9w/5R0A+GocxqJc77FPqCwzyV9MOgkkOR4uQP5UneUfdFQSQeHkvKlQ?=
 =?us-ascii?Q?G0RAwNnFvtyoiYcQsGDSWmwcjyvRW4YbxbnvPpduO1y0GShAGCulVBmljBZ5?=
 =?us-ascii?Q?14QEkPgHLvYPRKEA1kVtXaV+Ccn3bwnlYzGOwbl4SrU91k4vSbCpbxOgDJMO?=
 =?us-ascii?Q?XCO/da5kIXShiWdHwlSiizrjyDIRVU5eA6MRAl3TWNniEg79e8gZZB0oJo8a?=
 =?us-ascii?Q?8Ke3utZ0oPtkg2g0pgTYD9cdm2N2gg/rUp/aqYw6ta3jGen9b0L24rovKjU+?=
 =?us-ascii?Q?IgM60turbQtsEtSU0cuWczPKThUSqXUwo9uvhJi9WLAAU3AAx7255n2CKuQ3?=
 =?us-ascii?Q?0bWSqmbD6BJi+ZtUBPhfPnVx+awwy5DIJ9qgYJaN11c3G9bFxkosWrOaUIcg?=
 =?us-ascii?Q?RUE5Fi1/vPEG6Mv4Khehm/875JVtzmLMz26xprmHre++eo3NJ7lus0LFBruZ?=
 =?us-ascii?Q?41pCb/QN3k+hckyaStgxZhdLvgMrafS2SBU61W4Vbbbvn2FhCGJIjxs7P7zc?=
 =?us-ascii?Q?WWAvAe9JlHgmKQjb+yMN0eRGcWSySMjSplVdUzFCUmK6u8o9nM4UkGiGs/9o?=
 =?us-ascii?Q?V1vnsYwdYuiSSE/MPm38MUd02WAg6Y7p2i5u4bWwZB33ztyeYjEhxs1h3iwJ?=
 =?us-ascii?Q?4vcHEJdPBLWEIvmQZp5wMfvTnEmPicLrZEP8niFXTZPip2SaVkG+0qzZY11m?=
 =?us-ascii?Q?p0MoQ4QL5wfuVydP1CsRxXM258crmv9TNptvAKI+7SKDJ+aqGw/bofzxMA4w?=
 =?us-ascii?Q?DpYNxFUPMaNs5Za4IWLTrLlKv7XzlOGdTGMWFbnNvxxQUapP7kV2yWkueGua?=
 =?us-ascii?Q?K69BE48WL33TS0+EersizGpUiSxvhEGrLuXDQOe3X5b1e0E8ll+f4e+ca5rK?=
 =?us-ascii?Q?aYccj71HtKId2nUTmriIjw9HXSI7FEdjaDMGCmkPDYYjMFhBXmrmwH2oimrc?=
 =?us-ascii?Q?osC2JE0x3NYN083PNo3SelwLYjhylXmQ6nFrgqBYkqMQGBAZjTEpqzxaZ7n4?=
 =?us-ascii?Q?mM4q6xOq2HdhfUP6x90Sckb/DUqnZ1HE36ZIQ7Mh2npmGPyH2pILpHoYnAGO?=
 =?us-ascii?Q?KZ+A60/kW3gN61z8rFi5JfrMAnZLg7HzBrc8rwb5ANy6DFAZPy+1cYtfGYo9?=
 =?us-ascii?Q?gM4cFRIWNlvi+k7PlVB2CDoNbJBGgVZjMxeZkptBB+nTA2k2XLXA2iRVFHFB?=
 =?us-ascii?Q?GyjfPfI4y1SVHR45cDMDvWsCK3kaRDxlBrkMcPcaQx5jsfiOCK+FjevyIrOF?=
 =?us-ascii?Q?pXOwUpPUOfsUhG9exVe2WMhN1LwttRlgDa/GQQ+J3tJNARb4QIs+PrM2DqOq?=
 =?us-ascii?Q?c63X2qfQtFvZDu3WPAMYvUtMkygg4csXlVtbfNZSNJKwaYro8bDT8XPK6kwa?=
 =?us-ascii?Q?chONgoHZuZbtMaTBGRnB3WzmQyEKjgWSpNQiBXIBl7H5r4wnx7wfj4PW3VV+?=
 =?us-ascii?Q?6wNfvcLcplaDvWr8Eh2kvHU/PCdGQHFaYSOTKQpR0Ka2m2Ab3iyE3Uu40rI5?=
 =?us-ascii?Q?KPWKR/FiZqIYp97vbP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t1AmYFXPJ37ooL9vP0XNGKBHy+U1q9RRcqpFAj1tG5eBOSz7VpXxlilakmTp?=
 =?us-ascii?Q?lU34gWdK1HDBlfGYnVr+cNsN6GriTY8TkE2giogzvOBR2yn534o1Uu3P4nHc?=
 =?us-ascii?Q?68q/ahYG7CGZXppvv6J+AlRzFB6QFalCkfb7QK9nDIRvxDuyQtlEMoanN+J3?=
 =?us-ascii?Q?LhJynJCfBCvHRdTHGeb6OUYma2BX9mcNEY6O7O49H5kfnWPthw7IsYT7j4CU?=
 =?us-ascii?Q?xR2vzlpEfGtacUgnZnXNcfTiX3Q7agtQziBQcFrAuoB/l+Xn2r3SADxhjnUq?=
 =?us-ascii?Q?rkf9ytLNcHvUvhnLfAZgs2TNcpsgTZ0c01W4WBMHHwTzl35haDh1h7K35fH/?=
 =?us-ascii?Q?EZvvh00aTHH95hBeYveV9q6ChUbQw92T1evU/rviyosO2UFOBolWRqPnAriy?=
 =?us-ascii?Q?VJ4d+/elyCGkrriF5sl4SjNJM7VzwtHVTZ3mkzdIPVbRx5Of78kU+QFRGK7T?=
 =?us-ascii?Q?2cY7lQGYavzdVQKt7iG8wE6yOdyxeMueuBEayAI3eGqzWYhTxodlNwyh0nsP?=
 =?us-ascii?Q?rWXNUEGDEGiM7vbPj6iFbb1Xn9d07yC3g6BI9wIrSi574uNTnPzqY7/zpqoD?=
 =?us-ascii?Q?x6ppNVPfbNNeRtJ5crWo7UzhwgtrQoGtz8oJkm8ZQ8blSvxCuP3aSnUeniTf?=
 =?us-ascii?Q?bMAxvEZ5TkaWiBnUkU/p4XhBdvc8zv3fG8nrfEDPEsgETxpr2WPFpfSpkwXf?=
 =?us-ascii?Q?RDCXpM8RzYK8Xi5NokOmRgabMIjNhXziwqZ8ldpzdtzjD+4/nhez3KarxJI3?=
 =?us-ascii?Q?rqMgmpd3Var6MKoJZ+jYCfpRxM+4GvCUoPG20sf7fKDlW3ZfSq1LoHihZ7NS?=
 =?us-ascii?Q?0iNF9OW+MDeC8eCLN2V1jQSu3AAhAgGJbvo2DYTktwW98UizGe6ukmSN4SqU?=
 =?us-ascii?Q?MJWcUBplXVDSyha978hr2DSQ8xKVdNR3pAORlS8YqIimg0L07Alei/0pQ2GT?=
 =?us-ascii?Q?6m+ADSrHrZBosOBSUMsj7Pkk7XeLbLlelKspTWgLXxmiYnh4dTZtIIm+R3T1?=
 =?us-ascii?Q?4TqbZWNQFoMnCF5cbc573fVMQrQP2VLV+L6GzP3RfK46HZ9l8IOLNTPpu+Uw?=
 =?us-ascii?Q?OLWBgRrw1iyqdT1PNszfFKlZAnaT3fv4p1AfoqUzfCvfwNuY7BCPpugRctC+?=
 =?us-ascii?Q?y5gF+nenhbDNYCMcc9H/LucBNedifCqa/QYzbOOHHxMyezjGMAHHHL0dZtr9?=
 =?us-ascii?Q?JjlHdHemKAlplrAR+KLtiQCgSyXW1U82dR685aUqFYtcLKPsX5HV076ZWnlX?=
 =?us-ascii?Q?bxyYqsLd+czVZMUAAajD/5N4yB5R+qLEdUWKog0FCOlU4sUfPMkh2DCiEtsB?=
 =?us-ascii?Q?zIE3F4OTNznI1NP5s+L2hRhrHQUzU2LAzqOy/EBSNRn8/ZnioNwq/VkuBWX+?=
 =?us-ascii?Q?0xIUSJmP8I+m6kLiJWvpTnUfjd4vkVnVKKrAIyUJm3d+rk/0rPEB7FXbeCmx?=
 =?us-ascii?Q?E+lpz+LRFKpCrCK1nEqPu6xOM37vVvmUtsXvTZZyoGf+DEHQ3peKvbJ7SsGE?=
 =?us-ascii?Q?meIUjmCP4zAe6RAPQBUY6b2JNFFlVkcDJPqjLY+l+F7hU50p4M3KBQPgP2T0?=
 =?us-ascii?Q?wDlCzYfbzILT41gY7EYqYzZFf2/46+dEZzHxSCU7D0jCYRBWsdqsQzbeye3e?=
 =?us-ascii?Q?A8OsGXsMRY3oEfJ1NzqXyusQ682tDJeCi0s3H13xJAFMjhAYT1ActyiPx4SX?=
 =?us-ascii?Q?iMUDxYYd8i1GS0aJkInvSvgvpwbqh+oP1KX6u/78OUEm7z4dH5I8TNfEpAGd?=
 =?us-ascii?Q?0uFtnISOHJrYDgtfnistmx/Ui3XdjIw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48477a6d-6b3c-4e1f-740c-08de5a615f40
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 09:25:39.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW0woLkBF6mJDxU4l9pniVehHZutNkCJayJs87OpyEBDwVgEYJchffc/gjiiQiOjUnzNv3D174Ihh+rtloybNVDRCN/OhkxwuSTJpV7k6So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5272

The readline escape sequences in the prompt bleed into gdb output,
e.g. "\2Breakpoint 1 at 0x271a:", causing regex match failures.

Remove the control sequences as they serve no purpose in pipe-based
test automation anyway.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 tests/ptrace-sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ptrace-sync.c b/tests/ptrace-sync.c
index ec6fbb3..239c803 100644
--- a/tests/ptrace-sync.c
+++ b/tests/ptrace-sync.c
@@ -137,7 +137,7 @@ static struct dialog {
 	const char *expect;
 	const char *send;
 } dialog[] = {
-	{ "^Reading symbols from .*", "set prompt \\001(gdb)\\n\\002" },
+	{ "^Reading symbols from .*", "set prompt (gdb)\\n" },
 	{ ".*(gdb).*", "set env __EVL_DEBUGGEE__=1" },
 	{ "(gdb)", "b bp" },
 	{ "^Breakpoint 1 at .*: bp\\.", "r" },
-- 
2.43.0

