Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9C31AF24
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237197; cv=fail; b=auoXby+dheW9XMgqnAAf+EnokEQ2JJ1okhWN0zPPUUu3xYuhnOcm6HKpgF/Z+0yYmn3oNFL12ZQVTWlIJHVm4B7mVG2U3in9KTPRWmyjslnwU9ZueO5R6AFZxC3kEjGJqmmccPBvPtbL5gwDf+1OO1B4CxxRIRX7gLy+y4B/Lr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237197; c=relaxed/simple;
	bh=3EqgSslSzCzq7BoDVmhM4ATu3l4kx4LEQ2wAObHHmf0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Um4/YG9rfNqO2JpDS4Jr0QseS8JQt53vY1JORZ/1MCuZufixZ06QkFvKDA3z/aVwts6Ds/xKAZUC18qTQxegeAYqMCaECUnwMpWcs7EvxgAqoNvNYXymbvo4HZF6gn7fBasK4KTfQj74DgEBzAYroXLTh7ogZ9ad2Ym+ymwac8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kUj4RcJo; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kUj4RcJo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF/2u4uz/SVvRxxyQCE5yrQuSMxvnyZhPLsFowu/hmcCtJPVTBDGuPQ9ruCuMc5/3KR5RvGcCnJuVPbe72Wgnt/ZjZ9SjZUNLRiDTAsmFuM0yR5g2QimkJAhkBXsUseo3Yf37UdvFq0o5qwBctT8HnPsgjsnWUkP74qqe2fd2lwXS4XMWqGQ52YrcEk6qnY350OA8p82+g4qPx8/ioRGnBfuc34vfKxSQBqqTXkC5jpDsaRbO6Ur6fQBAw03c3ElqW3FmxEba8zuLVsU02SL4ZUv7Y2Nfqh7EXypv3N/zD6mg8w/5JJIisfkn72TsJ8qKxQ3t998gXdhjU+rPft9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF6bg0ZnEhuoDS52ijMxgZktM+QQhquewdVpIM1NG3k=;
 b=UeqhC/Ubhz9HPYW7+B5bBD6VCjiuxOFvyig1rRA2cffNgnmz0E71/1jaBGiKFvnjJt4pPWYn0r91U8jw6YCHyUtEtMeN3XiOhKkP+3HUwmktlP23XfmA9eLmG0vlyO4/p5rvVdQu0mSHhlWJEJ2MZ/xYu3O9DglehYXdfK5GQ+ooIfyP1tgdtV/cMa2ijuBDLnepfaiyDZdFw1+7LcuKuQQ1wRVcXDJ6voISqHjGQ8o2XJTG9JYudRVpRmhTZ4fXcZucnUIvW9CLZhb951ZZRb76yHKlx8/ldxLHd6KVXfze0cSoMxzsWrTOsy4ZNkkZWr324++6C/afKqbwdnJuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF6bg0ZnEhuoDS52ijMxgZktM+QQhquewdVpIM1NG3k=;
 b=kUj4RcJo40XzjTi9X4Rmcj6N4S2LbmVByZ3Z5Rib62CRKWyxAB3Itj3LJcEMgYxBSQQBSYM3Djq78QuwG4T5UMC60NY+sfvR3zs+ybvPsNEHx0ZfIDnDW7kHr7bW3w/zq4q9pAoG+9z7gw5LL8vKsbWixddCQnpE+rRBJLPQzmVddBqIv1/9dO1acnRviLZTiTz55N8W8uQOIj7mX2CHzKDmRk9Bz9P7AvGmMQlqB3JbrBSHfck4tDh5zq3qEXjveIRl2L8ztQYzFrZCn91XAi2P627JPIgSXGRju0tv+otUurP0hSFmoqAEXRzYopPBT21LSzBjZeJGTMuvGEC88Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:13:11 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:13:11 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl v3 0/2] Add RISC-V support to EVL
