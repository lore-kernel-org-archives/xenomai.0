Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576762E8B9B
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432711; cv=fail; b=eveMsowghCshkFDqykoiZXEVa6V/7zenbXf9tyKpPagP3YJPBlL1croWTyxMbprTmdIuaYjx0n1LU8FB5hgCNmukHhOVI+BvajkwwEaXPHsHK7PIcy0IcgBRQd2R5aKIsw8yPeunTzjLWUgERfwr0q8RbnMh4JwS0oA7vKv5Uww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432711; c=relaxed/simple;
	bh=7iWM0fuYzDB4Hck0tME7/o3E38AD7WXmcuFpLkIMYTs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eF3Ndu45Hoj1twbrDOfLJJfu1pR7cUeI0rnm0CKDeOpy71Zj/rKIPcs73DavCtiVcu6d8TYPwxrMgGJhmeEzhhXL95FWz7KDALzpWEVMmYMZ544KWq4xQZ6l7ttJsZ1W3WcXPunMO0EOyIM8aUr/hfhxJiXplETMigCG6MQyUrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NjluMav+; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NjluMav+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym7sKE9yL5iJcaOJBtEuyvEQXscgFJ0cf1QpcoPS1zFpGdt9uQ/FotNDZSupT8WPZbKVuyMs5OpWiqC7xSWIkcrA4gfMf+VRNl1HSS7jNGrRJgH1NjTInkYBytJ1L4s9KUBYkDbGcf3iKPvEVzBF2KK98fGHb/+iUxPQcli7uvUt10NLfl6ULhouO+BwQGLvC0LCaYtngkTdMI1/qTJrTZqfEzeQ/C7cLoAAktFGcUVs71RHEvjRHytquLp1y4NOPJ2IqH2LBNducl5VPgnMWtV6ka9I06/mkRssljjQe9j3m5JGVjbUBD24ECEHipjRhpdgWFf38CfFW8jv7FSGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG5kjg29EPWz4yHL11N6heqIGk0h3t5bOL+EVKNYjW8=;
 b=u79eubh4iSrgpWL8040baEG3XjKLtP9Ijk1RJRDq2TTpLfgxImFfdJ7f2HmEhefbOkgHr45hxxB6kKRoH3Igk5qB0BMGXQ4WPevqUG5h//G0VDGA7uGU5ky5L2cHvaOY3AYd88V4rREGsy4GnbYDLgeIDr39nkFJNY5r4QqneznavtkRDzMHgsJLRIGggSwpjvD6qoqYpZ/mFNJHBi9queoM3jre/4miw2vHMsGVe/8Hrt5rGclbq/dYmAh/gkYv4G/k8sXf7DHb1uufpr3uxFyHeN4G4k9KvUKBcvMWrp4Dap11FDBZ1q1o7WleHfGogwIkEgIrDTWwzGCAfJH7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG5kjg29EPWz4yHL11N6heqIGk0h3t5bOL+EVKNYjW8=;
 b=NjluMav+/YfTl3tjOpCsIK9nnOWn9keW+bLpAE9BGcsx+G9iLIICduMAN8Ahn9BJy9qji/tnhinW+8bzYcPtsJRnOEYyILw1bIOrRV7pafuqpsDTXCpe6RbJx66VnS7efOpyBTDJ7bwxGOL0wzUzSW6TZv2rfgUUbNxyYaI6aj69nOIOqoEOVEB7Un61VW3IwuC0gyePvIIBt70bQrdo8nLZ2JzwjpHbZ/ufw6ilKpMz0/ai2lJpTzHR0rfp2W1pAghNfKfmpb9xbJnWXc5cKNk0eSbAruJsgDB4LPnh66FLwQMvNlhigSDdmHv1NVmjAoh2usUXfoVhj6IYhrNV3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PA2PR10MB8819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 12:38:26 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 12:38:26 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v2 0/8] riscv: Add Dovetail support
