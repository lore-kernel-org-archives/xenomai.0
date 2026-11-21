Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795280363;
	b=b8Q5PhAPTqlZvHdaxLmA6PIUHfihCXKJocbOmOh5ugv0+PJI/7sxCpTgZmYrUjb9Q5fQ
	 Kwbzm+oSnAPq6G+j75i0zQsd+RL3Avp50LxbIziM4OzzU0OFYxMuEcIm2ZT7EpQHlZXSi
	 pjKRubKvFqMe5z901hmrXTkt2v5DKnGKXVHl05/dXGPjA/h61QOtaVhjjCIKIZWobn0dg
	 wlHgEY+IS4rWcnJsSDJOKzmrgp/l07DW+4uadp2vP5SlxboYPvXr4qqydpGdtrASXi3i4
	 zj4oPPwGW2FD6+heOV5oreIgKtmlmu3clNkfy9WCsFEUcLOOct2SmQpi6m6NgbsWZSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280363;
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
	bh=V7u7FXjY4zCJpDZz+nLCmRgaM9ouh58iO2jvnOmiRlg=;
	b=JmNnj9i3wFkEAm7z9H/IYlvyJfmvvtHNBuJF5IsArX+4RXU30zs9qaWRTAQqz2VZAVr7
	 6TfkiosFoEoc75A2K8gEka28W1sM0xqN4zziwNEwiTsp5fgZ/LWUXCxpN0iDlfIzS67E6
	 5s6pIJZ9yzgEPDtsaLkV6qMOLLrs4Vz0yh5dpQHqKxO+mdTYbilb6EHiPQLn0eaMtqR4E
	 3PowIl+L8/fWmuzAei8BlIQlLxUq3PGtgiCQVpZ/DTlzXIJGbBL58elFc5O/9fl5+dgqt
	 UZj+sy2QxtDenF07rOXxSebr1nsooCf2jL03l0zfikHZ15fxRqj6FG6cyi4+EdPh17g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pgHWMg6J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAFD606A332
	for <xenomai@lists.linux.dev>; Sat, 21 Nov 2026 16:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DAFD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pgHWMg6J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTE+IpjqruIa4ZuqDGWoHDxMMV0rka24aRLp5uGHjA0TbnZzZ7b8zkwqXX6XW3jahIahfOGlBtgGEfZIkVWxktPMBhx/b9ARKmf/vqL/8NCelMP0D9S6p1DNtF4J1dT9AFNpcmRbTGoINWSr5muT3GhY8ANN6mZSK5vyG3qWYJ6gQoMZwlEt1xaI76MpmXqL3B0twi30ASq/B3OkFZaqjnG/pDsrWg8QZNgSzPaFUd0u5RnJWv/Bs52JMkaLCQflkkX5xubC1ctqq+J3J1UabE8AyYkEHIOc2VgUlVAKCHaXtwQE1b3QJ5DOr0Hm/m18VAwuqKHe24S49BMQmmvNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7u7FXjY4zCJpDZz+nLCmRgaM9ouh58iO2jvnOmiRlg=;
 b=sT5UOH9jYtmoIBjW/RXTmGFi1wNj9K4bLWj6hejNodjUN9htMSeg6gbXBwoSQ4jQ0KrVBdQBgN4sxa9no2msBsCXEJO4qhXYe3AEydIK5j4uxzstJePHekKPIbDQ+5PBmc7zuaSq7IuRXTHySw5DjV00/X1jexKmnCbP1M5WhYNCefBeZnTB8Ax6Yp+LodpWswuUVeT+U/e2mIytyOnPf9xRI+g8MuHoCFSQZs0UvwSxQyUFIY6JyovjItXxYo4YHC5EO+MrkTW093jLXqnCMa3VwGZiIrGJjKAsL9fxoTdO60MrCsVipMDwnaFo0mWaOj1I197Ak2IrBIdfp1j9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7u7FXjY4zCJpDZz+nLCmRgaM9ouh58iO2jvnOmiRlg=;
 b=pgHWMg6J5Curo20vD9fwAKKX33cstjopjW96wRazyjpXyMLE+E1HpbEhBckqTh3ntRbVGVSJJ4Gguxee4dfPE7MnHFbcXzwqDq/dhuyI/kZ2FnfZa1mzQ3slW122rOxAg4tXzmCSefoxnFLIIfGyhu8boBm1ifNvCPKllmuo5GHNeUQ1VCUkhmRPtRa8dnYLM2cQNiOviL5+PfkkLtTSEMjfW9qb7Zw9FH4VN9V5BkvJ29ElIFY5IrfKASccgGbnpo1rTc9g3T896OKIR+MiBGKkcXER+2pj4N+FQG1GyIPahGtZz1C2Je8Oz8B0UiPfAd4kE1QZ+0xqn8b2lfqOvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB7024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Sat, 21 Nov
 2026 16:59:19 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Sat, 21 Nov 2026
 16:59:19 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq state on kernel page faults
