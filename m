Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794919160;
	b=3FyiSC+Al46gHPPlzheeVql2WA8UHrynVgcrpS+NP9T+I5tsucjeqSRgIPVE7ioRS05o
	 SJU7uuIfvRPKG46pTnz8nPccQ45tPHneXj6SNoTfDHSkRCENwc1qryEu7PV2Zd+QvPoJO
	 PpFhhOPnr9SFjuVWZDA8RsTbTTczhWfcKmC/avug+55ztbgafGJdoQhFrsfkM2RyTBdS2
	 GcAbaWYl7UVls9+qlF1kpk7EIKdbESi/rHkjFYkOfj69GrQ7UimA0O+FKqQxAXJkUdyui
	 A0/PHI6/3g/0rTqkUXOiboRNX2zy3/HQIHzE9BCKd6aWv7Yv3f9y5EMAfK05aJCFGQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919160;
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
	bh=j2YPzLMlhDGR4EEmoYARCYa5ERh6tNAyO6PdMuLmhC4=;
	b=TfrBE4le8JRNMevyb3GMGI7Zc2unX+KZHTkWYZ9w6NC2ToMwM3M9S267TJrBuuZ+pdsL
	 TyBAp9I1rhpXIRpipuEictWKKj+Ikvmp8i7O9fzoJ7N6kBqwHpWZQkLHAuyvSRG+2OzIB
	 JOpFLFXxZjbb4pZIfvJTcyDLq+Pj0a5aLNRowFKbfX4pw/Ogd3l7HwNqN0EjYEjsLNb/+
	 yybXk0clJYmBQIeiBpi4zc8ZxcSCvipayv5u5Q9ArguexTOEGd1dm4MG8pgIfq948+VvU
	 GOK3+v616sYamcKfruP0c9nNsj9OlP+LQ/TgL4aQ4X0VKvIfBiXOMYYrjltWFoSNPJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=MDLoE7+a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67E606A32F
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 12:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E67E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=MDLoE7+a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMCful0PfvbTXMMbBdeRCpygDcfaRhldUgRviypDwaW63iK1ik6ZRZPUYg3D31Z5wKIhUwI1LZ2yqd5XGsvJXIDRN135/aY1mxlsvNjK8W/wlZzvUEpO0N7b773EK0AZ9UHlIbqNp1Bw9y3+2u7Fs7vY+ASkVnEtaEVPKIPDN1P3G9CNYDSoWjy2efmtvx9PVyhZc9Q4vS7LklDF7QY6ZcKZOFnbE+2GmiuIOPjYTYLTBDIziLFVpzuw43lSxQPsUzA3GaTTbG4ygM+kI+rSHt/ehIvWa6BKsBxPtKzwi1gsdZCMxPUK4araZIDOfXQe5X2gp/NLhch0WTAqXDbWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2YPzLMlhDGR4EEmoYARCYa5ERh6tNAyO6PdMuLmhC4=;
 b=Yjbgpkb52nul7z5b8K3HKF3d+N1LQu/AnBV7pnwq14I20rcFnvwuWRWU3O1RELAXFy9tTh1pYN49O3YQMzT1+TuCD11OnoIyKdcF6fz4NBCBN3WKwdrNLFYszUmwry5h3L0x+YsC+1sPJYROQz3o9l5ouxjLRU0zNhAv4gnyIZ9yftogyC/wfAcCc7PWTldzwwFBDJUiHtH9s6+3j4tKWxUwTD1tGn8GD59EiVJoKltX9mgCmK9DloB0CSS28+CzY1+fip6I3P1XfWXeNVwRge9Gt4ixA+a4bSjc9vKdbRBdBvWVpGfcbt/cEDuoLppgHYpsix4f2OKKUvtJlfHHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2YPzLMlhDGR4EEmoYARCYa5ERh6tNAyO6PdMuLmhC4=;
 b=MDLoE7+a/F+/0F3CieTFwVKcuedVmVe3kibkzu68sJ94Yjj5Tp+0G4CUYrXP/CrahC82Mpnm4CBOAgqP1XO6kggGm/xxjmb+x4WdRM9h1RRHyUUjwf1cVSu7ZFjoNe0e+9SWNG8IaGyhh4u6AteISSE4+k44XXigRzhpIfJKwEMFb4OoBHNb0D+kmGJArq1uNCH6OYQNiAoED0VHub7V4nwIOWUbX2eFemC2QW+wb72L+0aUypww9efGLud1ZKPPeM3RROuX39IcugfKnergsBkodv4ItqBUQM66c5DbdWhBJL08XO0nSPKRo+n2Aqgg9ZQMju6gS5n5ddOdYUvuxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:77c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 12:39:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 12:39:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 4/5] riscv: dovetail: keep hard irqs off for page faults handled out-of-band
