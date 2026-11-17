Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794919159;
	b=QOpfb/Y+ZpZD6tiIcuw7ZR0ti6CsR2iemjgPUzasxPAU+R6IxG9z+gPZ32tJdhW3HLhs
	 oCDvcVUy5jKKaqbr92ErGz1EkABRXieHenvxygu+P6HfISJNMHer/HuV6slQOAgNREU2H
	 nSAyLfVyzbI3+R/oNzrUge92E6Ovk1fHBBoKAmkujbKz5Jec4lCzqD1UkcyLx2uNbejBH
	 0nuqnOBWYGSztkK3br5L/Tx1mY7sAP1EAzWw+1aLVZNd0WUhbp3CoZmMdmzH2JKQ7YG2F
	 H2fyRGcy23i3Gs8ljIogyWvY17R6BKISXrtQMX9iBgLoOPAL1nHnMqcjou1AKMWHVGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919159;
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
	bh=yF422QPXb7EWVk6KnAtVgx49zZO0SfPHteEoqEKUsMA=;
	b=NJ6jNxa/cTzgTzPofA5ZVTgR3QaynXjHNaCMaWsNQogmob5RdWmfNyNqQ1qfqi+inwOs
	 tLPCRQrI1mr5EmlQPt0h1XV1a0YnmNNZpG/HZAibTiFEKcNeX0nUQsKhrHLv1ZUk6Bw7P
	 DShMI/4i19jJBdSYN9FyhdZewQkCo4SQn1+UFwxJy5jwXzV8KVXISlnFUVxKwuXbPi5jc
	 QwuWD2GD/ArZUXRlBXwmp56zimDc12agC2oufnQ3VcrSVhuaQen6lDxlWkGYMC04gGhBD
	 WVnM8NH/pb+cMM+xgZkcUY0neu41k6626O3cS/tavUjlLczl9+K/V0TAnh3HhcdzU/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="j/WqOo1p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFAC606A329
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 12:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BFAC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=j/WqOo1p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIM3Doi9zHM04RGsYIUnim1xHxG2VfxxBZadGQ4i/sNxFOgKpLcqsHoeMTQKilIPqMIsYbY16AV/9mGk7R/FbSs0eeGQ7UdjETER9PLEaUW2Q5MTeAk8Hv1D+ipXls0IfdMkCdQpvPKHTyksi7I2K8E5BpPE7eLI3y2SgWFMm2yIbXxqSpJaO/K6dGXqLWzxsjtty0ySQ/DeQTzOTkJMKmoy1TOQ/ACmjS0+ATdLZgpPqHEaZz5nIMhsvbxCywPv0TcF709V2qCy6t/XEgH2Z4zbUsHCBrxoi0aBblybPxzOzVesq9uMmnUz7Tp6J80qNddN0xzSYb6LLr7iHuOkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF422QPXb7EWVk6KnAtVgx49zZO0SfPHteEoqEKUsMA=;
 b=SdAz88gEf20BjeNPTOqqTyUrGWNWMPTEqxXrYjCpDZZOtAnBx7yYvWqEEO3WU/suWTadYyqSf87ZmtMPgLAgto8fdf93Exi2rGNOQKXbkuPfbXnxJwA5xy+9oFJhrGaNImZRq/ws85SN+RFzKGJRVpynq8Di7Fk6hvnf31eTTcIfyFhOurucsV/Rh23QAdgwOPBfUxpSD2HAOEzZMarlgDYyU0qUUODl7LXTMPFRFu6mIDAjC6Q7RpnnZKd9ioGgJm3AxKZwu7fDdlQgH+YG80Vv+IvcQq4V7kvnmLq08pZM9Jsic+bRPYZUvp3SxwjFFHwnGzPnu11CycYhOQaNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF422QPXb7EWVk6KnAtVgx49zZO0SfPHteEoqEKUsMA=;
 b=j/WqOo1p+sbaPcyHlDctc0rYxKBIdvStsfjQMJFR0CqfwUZCdmHQxWxGWalICN3Nab2KjWr2JUfXG6JXuYItG2JJ7p8TOwkwL4w7yuYECaW3W7zk7ZYb2oRAJAuZTxtZp+FdJLKw6jTxz+sFofzdcQxghRk64kvROsPwRn2zY8Uds5SnCA88q/aPX6bA7CGqd6lAzIQJop5rmZqiN8IqfmG2XiUkqQc6ohPHiYEMGc01Tl3ua1dUdmVIiIH8SHrSE8zAxQL2k5R2/5FOQ0Lt/oZdYBKYJkqXESTvnyjDVNbHeq4o/z6PlPZjahJnAg5IS5a9DJ4ns4JZGJJkxmtNCQ==
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
Subject: [PATCH dovetail 3/5] riscv: dovetail: do not nest the unknown trap handler in software checks
Date: Tue, 17 Nov 2026 13:39:23 +0100
Message-ID: <20261117123925.597027-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: dce8231e-d6be-4ebe-a28c-08df44a7c9aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|23010399003|261022105027099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pRaiHYVZ1X/Xoxu8BuRYZlss5mTnThWBHJ5BoTUuQMzL1BSerOTmw9uMaXhNXqyRKZtrYdQU1LI9RBZNLz7hHvoRrNpNJnK4KCkl8t8+m+kU16egQpvljrQ+i2LlwuqWHSbEDw1l9pO8u9B+KS1UTm7z/3Op5dhB8icFItNq5I4Uxy1U3GUMHjXk4GftGmcTB4qVvys8FeLZYqfXms5cFRXPPaNgpSMe1aWmnYtzuuAGQuwkPvl8et3LfiT9aZGXtxPwv6NogjEbe27EZ7gyifw0x4jPa4Q/hm24BbmrXipv0qH8XiHeXAh31Mb5g9L9N4cbZ2i4LN9LiS/JJ1cNle6gf3s+KTr/TbeP/QYmOPgdpAJm+3+Az3D4K1bdu0yKoAacNStPddaRFC3e3UmkruE+nqJrU652JBSgCRmZc5AiUtkrfL5mqQPjQyd7y7y1fFe8fWQpGs3PW4jCeK3hWM8TrbwznHcFhHJCA/tjcj81ejldGO2HoErM9iGmwPHGRxZfBk3TwVHvlSy/91y787XFzI9TAbsx6iwYOIXdMDfF7JE3zgCYdPmWeIJupVkpgNKt3Tf0RSySo3B3n1hR9UsZ1/JEGMhAUlDfV+9Bsjn2p125Frvf4YMSJF0LSOxlU5LuoRMSL1W425i4nnjWHAR0kcScCh/kX8fA5OpWObw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(261022105027099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8BJR6Klq+Fat5+/RGQh+3AIWr5zivsGRR1Xk5aU4AcShU7p3TZgPCdfIr8EH?=
 =?us-ascii?Q?uyIOXKdCr+Y1Nu6FR9qopnurOaYXsSYBsvlJm1D1m3pMDrsvn+NJFHgHIHdA?=
 =?us-ascii?Q?iXd9yYzAAxSfPuXYHaDlP8MVbPnB1RG+vxac7e2beBA+kzJwKP9j+W0QVnkD?=
 =?us-ascii?Q?IdrNf8aUdJ0XFWM/zHRXNMMuh+t6NAJPo30es7xyHvBic+C5FkkRKMk9BzS9?=
 =?us-ascii?Q?CqFFjUCIBBt5GWnp4Eq7uK/RJuVN2TLzkYv5HnH+bPIznTbXYCdqrgovk/gG?=
 =?us-ascii?Q?E/Sv0uV/l9Ic4rtK3ZikWO0/N6UjKYzKunlRYe7fL5L2zwyFyysz8bZ5a+vj?=
 =?us-ascii?Q?s25wyBd3rrG/cVhUs0pPA41kYjo6bThnv5sscljHpL/Zt/xl/sT8co8N0Rn0?=
 =?us-ascii?Q?m1ke3AyjFC230RbV7io/zQhSMSBXHE8lk/EjE1Ecr2PNRemsuxuGX4UnEuKQ?=
 =?us-ascii?Q?d/HQt45V2Or98akosNxyVmUkFFcXiZngQifLf9qkI8Ywq0ImipZzzd1af88E?=
 =?us-ascii?Q?RrdNubbfXG4WBPlx8RUpg8UrdzxlKO6Q9wvj0BftUicPhJo/vggYZqOnYNuJ?=
 =?us-ascii?Q?SsEFe8Jg+duoMBXf9P2fUud65eatbpra9ajxuTo7hZ8M9Yjycv2RA6SIC8Uv?=
 =?us-ascii?Q?noKEAU2qAjZOCXoQhRjwXF051RPNFGJRgc5ETyusRHczdmqpzYd7zxfSxfDL?=
 =?us-ascii?Q?MJu1Fda7Zj7Y1JWWxfdTBqTWIiLyTTcwk9h+nziB6SlZXl6cuhDTBqmXPZFQ?=
 =?us-ascii?Q?8BI4dIQ6RXP6VQcb2wIzyypBj6Gk5gMQi1+eUF+XinUJ8nXAL028xa8txJkd?=
 =?us-ascii?Q?Sy02yZU8EP6+QKmyfjPZ6xbvNOOF2G4G2cB0g/1ZplfS6lRB+ODjO2o1l4mC?=
 =?us-ascii?Q?62+3TtR3YZ7/o/XWIs5Iamq55fl7NbFJMkKpmpI+sAr6ECPTgTjM0J4u9808?=
 =?us-ascii?Q?z/qmSRrvWMVk7fV6bjZbcWjDfeN912zyQJV9yJjnXPIdANWTf138afrT0Fs+?=
 =?us-ascii?Q?N0XuGxCsVjNJsciP1PNafGK7Of04PZ7qwnWFg4KvjZxne+HJOs3aqlKvhRyH?=
 =?us-ascii?Q?A0NBghLwsyVKyz7CKVJxgq1TAGUZp4zolWDzzYKZb11XN+AuyhOiT9PYa02V?=
 =?us-ascii?Q?no7QEc+EIsZYT5pgZms430nlwBY386E3li6YOMV0OGxrNIAMPjgCCUinUW+M?=
 =?us-ascii?Q?5z/lxS0HTKSaAYgzcPmIV71b3KfwVr4z4v2JVbR2j0bPpmmN2c464qUMIGhM?=
 =?us-ascii?Q?i+Q3XU8RVa+ZH/k0liR6RbfJyZB7h2PVXduOoPju/QJE1WTN+248zLCq3661?=
 =?us-ascii?Q?udr78fHn945S/hzEHtBZTFEHtO31KdGbCWmYHvbYDSBsGf/I8H+yisXWKHaE?=
 =?us-ascii?Q?Gd+q41CIXjPky/+G+Tp6rkLCvMojRkxGXsXAc/s3lpdeUn+9JQBHb046Y60v?=
 =?us-ascii?Q?RUW84iydQNxm+Fe8OhI8ZCR2ye6yoXjNj6fw+v0/yumFUQdZuAkz3fYxq4KW?=
 =?us-ascii?Q?j5g9z0JFx3N/nwHEN64fm+GTe9iAjEDpzWMRPA6dPrLezPrC+oSfnA9E98y1?=
 =?us-ascii?Q?9LThJxce0tkoAqSxsIzc7/2Cq24Uh2omTX8F9U/AuIp5adVEHVfZWgmmt5rM?=
 =?us-ascii?Q?qBftN8pbTItbOKyUA6+K6xDsx5MazslYoIJi3y4Npd8MhbFiaAYsrVQRIklq?=
 =?us-ascii?Q?kJhAmykYwUAt4WSO3Ek6JvtQPC2FJeHMmkTQPtq/T/LS0LXX4pGixX3RW37d?=
 =?us-ascii?Q?j2K+yuHeDCUUfGrsdeXy+WD6coKawNXaaWoCUYIvqUTRimmYbCmMQLV53/19?=
X-MS-Exchange-AntiSpam-MessageData-1: VXg7SEMlHq7McWNSQGv8mm2gm13cPGEtW3U=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce8231e-d6be-4ebe-a28c-08df44a7c9aa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 12:39:14.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZLDL0g5rk5AhOrk20YFjpKxMrofIj28adgO65ylLcf6ct+LHy6ZLPxmhngHEw01cNX8BDOgmFwA9OQsmN9Qu/LFuH6FtJLjHvkCJqIXwHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992193

do_trap_software_check() hands a user mode trap which is no CFI
violation to the whole do_trap_unknown() handler, which enters from
user mode and notifies the companion core again on the same frame.
The nested mark_trap_exit() unwinds the trap before the outer handler
is done.

Call do_trap_error() as do_trap_unknown() would.

Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index a8e37ec27cc2..dddb30711440 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -473,7 +473,8 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
 		if (mark_trap_entry(regs)) {
 			/* not a cfi violation, then merge into flow of unknown trap handler */
 			if (!handle_user_cfi_violation(regs))
-				do_trap_unknown(regs);
+				do_trap_error(regs, SIGILL, ILL_ILLTRP, regs->epc,
+					      "Oops - unknown exception");
 
 			mark_trap_exit(regs);
 		}
-- 
2.53.0

