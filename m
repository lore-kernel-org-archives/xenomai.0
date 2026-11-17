Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794919157;
	b=wy0ZVILFuVJLgb8Xx+gc4WIYFdIhHsdUawpYpkLf3Zh8S+6gfZAegR8TCrVtUE74lgik
	 FRfNT88IVyLrdYMjXZpXsHbL9rm7m9pbutvApSjU5jG7H6jQjaI58E9D6J5gY/3kqu+j6
	 Sj6e3tuXqgz4klk/qBeMeJHlCkbWpTHHZCIM8iMs63K4406q3LsqlOx6TXSJAe6SOrdBb
	 QuYU8D5z/C9xFZ8Q04gZCgR2xZtN22yZAQzqMOZv+dCbcB17d04sErCJPpZLZOwt5+YTp
	 phRWI3fmuSdz0fmiyo3ktt2mqJ7SqkV6+i+wsnAl9LMl7m9tObx6ad+kLu3CcfWrPkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919157;
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
	bh=fD+lb2ZVVdR1gq1D9oRzrEB2Onc6srPEVqDsEkiZCyk=;
	b=3vcbu+nLYpzyb47S9RuNdM4NeXZZaCT1Ck4YX21WIWzl6qN3dJRDjz0dzoOojrWPUmSx
	 ThjK1xjftOwyO5O/K6w+Wu3r8QCnQdMbFPym6ZfiLLEKFClXy4lszXgaZT8rYIjUQ+p5H
	 BTQMkyRKeeoVJfaSLSBklxI5PaUEyL5gNSZSbNaOZVK3cy7bsvmBcSAY/2aGur486JCfL
	 T6SEFma+ygxhAN58tEIiMy4K8xM3wToCpBU9qTkaUN3/ytqLP61lw31IUn8gYLJh8VayJ
	 WX4i/1ap+oG+0VOCfjiMhKx8DOhnjGwSubgbjNYU0V4Y0+JGlfIHkDmVuSYZkwdQybA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=gGWZP2fQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027A606A32A
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 12:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0027A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=gGWZP2fQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCAHxhHdfI8VAWyAfQWs06rcHcVCojJOKAxJ3jZ82owy8ZA7TgqDKx3mQbjk5Ty9Dg09pccc2Niv+fPPqQ93tYRW81oTubT12qK+DyJuuB1SLnsVrzJoEUZUMILNH0J+uOLgWlNIg/aXBPNdO3G9L9cUaHPDkg/83xs3oS8WpgclisTPTlq3XjIOv01udLgGQA5JkNiPWVu9PI+U3djSf8a30HxXW5hmLjlJfpLMQoAcfxBDp2oN/nmmZ4A9AZoEtMZEdbdHq+Tvt55Y29LdeIm2cbifh911PPTXrJlYKQJdhE3/4Um7WdVnmTDp4juV5bKh5o1XXP/gSiAo8XlyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD+lb2ZVVdR1gq1D9oRzrEB2Onc6srPEVqDsEkiZCyk=;
 b=bXtZkrkbpX2qomp1ATza7lNwdp7cerUTaHIrFDvxtXxabva9ZYvUf4ACLMQh4DSyHjCe5hY0B4XCRkK/ZfNWAT/NUa+RXYaiUBk0B5+APa1um3HbvnBCX8O9h4iCzk/fqtWtcs7MBFW+y34Sg2W3lVCkrAdxOIkf2JMFcSa73Wk9TfJrbA3Ej5e/K8lWOlZr4BdVDBj0bzKNfccUw1Rex1Io0j73ZxyITOVil9LaU5JyOHycdkH+bcXxMpRtPbHTnfqBn5TPS9nindN0qF3ZAckJzD0SLEQvKZ9VmFfDavvv64f4H8SUJQmRC1/pNbVdAq+u5BY4bIxqffKDF1ue7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD+lb2ZVVdR1gq1D9oRzrEB2Onc6srPEVqDsEkiZCyk=;
 b=gGWZP2fQEJhP3WdYyxwJ0DK6fPUvff/xPY2FmlcXVGKTqEIF8z6SKfbSXC32l11P8LE+tMqLa4gBh5rFfuNYUBrxc5Ukl8LQjP+ERhHVyy0m27sBNasFuIGW+4Zo085oCB/rS4b7b9nr+F+LidOP8YkCM5n41C5IMKVg8wpZWgm//YuV6I2+d0a2r5nF/FedXlvvx2PEAzFaDKvSiFelFc62/gM599Cbgyg8qvNVHVAOaZQSUL0Bwldz1lTixCLTPunSnxgGtojw42abvZYRDlcXz6uyIimmKGbEnDzak9DHapEnZ7twXukFYx58ZN6tx1Yd2HXYpmKS2CASF92Q5g==
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
 12:39:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 1/5] riscv: dovetail: do not notify traps again from do_trap()