Date: Sat, 21 Nov 2026 17:59:32 +0100
Message-ID: <20261121165933.57310-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121165933.57310-1-tobias.schaffner@siemens.com>
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 247c8f42-14e2-4c58-10e7-08df47f0c889
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|23010399003|11063799006|56012099006|261022105027099003|10067099003|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261102123227099003|261009223027099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bji6fNqqwpRfcImCwelAXzE+Sb0nZlLk05AWtN721KuC/tqjrdIwuiQ8snmNBEFRDP77K5+KXaL72WAI1CUXTEtMHgZe5JuRR44jtVH4BTBsctNgdf+YroVOHHb3KCqiqf6P65hsHzt2OLLOWWQjdrORVDuGyilI62DgjTPls+zKXS1F/pTGLam2N/8bjC0e5h/8Cw7llDm++1L9nSN/1mUp5epGv+ypave55EzyTIfAGt/EEpH3oB8ufP3wJOaNjZQ6z9PSO8nytF1G8W+n5p0a5ymAG+IUlL5mUPdBVNdzGf4/dGbEZWqrPzpp5Tuxiy5R/HrFVmgFyi8XtOmtfcxgZQiT4wUeSF9em9jliETADreoyXKDm8tOKIoq1Jihgff90CfS8MRcQzXL5V6/jeH12zHE8juqhZsyIztCc7rK1RUo6nAB8vCcaql7gId6rdhTpnFYKc23jr4tCLlIBMy6OagnikXSOqwOBZSaLcojP7aD717UrpPY/wtRVlX+gozYL+/xVgaIEAsK/XtjSppJjTZnxZxrrEmqB6Xoe8HBZRFbfy+o2YsT2KHbu8kfNvmwPLONMtQNc4buNkDQA5NYSroqOwL8y5SgY4BeHmWG2pv7nd65JBoQb0TYJ83rsVOFwqWESq/l9XNyPjhlxlaaQ8svD69VlxuCgBNmVAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(11063799006)(56012099006)(261022105027099003)(10067099003)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Tg16gXzwHpcXc3tGVtuXAHuh984NLrKfHkOLx6cszJgp/D9AqIjjJU5Xq0Y?=
 =?us-ascii?Q?m3jGehOAHsrhzdOHgkSU+X2isnBymT5kVujLsPjmDQEGpfKrPUDQwxRGZgJx?=
 =?us-ascii?Q?MJch6PKRl9cdzl68KmIwkP+OdQUMFIVv1s8LxzCrPcdgacP/fSnPmIQ3+1fO?=
 =?us-ascii?Q?Ng93LBLaJNDRBdDL9X8wMpVjuWpGJsY74nnS3vWAT1YDA7LW6rvsu+pFU0ET?=
 =?us-ascii?Q?4kHRhSbugMvXHvy9iq/aziQqgGSZnWy5fQh3yBerFD4/f6IFcwbne53LssVF?=
 =?us-ascii?Q?/HihNAMIfX4YmT/7QP4nBZOWWJi/qibAsSs2q3KTn2B8mb+JUrlDHYpMupK6?=
 =?us-ascii?Q?CdYrB7IGg1DNWGr9xcD/M0EJVeYLKERATME/oQcNXzqIW5sdcOqJNbrQ27Hf?=
 =?us-ascii?Q?Nf7LwyfOnSlr3UVFN7y8ng8pbD8O04ZbAHUQRws3hdOMeQtSa2GnDXhSmFBg?=
 =?us-ascii?Q?BnszYmNoQ6vAV/ml13P9mnj6sQQ9JeoSum0UdpQPDq6+9zQC9zUqPXy5vBrE?=
 =?us-ascii?Q?ieHCvJ+xnjr4vcW+FDFuzp1VvhY7ANT8CCCJl5ovUAouFubUO0Ff/DG9PweS?=
 =?us-ascii?Q?XZojPdj3qAqWKEmXzZgFd3NodluOEKoKhtM1/yKAquw62jdHjSKC5+jYxvqw?=
 =?us-ascii?Q?32y6DaQoSSjgecb6CpU8Br8gDwLquysWfDLgMN9H2SFCF/pAxh1UKyXLYP9V?=
 =?us-ascii?Q?0lqgUbRXgrihEmvBbuT0dKykq9+K86waNAN1RIUlIzoBkNzE1lQlgzhPCmI9?=
 =?us-ascii?Q?UCh9qT78umhxusOgM1G9+TohMkaJtId+kbmZIT0cV1kro7ju7eYGMmwVaGiX?=
 =?us-ascii?Q?4UMD8zepfE/wrtBrBO1JK5TkrXU+ncQ2NHrMyZg82f7d3njS9ka4jTK/3vQf?=
 =?us-ascii?Q?MLMuF12HM2GZPqXouT1W4K+TTaqtrGn6/4BxxQvk9HVn5ZIKE1ny0tPeS4Q+?=
 =?us-ascii?Q?X8LayFszbOGqAilqOMwNgank/ncr7ZncqkGTQwTg28rSe7olihe7TiDJv4Zg?=
 =?us-ascii?Q?l+gvI/lY97LhORZTeyrpfeSf3qJysF1xqzGC6IC7MhGdQXdacJX0h1zEmM+G?=
 =?us-ascii?Q?qmXHHcb7KEYc9+XoHc3k9uhJ8qRzNxdsJ8nA2W0J9JxEuxCIaVV3toHC8+vX?=
 =?us-ascii?Q?mdeJv1cSr5eeCqYPlRtjkrnWrGxiG2BuBEyzB8X6SaR8bzuZO4mgnHMxnvdD?=
 =?us-ascii?Q?kNnqa7EnZmr5UsZAItQy52NwHrAy3YHxP6Vi00QtUcv41Q0lOz6IrF1AbpO2?=
 =?us-ascii?Q?b4dDakMPMwWjxENUmMba6VSS/H+l3KYmA9VySUuq2f8j6ipG+mQxcz2otJno?=
 =?us-ascii?Q?YcnEgCgKOxI/8Z7nWys4OR7MtP3l8hrJmhKn9/CEbes36wCwAv8s1Fobz+IU?=
 =?us-ascii?Q?rLn8IuOzJRNGPHuN+yXxO5CJrgYRJe456x7XmxIyKgRQXDssdmV5x/ENn00H?=
 =?us-ascii?Q?w/WjbaTvzV5WdQ0Ff/0FiGreii1XaiHq7m3X17U7Qa61bHjJO9gdwjoinEen?=
 =?us-ascii?Q?yjChcd5FSyrpPPHfvWaf3hW4eCN73rWjeY7rQazVzzY1PIYvuhLwQK0A2IkC?=
 =?us-ascii?Q?vMZ8xl7R1XMECTO/nz/9tLMJc2KogZzhoJw9ppdjQJjRnBpclRr0tmw0lIs8?=
 =?us-ascii?Q?jrRH2ZZwZ1zybvH0wuluY+RmS2gTSaBgE8rOBJqMe46js98vK9DgBX3TotCB?=
 =?us-ascii?Q?kopGlaquIuGG2t67sW4IsHGQji2qAlv3BFFQY1MovO9d2NQIawenjdCASEO1?=
 =?us-ascii?Q?Wwsp5y5z3cgAx7nUoAW6OBjBFFPnTBswTUXqXFs0EJdIAfdVhYr19vPbxa4D?=