Date: Tue, 17 Nov 2026 13:39:24 +0100
Message-ID: <20261117123925.597027-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117123925.597027-1-tobias.schaffner@siemens.com>
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AMCPR10MB992193:EE_
X-MS-Office365-Filtering-Correlation-Id: b00954ba-ad1d-41de-4e36-08df44a7c9e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|23010399003|261022105027099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xBhQW8WjUrAQMg3+5I3SaPEVUCcAeMBZLO4YxcbkVCgCZ+EctsSUyhNAkl9kTn8LKClP6d47m2ci0HQwcZIZ0a7ELSZykoevUeBdjvXRzBGP1J0w6xkWeFaGpfTNb1WuMKhXam9y2cotnG2hyAm4xYwnbjKDbTxTy8IzHDcgk1Y2pAJBoalMeyAZEFcnljyco221DJ6+sprBetpvt4ifLVauV7Ogav8uOxiQ08iLcBF6UAemXhigIsLNLwzqY42kE9Pxslij4gLTRGPRH9E5n8AtinjnDAMn9GBGh+jMcDSWUEro5Psjt31+xvJ4/dCwUK/RZUZsXOFKPMhKWK7JidVs/19l5Iejwln9zMwPyPDKf4R+LvycO8my5lfcua71ViKpSq4qKAClseSS9SsJlTuNDDoUAFENKEhEK3Gk2wa0lZvH5a3KpS1musPJlmJpEJMf70piNpwyQgf6eDo24sVf8wKEwpN+T3TKePUCoMpQ8NxBU4QMMMISkPuGkaBE4DEkcFh6dgI3zrPvMgnPsILiA3ryoEPcGacCJF6+3PcbZTSZvi/tesDJZYGDYfk9zRkBugtb8gwUpQoYi7NvjpQCY3IlSeIoiFjHedIKu5l/OqudRvqTBDsk0jHZR91dsqPyK6+wrOOQ4PWBlI1mOc5NNgg90k9cESjpAnZYJRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(261022105027099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KNv0LGQSC/4BT4k8p6TlHGAmFrsk79TS/zWpQW6qnpiYbjqcEJ8n+JVEBmLa?=
 =?us-ascii?Q?1M5eHXX41FE419z8PxHIOPk81NcWpMF+9KrTIqxa6KeZ0B77RQXnAYCVYsMj?=
 =?us-ascii?Q?O0Dq7OJ1R/PpRy0H3Bb5Ac/0C7CBwgAws41BibRJh2yRDzc+t7LJzwr8km55?=
 =?us-ascii?Q?zukAX5YqPdgPBRebOQA3XwCZZNNHo+LFhx5isAe8lktAXceV/OQUYGAPDiQo?=
 =?us-ascii?Q?3V2x4/nkmOcFCnRLZtK5elzrZR9vcglmpso0njA35ff8Q3/B4fXw+MlOAtR2?=
 =?us-ascii?Q?IZUDOKBzJP5JJzrAfzEBS++M2X+3ho7XbMedCpFljonjQ7HGdnUJSkgB6NG/?=
 =?us-ascii?Q?BbpqYnYa3GETif+/Wnvigs7H/R6wavLf8E3J3+ACxyQZaSv7rJlCWqLzy8x9?=
 =?us-ascii?Q?48rACpUflbao+k0/2ctagEtRdGTVOEUx4qdxqT4dQ0CAHVO+YiSAspJuT0tZ?=
 =?us-ascii?Q?a2witlejzpXAVUsyxrEv90Lu+OStjX7fVgHAxBMxpkL8bpgRBoxDpMMLwWVx?=
 =?us-ascii?Q?jNi48AjZvATF7BnKUxjQtQemFG28eNFutOnjE6TcRd19oosaN50c8vWoG28Y?=
 =?us-ascii?Q?XUvH6BvfdudzsqmZ65sbLCqoxfnU2DLoGZ6Y00vCPUTnRvdDeNjYpDk2PTUn?=
 =?us-ascii?Q?CK8EoSWJ5C5VEuxATjsXLm9wAsvJmyojNbXooRmpeZFqywsKbSoxPQ4bDkG3?=
 =?us-ascii?Q?YXuQ9FaevhLOgQLvUt1wDZKrShxp2zRLcowWUky8ct3pBCbo1t5A+GbfcRx1?=
 =?us-ascii?Q?qdEn+Bc3l4tmB6KgMPaSkq7ff5CcAiiWZjsMKglfhVwQaWRutSgfet0cRhvg?=
 =?us-ascii?Q?gwNacUF0UKVOf+W6WgoM03/yhbaRUp/DyXDuZdECEpG6tCkBCuPcZkajCs0z?=
 =?us-ascii?Q?UvbxUmbki6GaYxrNfX/gaDClXu0S1o3xFMg8RgG0jLQqi8OncqpsZP85eoMU?=
 =?us-ascii?Q?pyWBf5bycCM2sVuXLAfdvosvB8u9UKkiia8LT7dvYwVm6lfrgoOtys0Xolm5?=
 =?us-ascii?Q?xDby9DOizm3A3kUdC2NiLmxac/GK17k86z/ztQ662NhJq9AQPAfIrEndjsyg?=
 =?us-ascii?Q?vpBsTIkcUHU3jYKHtnW5GP4tLaWqeyoqeC4/lrGPKsz+KGwG71D2wbplWr9V?=
 =?us-ascii?Q?KNysEeYDCUlnpUBQsyxcRlo2U1gmsX05i6zFFR2eSaCmueW6CQxkJd0z35uO?=
 =?us-ascii?Q?nreXjuLONzYeV/LpG5Xbm2thPRSr0oWWalJbgqTDB6LwFIm/Dm8BqHSZM2Gm?=
 =?us-ascii?Q?so49CTMZ9hyb690IhTRzaP1B5YpdOHSTwo7v1byjJVkRiA7agntHs7OaZl/X?=
 =?us-ascii?Q?5QOQ1BwzqgqPzpiHGw3UkGnB/LKmLFKMuZHKMCODwI2GbrpMRqpc7FKMA1xJ?=
 =?us-ascii?Q?pVfWhPa/Z0DwGHILVvWeqBNNGkZF1peg2Jdremc9U/Nq7UnW1kloThmTtKvn?=
 =?us-ascii?Q?U/pa08JyiQgtyPg7BW3X5an9xA9lv0iLjEYDhqEHqLil9xD6zJ3n187Cgneb?=
 =?us-ascii?Q?h+Mrd+iULrRwtqy+4Gwfv0OmwYMzTkZEf8kXNmz9CdWO440jT2ARXjcvozxa?=
 =?us-ascii?Q?u9/QnfArsw388IC+fQ79ySC5Np2WSj4bT8uEeLA6yu1ZyzF3ate49NWWr0UL?=
 =?us-ascii?Q?lnOr7ab1gHHM9WCm+HqC64eDQd1pFmX+yS9rtkpI+cneLl6mbOIDVrnPuySA?=
 =?us-ascii?Q?YEFqlVgilnTyXxKRz9L70GYHDNwrPihGjrWC3tVJ6VLZAxj7qvnZ/GlAsNAk?=
 =?us-ascii?Q?bc8vB1ZNv2pi//p6qd0A9A4PMy0xnzdYBi+MC6LpB2Ps7/QGSwXbzdS1T7XB?=
X-MS-Exchange-AntiSpam-MessageData-1: SiI6Aumq21s73Ts+Zy00oLbrD2IaUVDQpZw=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00954ba-ad1d-41de-4e36-08df44a7c9e8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 12:39:14.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmZ43xCl0uAeQdhN8ZPLbUEQdsvfhjFQdgNspjZ0ViaHXYWDnjHb+c1h14AMI4Lzc82mc2M69X2/41idrUA9gpcHJjROiiy2/Cb4TiF5k58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992193

do_page_fault() enables hard irqs for kernel mode faults whether the
companion core demoted the current context or not. A kernel mode fault
the core leaves out-of-band, e.g. a faulting kprobe fetch argument within
a kernel trap, then runs the fault handler over the out-of-band stage
with hard irqs on, where an out-of-band interrupt may reschedule in the
middle of the outer trap. With CONFIG_DEBUG_DOVETAIL, the BUG_ON()
checking for a demotion fires instead.

Toggle hard irqs and the in-band stall only if the core demoted us, and
keep the debug check for user mode faults.

Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index dddb30711440..9f8dc6bd7b85 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -489,21 +489,26 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
 asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
+	bool inband = mark_trap_entry(regs);
 
-	mark_trap_entry(regs);
-
-	BUG_ON(dovetail_debug() && !running_inband());
+	/*
+	 * Dovetail: a kernel mode fault the core did not demote for, e.g.
+	 * a faulting kprobe fetch within a kernel trap, is handled over
+	 * the out-of-band stage with hard irqs off.
+	 */
+	BUG_ON(dovetail_debug() && !inband && user_mode(regs));
 
-	if (!user_mode(regs))
+	if (!user_mode(regs) && inband)
 		hard_cond_local_irq_enable();
 
 	handle_page_fault(regs, state);
 
-	local_irq_disable();
+	if (inband)
+		local_irq_disable();
 
 	mark_trap_exit(regs);
 
-	if (!user_mode(regs))
+	if (!user_mode(regs) && inband)
 		hard_cond_local_irq_disable();
 
 	irqentry_exit(regs, state);
-- 
2.53.0

