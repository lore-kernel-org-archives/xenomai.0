Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794919156;
	b=waD30SKwZBEyVn6cK5SmA9LT5h+8V9MHhU3WTb1bMOM5GeliNndLfmYrl5PRJu/yDZj/
	 CtfdF5mhSqXaeEp7qLLHwgJ41j//obHfmbkPsnDBVKTBS+XwRyQKXUlGMNufKl+sjFtNQ
	 2DhtxrGfyrp/0tTpKBMQ0qeGwEGr3/5VtJfDGySI0S1OLgoTKrQJY0gsfBV2LBmvIRrw3
	 RVPlL5XrydRnOH+4H8/iuOl3F6EX3QMSO/ey5zMbBZ2K/d7k3ZSV3Dw6Ejt+BCp3/R37P
	 ucAaTqqQMGXehz95qNhug1VresRoyirMipYx1P/pC82meRRyotx6vTVdikL+d0SdTKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919156;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=nRGD6k14h4upOk8G87ruOghIZdkwGAXf/Tvu+r17L3s=;
	b=irE+gjQ2ycjh7i1iw6063VKNppDYp8mpRE9aOXXJCt7G/nFCsYZsxYMafuRD9tAWce7w
	 To0YUE1RwhKDZMhLfaiRnfpb1JSLcNRjH5qWWsifHxwwFe1jLinqz0CuIic0eMnpmcT6Z
	 t+ZfHSwbsvGVfwSplBQHzs0O5I9vXvvSR9MjBQqHZNopebXegk946v9NkVK/C8JAc6XkI
	 9ovEcjVjdmtfyIPnWiBiv3j7IEBU344mWznA9PCvzzoPLmPj1s/c80WZWruWAiQX+7RMs
	 MldFtu3AfvIshoRZaAN4keN+j1FoN/52VqfaIATKGk5Igo5IjhUVKTYK2J1OxEe2OEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dg5oX0Xs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496D606A31C
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 12:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1496D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dg5oX0Xs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGI4kvNtpWomO697WyGskYFbsB0iD4fTCywj0PcZIoTXusWu+t1qLh61F/n9zAfVPTYjxASLfJ1xs4+xUOykIceoxeopI4EaUn3KS6NUAMsxFze9Kr4s7dglNJRETcngZicGgALg6Ypg8x43sW6I0o8ybGapO1pdbvRIvPw/V1HZUrTvSajE6Xzy18h9TtmqJ9j9Z5HQvXG0MVzG7Z1FT0Z7q5KFlCk5tzbUpR4RqcqRecma6SitlKU6TpWuYpbwYiY7AwNI7mRk9/+IDPiMcmEM2A6E92KBDrl2eDQh6LCSJcmhIuXvi8MTetA0KVpipDGUB9XuK8+ZaS+ihX7+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRGD6k14h4upOk8G87ruOghIZdkwGAXf/Tvu+r17L3s=;
 b=cyh2sbqi74riH4wxhWpjRIR+RokiCcn80a2Mq4hT/aGt0d6mgKYus5oB140pm0/6UXWq1RnZIXvUc1zksG/gvgID+olp9ZnjiIP9QnYr577Df9aLNZvs+jAHCZYgzUpD6pbjuc0ZvBXV0BtmmH03UsMZ2CRJKZpMQJymUbDN2eL0YX2zq9sAHorC9m8L88o0WJQ+3idGYNOaBcbMueu0l4CK6QlywL7T41gMqcVZqiHVMc4PCHkLoNJuJ8owpqAC1aGw9hPe9yoAF+xlbOuYv4aSaVrmOPCTYkXQnvat4rkj2RrpJwJDaSSUkPod4Qs6vPtz1iI/EUINv+sNy83OVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRGD6k14h4upOk8G87ruOghIZdkwGAXf/Tvu+r17L3s=;
 b=dg5oX0XsGjw+P1BKAWTXDqoRGlPDld0SIePKCiifuqkMdgvTDFvugPbDKT03Ns8i1Ci30OhB/1/RrlauwjARYTLPfBPxcRmo23n8Wie7glcALplEvR46T+JDgvN2fFVN0p/wd/rmNzqcWG30UQOgrYqAMey/6/bQQBXOy4mi/Tu473cczCHn6FfDKE+6K7v0cCMosrvsVlMB5/ypmI9DwB9I+DWWvoykzilY6Lc02gyqnGWqR7CV+k2SSwn71WXoqWqmeA9JVLAh/5tTemEtrsMThfcdoZ4xztU/Vx+OgkaYMbv3gOyc8L8naC+zP2JE5O9/curKhjbVc4rOk6lIWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:77c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 12:39:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 12:39:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 0/5] riscv: dovetail: trap handling fixes