Date: Thu,  6 Nov 2025 13:38:14 +0100
Message-ID: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:610:b1::6) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PA2PR10MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 48731b6e-64ce-42b2-d9d7-08de1d3161b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gg3X8L4ypvTttP1MtM4horTQZMOUt8sz7YwwAwwYfG2gEQlSD+palQJBNjvm?=
 =?us-ascii?Q?fGcPEJR7HoHNmwZNVN2DIX9lPv+dVI9RtJKNndSpy2FrxG1HT9aS7sjiWOZA?=
 =?us-ascii?Q?xZUFZq9Oo+KjbCOK5FO3d9YMvdYUSBBEXdKPsMpQVcIRUW5XviAQNJZMJdTp?=
 =?us-ascii?Q?ku1sG1Q6veoYE4QdTe6F5XudohPTNLx6HoAOBYmhuxyZXzHhBz6ocOodZX8a?=
 =?us-ascii?Q?xjP1P2GmraxzwkDlK8sWLWSOYEYFVCOSym7Ee3YC3kr0XdzKxFKf1cg6fzxC?=
 =?us-ascii?Q?JGAnx75bwVcEj4Gx+/GWEJkpzKjuewZ5bJVC5LrhaWJSV42iX5Y6+l4WT7B1?=
 =?us-ascii?Q?tPPyv+wFfL5Lhn1WZfDfw8gRgfE/UTdW5f6IHpr6H9r+vTo//aBXcQzIrdVL?=
 =?us-ascii?Q?NYZEDj4RsjnDCdAuWVPgXe+1kGMFsv48+jw9rr+pKRe75kdkUTU5y/8ExEdo?=
 =?us-ascii?Q?HRfvnedGXzQvHm4VcXuCjhAHXCiiZnrpalLvK8j42D5pX0S5v3szt9Ena9Uo?=
 =?us-ascii?Q?9vSD7IQQRXSLT4mHG6yAahf5E4rF5A3CH6EoU9FurWrdlipMOILmDB+WvFDk?=
 =?us-ascii?Q?BL8EPP1AP5LgrIYobcoduWx2kOqMIYVFNgHaaizGIEE36lkuS2oMiKOqs9sV?=
 =?us-ascii?Q?j1u8ceKBf8IPr1tQbNpvyRf66u1hW35a415YGIHFjDUj9sOjSPEZsYLE1VI0?=
 =?us-ascii?Q?IM40IDHR+kgIN/ehnHDOGdQEBoV/7VO/5jB2fL0G/j8N6A5Hwxo3fWUS0Agh?=
 =?us-ascii?Q?fbORAi+mc4u2ruivX2sb9a+qkvi8HmdnNdHxMeOx0wndwkeL240jY9KtcXl5?=
 =?us-ascii?Q?BR83ClQ31WfuI2fYxErEbLUi5OUaTflK3mcG9yE8UigXKxMAHl+N3jqGKnp6?=
 =?us-ascii?Q?J7zfmSKmVv+xEVohVRO16Pm6KG0nETSbwOCSG75LjBnz9N0M3Dr9DNY3JPb1?=
 =?us-ascii?Q?iYVI1dS+0kzPKfJ3ufVXAMgsL9eb3uQh4xZOyC6iTpb41D9TpiIVSsnArSdZ?=
 =?us-ascii?Q?ex2Qka0R9RgHO7lJX2IIDfXJzmFBstCITuXOPa3sehQOZcTgMyKEYzhWpngD?=
 =?us-ascii?Q?sB7gLQLVS39fBHK54Z3ouLUec4ENB7axl8UmejS4F8+z3tvOXypBhiVaQOur?=
 =?us-ascii?Q?J+ldTmSrzqNr+d5iHcy8/sFjIu4oPm++RefRm8zgNLBbVcJHZiIm2oixBeBr?=
 =?us-ascii?Q?ZGyJ1EuuXoABpIABdvyw477f4N0Xl6FjW/QTwbxb/BqWcI8wDBN5y+C5QLDB?=
 =?us-ascii?Q?RdhPE8JnRjwJmPBlM3Jcacsa4f4aWDmZO/uAXPQTu3PO/Mz4U8ujyRZmdf4B?=
 =?us-ascii?Q?2fPPcI4gXggw7qYaciNNAAuPrjWobPbz7X7EZ5I1nVrTG4Ogw+dOMIU6Phs5?=
 =?us-ascii?Q?XE68QkH/AKcuww/m0lG7o3Q8315WUAP8zgWvO8geQpfsCnlbomS+CLWVWDLP?=
 =?us-ascii?Q?RPYcnKYUa3aQaRDIY2UYNh3opziTAUbi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4zo0IvacyMpo0emtg4vS7FIRu7FQW96a2wsQKHU4IAAx+OCq7ZXr/zjef6lE?=
 =?us-ascii?Q?UVthzX8OwnduRQahvKluHn03BEB18R1T8P5xIYmp7qmV9FOedzHuINSlVQg1?=
 =?us-ascii?Q?2O6eDpyKnGwS01nTi0t0wYgUISmasreA6vfYORqyA1G40/7qxFzUDQKVBHRX?=
 =?us-ascii?Q?vXt6igZUrcblEx6W4Yu2HvtPpk13ugTBOCvC6RNxqWhTLIrVg9cH/sDTeDwM?=
 =?us-ascii?Q?oz9nuEmEzQEPT6JYNQjLI1JtyDkE0Y5Q17pHz2hxLnMo44s6Jt/kRCsjahds?=
 =?us-ascii?Q?qA/IA+VK+/WwcHJP3Ztj9X4HxQzkw53KhQMRVm/KfcPs9XkjTmQlYuvOVyBR?=
 =?us-ascii?Q?oojL/Xk/a6P8tLii43FSnOZ6mIZ8p+rCjb1QRNiHs7rhTqJuEGTc2Y0xcH71?=
 =?us-ascii?Q?Bz0EOqOlxPVvxjxoDa7j4HZzEkNxkP4fjXy3BVonEHTK0C1NHHPY6Fi1aiYs?=
 =?us-ascii?Q?5Pr6RirKhWnZoO0CFgivXD62GiJUDf8HQUnJ+uL08Gi+nYOeyS6AS3pk/Bn6?=
 =?us-ascii?Q?AZPi2oVU/physrjS/u2dZDHczMafeNm2p2agHEx0FV938Maazmv7wmDJdYYj?=
 =?us-ascii?Q?PyxQN65Wnj9y575mix+nq9+kOau4B/UnrDxsj2zYe9YflH+I2lLP6YttAWcS?=
 =?us-ascii?Q?Ui1o3tCXTZ+G/h0sxH1QAtNNAhpR08opiQJn3YspWVFJGq869/SqDl/lMiDD?=
 =?us-ascii?Q?/RlYv9bPbAvs0wwcgZF0BpFThCBjC6I2JXp3b+N/tUG51WXQasdcfzaZ0dbW?=
 =?us-ascii?Q?U4H5LqU5TScOYOY5Ci85TYiQzUMQcekjr+Bky1ecMyUDa1Pil3PO1As1SSFX?=
 =?us-ascii?Q?xYz2Dkfr5I9wLA2hRsXRmCSdyRTNtud+pPiqMikeRIn6HFDdDeIfU8oKKDlQ?=
 =?us-ascii?Q?7wiQPL5HA69qx0MABLi8CTwVRMnPEViFvWBBvP1WafQHIggewC+9K1hzxsE2?=
 =?us-ascii?Q?5tSs3+Me5uFDlODmdQAlPvaHS0ifctSCVUYyndsKR6IpXB+ZMOb+V8Hbt5C1?=
 =?us-ascii?Q?aGlU9s5OxFYKesL1aDbZJmQvN0+c/61EHtmtmuGPWjtkbSIpK8/H9tCyk76v?=
 =?us-ascii?Q?W1Tux5mItT9uIRyzD212RdoZ8EEInY4vXpUl7qFl65Yx7Ujmj8Ml0YEdAo4t?=
 =?us-ascii?Q?HP/J8HkNMFAjhfg7vBR/4ZMIjBSVPPck/HbWH4Oa5+dTjeClZ/bc3ew/fFtd?=
 =?us-ascii?Q?xtWJV6wHnxK4OR8/mTaFIfUuNZ62oluej2kzaPlc9FkK5+5P2f6QOoUjuYpI?=
 =?us-ascii?Q?tgOf2nc47V/ltCeqdPHbV27q9jkf1b9hKDh5mAF7oTtzji1XddEAA+WMzzfY?=
 =?us-ascii?Q?g+1MZZgRlwLZwWQezsHl7BzEYQjU4ScoTYJdXkDuAdj41uvawjcbo8kAEEeo?=
 =?us-ascii?Q?oUH665X+19WO9Qw4OaYucK59bd5fYP4Gyh0V5DxAE37RsolW0Gnr+yAgtUne?=
 =?us-ascii?Q?m/gbQyBQDy11R+yjXc0XG1VmCV0sPm/em4v/QKoW+LIFix5zqs3dsf3/4Is0?=
 =?us-ascii?Q?zoT5UZzN5wkbKn6htT1ubCEeqdlCn0/F8llZ4eZ9BvKIX9cmBSEc8sJTwfWJ?=
 =?us-ascii?Q?bi0mLaOoV3PkS14X9d9jegerr0MuEUoZIRAhndMBTLL33BXJLsiQ9kwPVvoH?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48731b6e-64ce-42b2-d9d7-08de1d3161b2
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:38:26.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98xPBuRcDQ55mh83DoVfQOzqPKPF+R3eRgt947ki5tQgDw/1F/u7/F0+ZS20lJWLTVmfiI3iRLtQw5gStIcasr1dYo9RCEIyDg5YwRiJd1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8819