X-MS-Exchange-AntiSpam-MessageData-1: SNI3zV5Bv50Nu1Q1n68PNymrhIHrC1ij0o8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247c8f42-14e2-4c58-10e7-08df47f0c889
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 16:59:19.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxhpLD8fI3m88PZTIKDJEkQFjzUiEGdwx+SrCVzvxC8BmaphKFxrfKCWIJe77OLNfdQdDFan1EN/vMrlkdVYyH3LmdC6th7AUXonVkB6hK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024

A page fault may hit kernel code which runs with hard irqs off, e.g. a
kprobe whose fetch argument faults within the breakpoint trap. The fault
handler still enables hard irqs for every kernel mode fault, so an
interrupt may break into that code. If the fault is handled out-of-band,
the handler also unstalls the in-band stage over the out-of-band stage.

Enable hard irqs in handle_page_fault() only if the faulting code had
them on and we run in-band, and stall the in-band stage on exit only if
we run in-band.

Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 11 ++++-------
 arch/riscv/mm/fault.c     |  7 +++++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index a8e37ec27cc2..47799f18fa7d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -488,17 +488,14 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
 asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
+	bool inband = mark_trap_entry(regs);
 
-	mark_trap_entry(regs);
-
-	BUG_ON(dovetail_debug() && !running_inband());
-
-	if (!user_mode(regs))
-		hard_cond_local_irq_enable();
+	BUG_ON(dovetail_debug() && !inband && user_mode(regs));
 
 	handle_page_fault(regs, state);
 
-	local_irq_disable();
+	if (inband)
+		local_irq_disable();
 
 	mark_trap_exit(regs);
 
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index c5709112c346..f72b49d8f15a 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -317,8 +317,11 @@ void handle_page_fault(struct pt_regs *regs, irqentry_state_t state)
 
 	/* Enable interrupts if they were enabled in the parent context. */
 #ifdef CONFIG_IRQ_PIPELINE
-	if (state.stage_info != IRQENTRY_INBAND_STALLED)
-		local_irq_enable_full();
+	if (running_inband() && !regs_irqs_disabled(regs)) {
+		hard_local_irq_enable();
+		if (state.stage_info != IRQENTRY_INBAND_STALLED)
+			local_irq_enable();
+	}
 #else
 	if (!regs_irqs_disabled(regs))
 		local_irq_enable();
-- 
2.53.0