Date: Tue, 17 Nov 2026 13:39:20 +0100
Message-ID: <20261117123925.597027-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-Office365-Filtering-Correlation-Id: 5454c677-be05-4bc9-8020-08df44a7c8e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|23010399003|261022105027099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261009221727099003|261009220027099003|261009223327099003|261009221227099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DI9unbE6VB+79yYXQ4CHcNUSeHytw6y87JMdPVJZDHNnY4nypCZvFxEk8BAB7/NPS8csNjoh3SljWcmHB/AYo1LFy8+QBIRclqgFY+XyRQfZIFXNrtt6B22km6x5cIVX2R9KEI+oKrWZ7VJKHklVMSi3Pv0j5eOs0PQ42OgStWTzaUTITyLuphmTIH1NRduF9a2XXngkrXV88BcQcAYKrbvMR4hI5OUgL9tMi69jN9EzgmUg6688hDou+8Qg0OkesdiLWZb/KIBNVY6NplPKkP7dw94IG0+/c6RbcsJu4b6JoXE0VnknUptp3FW+NKfZbFMhomvIbsNi7afR446KpRzmvW2v5f4F7soCKOuxQnEai2XvYgq0vuz2+tuz0QTUL3aq1t4Tm9bHFpEnXt7eIYwxdLPE7jFjds6fHaMhIbYuWHzajEgdbwZciak7N+LrojRXDyZKcnUy5cyDEc+9HjYsE+LN8Tma89SF9s67UoF8csT+JgVCsVE8tMdRqk+6tQHDA5kB/Y7VJABtCxN7CPUmIqhAUIN1dLFCG+zQ4YIygNF2bL7NvZk4vQiYtbND4yXlJxC9vLLRE80WXMLlvDDyW7tEH6nTgN9lKzJc5K7qFnbE4m7+T/zcve3wbecDDVzE7PrWY2j4H4ZUkwVvMVdl20rWxUcN2dBG1bt7rjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(261022105027099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261009221727099003)(261009220027099003)(261009223327099003)(261009221227099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AAzADlBRdqXtgb3Qs3OoqoXmvViE99HMtZ6+1EdVE1qzSpoyEu/w3J2/Xza+?=
 =?us-ascii?Q?CBeadF9gyDd7GvC3r+03Rhne1r307lrAaUZYe6pVoSNgUxsN4Nz1WyIoV1ie?=
 =?us-ascii?Q?silhV0bVyxWcjnq/vQc+/bFT+EwwWok/tSIf84A7FBMRV1eO6NBilvDqWyDe?=
 =?us-ascii?Q?gSQjPVJ2glSwj+QTtUFmv+tugJjVXHAK9FdqPqkqXpa36/vj48MJgfa1KBcP?=
 =?us-ascii?Q?VmIb08qNOqFBdO7zFW+zXS48A8lFs2xJ3ay4nhhHbOg3FAtdlqGprthi2byk?=
 =?us-ascii?Q?4z4GOi7i+fPeS3R5OwlqkPflq7AzCJj7PLpgVD77BFGl8yNWDfbBnsku/TZR?=
 =?us-ascii?Q?Q/t5iPTv3CDstpHoqbB0mwx5hrA9W+zlFiuzAmwQGRTPLzZVJTYSS/5JMR0h?=
 =?us-ascii?Q?K+IjlrNPVqj2Ys48QJhFymVwu0V6ePbhOhfwnWQOws3XMifuMBtravroq9p7?=
 =?us-ascii?Q?82gTmfbmLPANkawsf2rCym4psq3bO/DPicZrDrpMiEQxZVcSXWJ2dQmP1mJN?=
 =?us-ascii?Q?u89zFisPNods/J1VK5f9+FWt4euATepIbin9ZB4we10FqVoRYCb4jfLpqjq3?=
 =?us-ascii?Q?jFvolnkGPsiCWTcGi41V2wHkot9//tJu40fWgWgS0mBLuTzyzVVwfffIeLpO?=
 =?us-ascii?Q?Ax6Qe409wSW0iloqPvMy37ZtPKRT7TXEUlFRsakaj6rckpSI8KHOepOZILwq?=
 =?us-ascii?Q?NqvwzdR0Erv5h0hXNxK7i97tgn+N3Tq5WJ9K5QZPv0TCd8opiUtAh3l2SIPz?=
 =?us-ascii?Q?98zY5c0MJmIbnM1lgYFfVx/00H2/+9zT9qoxPoUCdWxkX0iLLL6cQoJruqx2?=
 =?us-ascii?Q?NeU9yL5/yqSPqJ1DTZ5Msyc1a6/Ty3A7Ssdb27euY0bgC24LvKpIsFURmuW6?=
 =?us-ascii?Q?DeJZKk4yZenr/9dajAuRIWQeK8YuiNyKnMiJuyhGt86txfPW3kph6KUKgJ0g?=
 =?us-ascii?Q?uUm9ePrWg2BIGNt7+0swJDT/6upTbyIvFLjj0eDjE5G+/O4wLMA7pGSnmV3s?=
 =?us-ascii?Q?JMQ2XjtuOaUuTfFRl+p6+o0TIu6KWNC7gZDokEqxvD3egOYr6SB/jIDPiRLx?=
 =?us-ascii?Q?shOmWTk0UEfYa4EZVCGdUBIx7NtepTC1Izp93msa/AlJYr5eAk+gamFBSk67?=
 =?us-ascii?Q?/O/3VnXUdTgCoYrJKkPQxIBdHZFZHhtsoLdNU7C00FGvoUVM7xFcHZVXyc7o?=
 =?us-ascii?Q?Fzz05UTX5GeAEYHPK0mOmETOY6tL5NEIbk3hKDfXNyY9iST4E7/TxUnrDGUJ?=
 =?us-ascii?Q?vqNbcx/EESTShQpmBGuDflx61KneeFCiIYyQbJB8RfgA53vJ+BXJRABViGfk?=
 =?us-ascii?Q?QfTSd95c2UJOKv+qp/RDw19evj+D8+EMZZDB42I9PbM65/wIHZjB6wUR+q2V?=
 =?us-ascii?Q?6Gb7Hdi5l/l3fiS+WVyUn8jpAWlfMQ/ZI8KxjY7YL+5HCIbPRI7JLp1RUc+i?=
 =?us-ascii?Q?woGJr+YYZwCuiq1Sqo/3nqjiR7ryv9J1Fh8cdFSq9lpVMjD43KMEuZlRx303?=
 =?us-ascii?Q?k35UPvmGiJoietNUvmskKHMdkethGg+ZO1LrCQmjYZpT7YiIvUkgd9Ql/Fdg?=
 =?us-ascii?Q?W3o380Mryj9dZyibstnxUjGxrmWCnA4Waw4Gnf7UA5m+91VhD6/60VsftmoH?=
 =?us-ascii?Q?SEQW7SWAQG45y1X/iSwfw9NJSO8Z5gMcH42fJXnMiBjyAk9rPBkv2QtJxakL?=
 =?us-ascii?Q?kHt/3mI2ydnV+ZWu2allE9aRPwXPNBC7QaJHWZI6bEhThUjzj3o80srrpEdU?=
 =?us-ascii?Q?Pa38sqsMYrCX0eZ7Rp6fSRBDmVbobCXajmRgV4uXjY4U0wEcCpFss1fvXmmC?=
X-MS-Exchange-AntiSpam-MessageData-1: zNS3FVK27weUBCgUrKQ3IqtFGlr+Cp+F9pk=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5454c677-be05-4bc9-8020-08df44a7c8e0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 12:39:13.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfAGNr32XyEDWjosCvG2S01NXYWB4tE6H8Dip3cteOcG4tULIG4yJuOoBNIob4Kin9qJOgZFQCigzbpvP+9D2NNcTbO8xTb34VbgzXIqcko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992193

Hi all,

this series fixes the riscv trap handling of Dovetail.

Thanks to Jan for sharing his AI reviews on this which made me have
a look at this.

The bugs were verified by running a trap matrix test, which raises
every kind of trap from an out-of-band EVL thread, with a more detailed
oob_trap RV monitor from the Dovetail RV RFC enabled.

Testing was done on v7.3 with EVL under QEMU riscv64: the trap matrix
test, the libevl suite and kprobe tests hitting out-of-band syscalls,
IRQ handlers and nested faults all pass with a clean kernel log and no
monitor reaction. Reverting the fixes one at a time reproduces each
bug except the last one.

Thanks,
Tobias

Tobias Schaffner (5):
  riscv: dovetail: do not notify traps again from do_trap()
  riscv: dovetail: run kernel trap handlers the core did not demote for
  riscv: dovetail: do not nest the unknown trap handler in software
    checks
  riscv: dovetail: keep hard irqs off for page faults handled
    out-of-band
  riscv: dovetail: read the CFI trap value from the saved registers

 arch/riscv/kernel/traps.c | 60 +++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 28 deletions(-)


base-commit: de6ccdbc1027fda48257c4033c90d57da3e676ea
-- 
2.53.0