Hi all,

this series introduces initial support for Dovetail on RISC-V and
adds some fixes to the current IQR Pipeline implementation.

It is based on the current tip of the wip/dovetail-riscv branch.

Feedback, suggestions, and especially reviews are very welcome.

Changes since v1:
 * Fix bug in pagefault trap handling
 * Disable independent irq/softirq stack usage when pipelining
 * Drop KVM changes as long as they can not be properly tested

Best,
Tobias

Tobias Schaffner (6):
  riscv: only store interrupt enable flag in native_save_flags()
  riscv: restore exact interrupt state in native_irq_restore()
  riscv: save program counter in arch_save_timer_regs()
  riscv: add initial dovetail co-kernel skeleton
  riscv: add out-of-band aware trap handling
  riscv: no inpependent irq/softirq stacks when pipelining

shannmu (2):
  riscv: fix interrupt enable/disable order in native_irq_sync()
  riscv: add dovetail-aware memory management

 arch/riscv/Kconfig                    |  3 +
 arch/riscv/include/asm/dovetail.h     | 23 +++++++
 arch/riscv/include/asm/irq_pipeline.h |  1 +
 arch/riscv/include/asm/irqflags.h     | 11 ++--
 arch/riscv/include/asm/mmu_context.h  |  2 +
 arch/riscv/include/asm/syscall.h      |  6 ++
 arch/riscv/include/asm/thread_info.h  |  9 +++
 arch/riscv/kernel/traps.c             | 87 ++++++++++++++++++++++-----
 arch/riscv/mm/cacheflush.c            |  5 +-
 arch/riscv/mm/context.c               | 18 +++++-
 arch/riscv/mm/fault.c                 |  3 +-
 arch/riscv/mm/tlbflush.c              |  5 +-
 12 files changed, 149 insertions(+), 24 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h

-- 
2.43.0