Date: Tue, 28 Jul 2026 13:13:01 +0200
Message-ID: <20260728111305.2699306-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c4ecfa-5a36-4d46-0bf0-08deec993625
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	qAG40HfRnZNo88v6WXpFNfEKow3f1J1SjxeyWEaGTXMJj0wqY8Wf34oqLbM0uIiIMb9QRK5H2qF+iZQA7QNOaDiQ8bjgw3w8mVAEsQKfOFmVUVqcxfzv9DzCdmAaZZRmHVC/3I2cj7Q3PfBSi4UmlnW+gtUva5axEnTlGrnGNJxd1y9II1capqWb6omhvrqLyit6yupA1sNrtrsR3NAKw0Nt3kCBH46AO2ABs5127lXCTbQPr9KWrM05jnNcBlQ9Lo7MvpeQhhizvu0f3IQuFD0wMf05MD3gcycbSWVhvSIPD04tY7Ta2zXLvAgATTEu7WqU+gNszKwZgAKTYt64aUO/4ZlaSDqo5TRuiYN5dPb+51LFDnuvVwxN+iNk+VHm0h4MGSboIXvuTDp7JOJRmubszc6Yed1SVv8Xl+xYWwiTFccnQqzXhcqm19YnmUrB8wO9NantePOzfOxrAmkoBcRjvpEhY9OQwSUW8w6z0EP5pUMp0Am9hmFqIpA3amI9EZtyZfudUhZCWVmkmZF7bo4N/q7k13wtGNcZwC7u+KLU+JLKSsrSkIDy7poLu4dP5uGpbwCxaVdewJMzvUoPcJyt7LdSr4I5+z1lMb6d4A21wRTAs5xJOuMunVhykoUnyIhrNGoHMQutEg+QsnUZ+DS4/E86kn04MvHaVGqpvRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3VHa3NGaXBhQzJHdExLS2lJTzJadnJsRmJVOFlGRGxLcXVhMi9Xc0ZPT04r?=
 =?utf-8?B?N0VXc3NDWEhESHp4SGFRckRzclYzbW1aYytxNnVVcjdST0tYT2tFR2ZQL1Zn?=
 =?utf-8?B?TjhqS2J0Y0s4NVplZ2hucFZ2R0sxNEI3eVVhZjNMQ2p1d2xFd0pZemw2RWlZ?=
 =?utf-8?B?Z2tsRmRNTjd5cWNlR25KMXFrSCsxdVF1NS9xNlJFdlRyNDZQbEMyZ2ZhQ1BJ?=
 =?utf-8?B?cFRpdFJDUkxTeXdKUmZHZU10VmY3R2lpNHN0bnhlVjFLVTVaaVliSG54UVV1?=
 =?utf-8?B?V1VHSEpkU29NaHFkd0JibkFVejQwZENUSFRaQml0eUtqT0FIN09IQ240OEJv?=
 =?utf-8?B?TE8wN2VFNmcyUXh6QUQyMWY2cXA3bmwrQzVkQk4zOGFiOFBnaHFBcTY4UkV5?=
 =?utf-8?B?QUJROTNJSkZidW14K0MxdGEvaW9RRXdidFB2MDRyUStlN2MxOTJpdW42dklp?=
 =?utf-8?B?OUlhaGNqZ25NN2lJaytUZjBJRGxoU2Nid0RzUDlXK1Fsdjl6YjFON0JjM2xW?=
 =?utf-8?B?SElpWDhvK0VQdTg1bHY5dG05NUpGZ2ZXR0p0SllLckpKNVdiT0tlbk1jalNU?=
 =?utf-8?B?WFBTU0lmVUFLT0Q3c1NQOVZoblZ0WVZtdXRNVjhoMEc1QXV3a3Rlb0ptVE5O?=
 =?utf-8?B?cGdJVkp2MFI3dmhidFlMdUE2eWFCUUo0TU9jTzNBSXBzVkpjRTExZXJZSTZl?=
 =?utf-8?B?YzRyMGlpYnhHdFJxc241bVJnRmZ5aFEzM3VnbUY2RDloMUNKYWVuWUMwYWF1?=
 =?utf-8?B?RGZ4YW9IYy9reVBHOVpxRDlJenB5dXdmSFBWOHBTcTJSTnRVM0dXTU5qWThY?=
 =?utf-8?B?eStVbzNNV2VndnRKZkhFZXhqL1ptVGZCRUx5Ym9BbnNTcTZlVDY0dndlaHpx?=
 =?utf-8?B?bDNoNmZKYlNGK0xqSURKTldFSWNkLzJJNHJZZ0taT1NOVnhxNFdsYmlodFRw?=
 =?utf-8?B?MFQwZUVzNmdLdVljN2x4ZEs3TDZxUEdqR3dyeHlwYU9tMnZHQ1M2MUR1d0Jx?=
 =?utf-8?B?eUl0M1ByQzZ2N2ltaXFyQkcwbjRqTVErbGxVK3Z3bmIvd1NpN1JkNWlTVk83?=
 =?utf-8?B?ak1xc3M3VzlmOFNXNUVLenJvRC82dFFXMGJWUUl6aVBrZUEvekpmUTN3anhh?=
 =?utf-8?B?Zk9kaDFQMWJkbG1CVnlMaU9xdGlpdlBsR3V1ZlVsdDlYUDFnRWMrYWFoUk04?=
 =?utf-8?B?TlNTVWdCM2p5L1l2czhXL3pLeWo4NUlmNlp6TzE4QUNnQXdCSGwxbmRXc3dS?=
 =?utf-8?B?Ykg5N2ZCWS9kQkNqUlJFT2FjNmZySXBhSmlHSmtRR2w3Qk5CSTR6TjJoVmYw?=
 =?utf-8?B?cTFMLzg2MzYyQTVMN0lWT3hIc1M5MG05UzUzeDBkb0RLQ1pLazc5MFE5ODFD?=
 =?utf-8?B?U09LYmlrNWpUTDI1L243OC9heXBvdVNvMlpZNnRIWnJONUxIdW1NYU5WWTEx?=
 =?utf-8?B?d2I1Nllzc0dvUDZ4MUFjeHZtMlkyY1NmMnZUb09XczB5SmUvaG9SU0pPaTZ6?=
 =?utf-8?B?N0tzdWpVVjlKQU9YWDYzYWJ5N2tVVktGVnJQSzlsUDRxUlg5RUF5c1pMRHlX?=
 =?utf-8?B?L0U2eWR6cDlHWTRxSTh3anpRR3huVUw3b1VWL1YyN3phdFNOVkN3VEU1bXFK?=
 =?utf-8?B?SUFJWUM5cTNIU2xXYnNnamdBTE5VcnljNEFXai9vUXVjQi93dk8zdXdSbXZS?=
 =?utf-8?B?WVEzL1FFakg0SjV1UWl1L25uZ0NQQWVQTENicVZ4amk5WEMyd0lKMFNlTEg5?=
 =?utf-8?B?RmZpQUlmZGpOR1c0cE1xMnVETHlsemlLM1dTRE9GcDh0SlBSTnI3T0tEMXlk?=
 =?utf-8?B?N21xVk5jdEJHRVB3M0tORHc4VXFla1NrS1pydGpqYjJ1QS9YcXY3YWlCeHVs?=
 =?utf-8?B?dTM1WnNqckxRdXZYVGNMeU12TERNTE9Cc3F5VzlaNWNKMkJkQTdCczZSQU9E?=
 =?utf-8?B?Nk5GNGk3cm5NWWtsNHRHOUFGbkNFTEFTd2h5Ym9zNHZzRmNZcWVtWVdTNGo1?=
 =?utf-8?B?R0ErTXl5TXZvazZ5UGlIZWtDK1V5R1V2SGFwREJ6ZURMR2dhVlQ1SFIxMnNQ?=
 =?utf-8?B?djJYKzRUUk1zSnNUeDhJUDFjaElJd3VJZFdYakEzcEp1dW0zZC84QzE3cEFt?=
 =?utf-8?B?eUx0M2dqQStaNHc1MWdpOG9TN3kxbTJrNzZtcU5xeURzMDFxbEh3d1lyL0tV?=
 =?utf-8?B?VjlZd0czZTdnVjAzQStHRnNmS2twTzRyb0JiUmFYaUJydmROeG9acS9NMUc0?=
 =?utf-8?B?ZEN4QWNlV3BUWGEweGh2am5hYzJOeWE4MmhvYVcyclQzd0JoeEFOQlVES1Bp?=
 =?utf-8?B?bXpRdjBZLzkwdVV5WUVXbDcrN09HaG9GcGFRcW1ZYm4vV2dYQnNpMGkrMHpa?=
 =?utf-8?Q?K8tUVY/dOdT5l/1g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c4ecfa-5a36-4d46-0bf0-08deec993625
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:13:11.7373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZWaACfZRKjW/88JTctBZt07MupyjH2Ga8Y6nKnNjYJ6GyQIgKchjpOJwYPOMVYWHiaLKgrfyBeQXPBzNrXzHuZxlUWT0zfsc/Ep8QV+yFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