Date: Tue, 17 Nov 2026 13:39:21 +0100
Message-ID: <20261117123925.597027-2-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7179694c-9930-45ef-feb2-08df44a7c934
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|23010399003|261022105027099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261009223027099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6RgAh4AgRBK0qIpHxtkHwZlSgn2f5QIk8y9tTynCEzsNybUUlvHAIg5kOnagUDu1M6IhQHKzHduyD+rfwpK6WJKE6qEhDd03J0t674VkAcUDuXlJfZ2isj7gptzLvjHh8oL+EzSUyndRWhu3ilbtX2Pj0ZoUUhfzQbDXPzABySlwbTn53mv58yLdlaqSsgyanGXxF0UdRG4vuMmW/OzpoaQfNNlcjEiH5/aCdUyQCM11E2kozNyW80keEpS3VOJvfvSF7zBIp/o0VxW0o0V+xgbUF2NKnumnj6jQHMyocWKn36kx4Kv2MSmZSE0bBW3MPJzevDl5K56XzDypqoZuSAHAWDXWiGckJdCfzqcJPnwMEmAQ61HYbiiFY8PDoeFnS3Im0L6gRQ7e0/fJJbgw+ev7WDsI7VZTl0vaeQpy8S8f+FMWhSztZWHEHF1IP6lnjJCZk84/xoSSO+67pTHUvUxAhhMwyArvLf41YnW/c5kSAgqKzmR1G6SL2RUckAzCs8txFsLB5H426RnU+3ugDHusCA9rfjz+mfFiYo9o1p4VpWCm4jn8N5u/y9f9qt3QOcrHuIEpuUO8LociDClJ29MlEe8Yiwgqa+Ef7AHvWYmclCMfoVPqHK3EoH7dFiZJOFXsgIdXjQtzA+qmnWwYx7olsUGloahW2ZIhkiZjTIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(261022105027099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261009223027099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8sDBEguSKCa5TV3ExFprhfbrQYB8sJZtXdTQ212znvSSRens7iDq4xqYYmUq?=
 =?us-ascii?Q?nraLSS3yt/Mck/1kyuICldOrV4hjrpmIeeYRsodm7BvM0mt+clcC9SwWLff4?=
 =?us-ascii?Q?vRdKKZe64Ae+mqfB4XAOBAEjavF5UAJLH8XGEkHus6t0qj6r93yuiAP5MAk1?=
 =?us-ascii?Q?V8jK10qIQtQw1aQW9mxpZrhJ4GKD/DGktuGN9bfNI6KOVLZgdIv4f7+SSFmE?=
 =?us-ascii?Q?hySYzGA/cX7QE9/z+2MFb0IVfED34jiuHiVqtTtjpMn6dL/C4LSdSBDQKTub?=
 =?us-ascii?Q?iVYyMYJQoaDn4DH7XgDuwkGu8KaqcEwyAWbKAsP2XoRRFqX/aroVf30QaOjy?=
 =?us-ascii?Q?BMzvrBjJwqVsc5b1TiuS2S1X1l2tffqEKUxG0SG6QIwFezX1xLZCEjkUWjJl?=
 =?us-ascii?Q?hWyBKa3GX4nkuV0PyKrBeEgYtJkz75r/z+TTE0+3eq50mJXPH/PxR95y6Axz?=
 =?us-ascii?Q?l7Q4r+kugPnZYyRMsIGUUA/EICO9apOGpRJrRhOwIR0CrH64mHZUv7vdXQ9B?=
 =?us-ascii?Q?/fvNDAQdYK3g1+rrDB5WMRb6Ifa/fQ3WwpmHAD34Lgk8Pl3z2Y6qMjwQf2q8?=
 =?us-ascii?Q?YGDPSsoM+85pCsarUakIeTj9bWkM2GuZWGl+Rk5qK/6g5Zj5YtGXNQhydJ/c?=
 =?us-ascii?Q?bkrrl1dLZq+4PcQ30tIgelZ4gd+6Aq+ItYCqdZk2GC9yrmhVw+r4Ji+eMdIt?=
 =?us-ascii?Q?bxBCg96isRqNZX7jE1QaGaDYgRXQb7271c38HIGz5NkfAahKlmld/1DIsepp?=
 =?us-ascii?Q?maLWHo22nR+1rzDftXcXIbXVAELfA3PFJfBUuBFPtTRX3u/vDtOBBqmfET51?=
 =?us-ascii?Q?HE5Ux4SSozAPiNY+5v9u8nPx6oQkuGBNQpcfASONewQ2yjWlB1FntbqmGqa/?=
 =?us-ascii?Q?zzOJuybZpLGd0z7bVi7UGwaYYPk2UbxdviJIIvspCNMzQh8SGz6fLYMau0z6?=
 =?us-ascii?Q?nlibtrPwKc1yVofdh/7UkIevw4KHZ8vocWdrcB0+Q04I0C2+A0pnU2kmJmdX?=
 =?us-ascii?Q?sB0GVOq8A3qiYxBipsUiD4kN/Gc262l6w0JQr37BcMBX1JBadsDur7qcjG23?=
 =?us-ascii?Q?DmPXom3Vdmj8wulNFnNMCYrEW1qkRe9HNErMlaW3FR5dclHKMCsdzqQXIL3E?=
 =?us-ascii?Q?jIRypOzstvbzMn5TBVsGjWeFupJCy8ueHfGPVXUySKifRh2u5apMXt/AqZGx?=
 =?us-ascii?Q?g35Jlmp/Hq1c3fxc+loY93eGzo8JICHzqEu21Qa/Ei1scq9u++vIS6IuObWI?=
 =?us-ascii?Q?VYDX3EnihhwZQeTO+I9RoBFBdTShaPpLfvtHfj6pQ7ZiE9WyRaC9yL92xDPi?=
 =?us-ascii?Q?Pei9Zwxcg3+g/bVoPyPQDi/Q9k9hjYXElwDpHQi1XObXUXv/aHlC6RD07xdr?=
 =?us-ascii?Q?n97F8O2Kw6Yx8oDt9lZWkamP6VBD7ZvNa8/VqtachRoSqzK795E/CLyCXyWs?=
 =?us-ascii?Q?yi24XhHjLNUgf+jaSHEXITJjC8bKWI/fwSNq64cn/DvAEsqhZvYapmb9pjsU?=
 =?us-ascii?Q?VB81ocvbqvuUUg+O70qypnAfakw8kTGxMZNXmNVaoNWUc8JjiJvehEUWLPiY?=
 =?us-ascii?Q?O6Pmhg27bordP4jtUctGLMA4ZPA3sX9FMuzoIMZKC0UoVzi+nj/T5u+ZtozH?=
 =?us-ascii?Q?TzZhp7actSO+oUW/SitgCi8juOKxmNBFFhps+M3Ex8/ifOADBQuyX39qDvkm?=
 =?us-ascii?Q?+MoBS1qe2e3NErmA2bx/hI5ZUVu8JWDGZrxHdudo5OEcUsC5b/uaEVNftBKf?=
 =?us-ascii?Q?tYEYWsDSRrPrtNjeaBtJi/v2iI1uZVRzu/nsttuDQbOcUBCEB3DH9nNTLnl5?=
X-MS-Exchange-AntiSpam-MessageData-1: wEOZ2NZCe2V9iCW/h+593+2TNkwSE+lb1Ro=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7179694c-9930-45ef-feb2-08df44a7c934
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 12:39:13.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/vYqlm6+naSnoVmk/PV1+lnNQMARSUWjzdu+Q0l4z2gCyjil6rZbgnr76lJiPXbdy2i/MMA8OAaeowoM+6NwjANfzofQYLChbgaYS0Rj3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992193

do_trap() is called by trap handlers which already notified the
companion core. The nested mark_trap_exit() unwinds the trap before the
outer handler is done, which then runs with hard irqs off, or over the
out-of-band stage if the trap_exit handler switched back to it.

Drop the nested notification.

Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 897fb63ff10b..e2d06cb87c6e 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -142,9 +142,6 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
-	if (!mark_trap_entry(regs))
-		return;
-
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -156,8 +153,6 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-
-	mark_trap_exit(regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
-- 
2.53.0