Hi all,

this series introduces an initial EVL port for RISC-V.

While some tests are still failing, I’d like to share this early
version with the community to gather feedback, reviews, and hopefully
some assistance in refining the port.

The patches have been tested in combination with the Dovetail RISC-V
port on top of v7.0-evl-rebase.

Looking forward to your feedback and suggestions.

Changes since v2:
 * Remove shanmu as patch author
 * Cleanup license header in fpu.h
 * remove spaces before newlines in inline asm

Changes since v1:
 * rebase to v7.0-evl-rebase
 * add missing guards for building without evl

Best,
Tobias

Tobias Schaffner (2):
  riscv: Add EVL core
  riscv: Add FPU register test support

 arch/riscv/Kconfig                        |   2 +
 arch/riscv/include/asm/evl/calibration.h  |  12 ++
 arch/riscv/include/asm/evl/fptest.h       |  31 +++++
 arch/riscv/include/asm/evl/syscall.h      |  25 ++++
 arch/riscv/include/asm/evl/thread.h       |  12 ++
 arch/riscv/include/dovetail/irq.h         |  11 ++
 arch/riscv/include/dovetail/mm_info.h     |  11 ++
 arch/riscv/include/dovetail/net.h         |  11 ++
 arch/riscv/include/dovetail/netdevice.h   |  11 ++
 arch/riscv/include/dovetail/poll.h        |  11 ++
 arch/riscv/include/dovetail/skbuff.h      |  11 ++
 arch/riscv/include/dovetail/thread_info.h |  11 ++
 arch/riscv/include/uapi/asm/evl/fptest.h  | 137 ++++++++++++++++++++++
 13 files changed, 296 insertions(+)
 create mode 100644 arch/riscv/include/asm/evl/calibration.h
 create mode 100644 arch/riscv/include/asm/evl/fptest.h
 create mode 100644 arch/riscv/include/asm/evl/syscall.h
 create mode 100644 arch/riscv/include/asm/evl/thread.h
 create mode 100644 arch/riscv/include/dovetail/irq.h
 create mode 100644 arch/riscv/include/dovetail/mm_info.h
 create mode 100644 arch/riscv/include/dovetail/net.h
 create mode 100644 arch/riscv/include/dovetail/netdevice.h
 create mode 100644 arch/riscv/include/dovetail/poll.h
 create mode 100644 arch/riscv/include/dovetail/skbuff.h
 create mode 100644 arch/riscv/include/dovetail/thread_info.h
 create mode 100644 arch/riscv/include/uapi/asm/evl/fptest.h

-- 
2.43.0

